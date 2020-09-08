unit Com.GitHub.Pikaju.Protobuf.Delphi.uStringCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uDefaultValues,
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uVarint;

type
  TProtobufStringWireCodec = class(TProtobufWireCodec<UnicodeString>)
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: UnicodeString; aDest: TStream); override;
    function DecodeField(aData: TList<TProtobufEncodedField>): UnicodeString; override;

    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<UnicodeString>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TList<UnicodeString>); override;
  end;

var
  gProtobufWireCodecString: TProtobufStringWireCodec;

implementation

procedure TProtobufStringWireCodec.EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: UnicodeString; aDest: TStream);
var
  lBytes: TBytes;
begin
  EncodeTag(TProtobufTag.Create(aFieldNumber, wtLengthDelimited), aDest);
  EncodeVarint(Length(aValue), aDest);
  lBytes := TEncoding.UTF8.GetBytes(aValue);
  if (Length(lBytes) > 0) then
    aDest.WriteBuffer(lBytes[0], Length(lBytes));
end;

function TProtobufStringWireCodec.DecodeField(aData: TList<TProtobufEncodedField>): UnicodeString;
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
  lLength: UInt32;
  lBytes: TBytes;
begin
  result := PROTOBUF_DEFAULT_VALUE_STRING;

  // https://developers.google.com/protocol-buffers/docs/encoding#optional:
  // For numeric types and strings, if the same field appears multiple times, the parser accepts the last value it sees.
  for lField in aData do
  begin
    if (lField.Tag.WireType = wtLengthDelimited) then
    begin
      // Convert field to a stream for simpler processing.
      lStream := TMemoryStream.Create;
      lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
      lStream.Seek(0, soBeginning);

      lLength := DecodeVarint(lStream);
      SetLength(lBytes, lLength);
      if (lLength > 0) then
        lStream.ReadBuffer(lBytes[0], lLength);

      result := TEncoding.UTF8.GetString(lBytes);

      lStream.Free;
    end; // TODO: Catch invalid wire type.
  end;
end;

procedure TProtobufStringWireCodec.EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<UnicodeString>; aDest: TStream);
begin
  // TODO: Implement
end;

procedure TProtobufStringWireCodec.DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TList<UnicodeString>);

begin
  // TODO: Implement
end;

initialization
begin
  gProtobufWireCodecString := TProtobufStringWireCodec.Create;
end;

finalization
begin
  gProtobufWireCodecString.Free;
end;

end.

