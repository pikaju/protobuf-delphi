unit Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uVarint;

type
  // Type representing a single field within a Protobuf message.
  // The data contained within this field, with the exception of its
  // tag, is in the binary Protobuf encoded format.
  // This is used by TMessage to manage fields that are yet to be decoded properly.
  TEncodedField = class
  private
    FTag: TTag;
    FData: TBytes;
  public
    // Creates a new field instance.
    constructor Create;

    // Writes this field to a binary stream.
    // params:
    //   aDest: Stream to append binary data to.
    procedure Encode(aDest: TStream);

    // Reads a single Protobuf field from a binary stream, and stores
    // the information within this field instance.
    // params:
    //   aSource: Stream to read binary data from.
    procedure Decode(aSource: TStream);
  end;

implementation

constructor TEncodedField.Create;
begin
  FTag := TTag.Create(1, wtUnknown);
  SetLength(FData, 0);
end;

procedure TEncodedField.Encode(aDest: TStream);
begin
  EncodeTag(FTag, aDest);
  if (Length(FData) > 0) then
    aDest.WriteBuffer(FData[0], Length(FData));
end;

procedure TEncodedField.Decode(aSource: TStream);
var
  lTempStream: TMemoryStream;
  lByte: Byte;
  lVarint: UInt64;
begin
  FTag := DecodeTag(aSource);
  lTempStream := TMemoryStream.Create;

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
  lTempStream.Free;
end;

end.
