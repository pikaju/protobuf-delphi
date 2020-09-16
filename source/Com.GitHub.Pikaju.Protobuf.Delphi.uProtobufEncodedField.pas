unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint;

type
  // Type representing a single field within a Protobuf message.
  // The data contained within this field, with the exception of its
  // tag, is in the binary Protobuf encoded format.
  // This is used by TMessage to manage fields that are yet to be decoded properly.
  TProtobufEncodedField = class
  private
    FTag: TProtobufTag;
    FData: TBytes;
  public
    // Creates a new field instance.
    constructor Create;

    // Creates a new field instance with prepopulated data.
    constructor CreateWithData(aTag: TProtobufTag; aData: TBytes);

    // Writes this field to a binary stream.
    // params:
    //   aDest: Stream to append binary data to.
    procedure Encode(aDest: TStream);

    // Reads a single Protobuf field from a binary stream, and stores
    // the information within this field instance.
    // params:
    //   aSource: Stream to read binary data from.
    procedure Decode(aSource: TStream);

    // The Protobuf tag (field number and wire type) of this encoded field.
    property Tag: TProtobufTag read FTag;
    // The binary data of this encoded field, exclusing information stored in the tag.
    property Data: TBytes read FData;
  end;

implementation

constructor TProtobufEncodedField.Create;
begin
  FTag := TProtobufTag.WithData(1, wtUnknown);
  SetLength(FData, 0);
end;

constructor TProtobufEncodedField.CreateWithData(aTag: TProtobufTag; aData: TBytes);
begin
  FTag := aTag;
  FData := aData;
end;

procedure TProtobufEncodedField.Encode(aDest: TStream);
begin
  FTag.Encode(aDest);
  if (Length(FData) > 0) then
    aDest.WriteBuffer(FData[0], Length(FData));
end;

procedure TProtobufEncodedField.Decode(aSource: TStream);
var
  lTempStream: TMemoryStream;
  lByte: Byte;
  lVarint: UInt64;
begin
  FTag.Decode(aSource);
  lTempStream := TMemoryStream.Create;
  try
    // Determine the number of bytes that need to be read based on the wire type.
    case FTag.WireType of
      wtVarint:
        repeat
          aSource.ReadBuffer(lByte, 1); 
          lTempStream.WriteBuffer(lByte, 1);
        until ((lByte and $80) = 0);
      wt64Bit:
        lTempStream.CopyFrom(aSource, 8);
      wtLengthDelimited:
        begin
          lVarint := DecodeVarint(aSource);
          EncodeVarint(lVarint, lTempStream);
          lTempStream.CopyFrom(aSource, lVarint);
        end;
      wt32Bit:
        lTempStream.CopyFrom(aSource, 4);
    end;

    // Copy data from temporary stream to field's data storage.
    lTempStream.Seek(0, soBeginning);
    SetLength(FData, lTempStream.Size);
    if (Length(FData) > 0) then
      lTempStream.ReadBuffer(FData[0], Length(FData));
  finally
    lTempStream.Free;
  end;
end;

end.
