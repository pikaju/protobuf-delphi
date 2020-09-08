unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessageCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDefaultValues,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint;

type
  TProtobufMessageWireCodec<T: TProtobufMessage> = class(TProtobufWireCodec<T>)
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream); override;

    // Transfers ownership of the message to the caller.
    function DecodeField(aData: TList<TProtobufEncodedField>): T; override;

    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TList<T>); override;
  end;

implementation

procedure TProtobufMessageWireCodec<T>.EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream);
var
  lStream: TStream;
begin
  // Encode the message to a temporary stream first to determine its size.
  lStream := TMemoryStream.Create;
  aValue.Encode(lStream);
  lStream.Seek(0, soBeginning);

  EncodeTag(TProtobufTag.Create(aFieldNumber, wtLengthDelimited), aDest);
  EncodeVarint(lStream.Size, aDest);
  aDest.CopyFrom(lStream, lStream.Size);

  lStream.Free;
end;

function TProtobufMessageWireCodec<T>.DecodeField(aData: TList<TProtobufEncodedField>): T;
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
  lLength: UInt32;
  lBytes: TBytes;
begin
  result := T(PROTOBUF_DEFAULT_VALUE_MESSAGE);

  // TODO: Merge multiple messages together, see:
  // https://developers.google.com/protocol-buffers/docs/encoding#optional:
  for lField in aData do
  begin
    if (lField.Tag.WireType = wtLengthDelimited) then
    begin
      // Convert field to a stream for simpler processing.
      lStream := TMemoryStream.Create;
      lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
      lStream.Seek(0, soBeginning);

      // Ignore the length of the field and let the message decode until the end of the stream.
      DecodeVarint(lStream);
      if (result = T(nil)) then
        result := T.Create;
      
      result.Decode(lStream);

      lStream.Free;
    end; // TODO: Catch invalid wire type.
  end;
end;

procedure TProtobufMessageWireCodec<T>.EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream);
begin
  // TODO: Implement
end;

procedure TProtobufMessageWireCodec<T>.DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TList<T>);

begin
  // TODO: Implement
end;

end.

