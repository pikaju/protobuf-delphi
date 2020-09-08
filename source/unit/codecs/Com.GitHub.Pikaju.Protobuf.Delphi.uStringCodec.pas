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
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uVarint;

type
  TStringWireCodec = class(TWireCodec<UnicodeString>)
    procedure EncodeField(aFieldNumber: TFieldNumber; aValue: UnicodeString; aDest: TStream); override;
    function DecodeField(aData: TList<TEncodedField>): UnicodeString; override;

    procedure EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<UnicodeString>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TEncodedField>; aDest: TList<UnicodeString>); override;
  end;

var
  gWireCodecString: TStringWireCodec;

implementation

procedure TStringWireCodec.EncodeField(aFieldNumber: TFieldNumber; aValue: UnicodeString; aDest: TStream);
var
  lBytes: TBytes;
begin
  EncodeTag(TTag.Create(aFieldNumber, wtLengthDelimited), aDest);
  EncodeVarint(Length(aValue), aDest);
  lBytes := TEncoding.UTF8.GetBytes(aValue);
  if (Length(lBytes) > 0) then
    aDest.WriteBuffer(lBytes[0], Length(lBytes));
end;

function TStringWireCodec.DecodeField(aData: TList<TEncodedField>): UnicodeString;
var
  lField: TEncodedField;
  lStream: TMemoryStream;
  lLength: UInt32;
  lBytes: TBytes;
begin
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

procedure TStringWireCodec.EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<UnicodeString>; aDest: TStream);
begin
  // TODO: Implement
end;

procedure TStringWireCodec.DecodeRepeatedField(aData: TList<TEncodedField>; aDest: TList<UnicodeString>);

begin
  // TODO: Implement
end;

initialization
begin
  gWireCodecString := TStringWireCodec.Create;
end;

finalization
begin
  gWireCodecString.Free;
end;

end.

