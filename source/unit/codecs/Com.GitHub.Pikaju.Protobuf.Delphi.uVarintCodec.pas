unit Com.GitHub.Pikaju.Protobuf.Delphi.uCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Com.GitHub.Pikaju.Protobuf.Delphi.uCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uVarint;

type
  TVarintWireCodec<T> = class(TPackedWireCodec<T>);

gWireCodecInt32: TVarintWireCodec<Int32>;

implementation

procedure TVarintWireCodec.EncodeField(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream);
begin
  EncodeTag(TTag.Create(aFieldNumber, wtVarint), aDest);
  EncodeVarint(aValue);
end;

function TVarintWireCodec.DecodeField(aData: TList<TEncodedField>): T;
var
  lField: TEncodedField;
  lStream: TMemoryStream;
begin
  // https://developers.google.com/protocol-buffers/docs/encoding#optional:
  // For numeric types and strings, if the same field appears multiple times, the parser accepts the last value it sees.
  for lField in aData do
  begin
    // Convert field to a stream for simpler processing.
    lStream := TMemoryStream.Create;
    lField.Encode(lStream);

    if lField.Tag.WireType = wtVarint then
      result := DecodeVarint(lStream);
    else if lField.Tag.WireType = wtLengthDelimited then
    begin
      // Ignore the size of the field, as the stream already has the correct length.
      DecodeVarint(lStream);
      while lStream.Position < lStream.Size do
        result := DecodeVarint(lStream);
    end; // TODO: Catch invalid wire type.

    lStream.Free;
  end;
end;

procedure TVarintWireCodec.EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
begin
  // TODO: Implement
end;

procedure TVarintWireCodec.DecodeRepeatedField(aData: TList<TEncodedField>; aDest: TList<T>);

begin
  // TODO: Implement
end;

procedure TVarintWireCodec.EncodePackedRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
begin
  // TODO: Implement
end;

initialization
begin
  gWireCodecInt32 := TVarintWireCodec<Int32>.Create;
end;

finalization
begin
  gWireCodecInt32.Free;
end;

end.
