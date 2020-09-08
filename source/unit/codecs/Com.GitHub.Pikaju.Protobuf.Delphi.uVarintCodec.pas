unit Com.GitHub.Pikaju.Protobuf.Delphi.uVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Com.GitHub.Pikaju.Protobuf.Delphi.uCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uDefaultValues,
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uVarint;

type
  TVarintWireCodec<T> = class(TPackableWireCodec<T>)
    procedure EncodeField(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream); override;
    function DecodeField(aData: TList<TEncodedField>): T; override;

    procedure EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TEncodedField>; aDest: TList<T>); override;

    procedure EncodePackedRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream); override;
  end;

var
  gWireCodecInt32: TVarintWireCodec<Int32>;
  gWireCodecUInt32: TVarintWireCodec<UInt32>;

  gWireCodecInt64: TVarintWireCodec<Int64>;
  gWireCodecUInt64: TVarintWireCodec<UInt64>;

implementation

procedure TVarintWireCodec<T>.EncodeField(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream);
begin
  EncodeTag(TTag.Create(aFieldNumber, wtVarint), aDest);
  EncodeVarint(aValue, aDest);
end;

function TVarintWireCodec<T>.DecodeField(aData: TList<TEncodedField>): T;
var
  lField: TEncodedField;
  lStream: TMemoryStream;
begin
  result := PROTOBUF_DEFAULT_VALUE_NUMERIC;

  // https://developers.google.com/protocol-buffers/docs/encoding#optional:
  // For numeric types and strings, if the same field appears multiple times, the parser accepts the last value it sees.
  for lField in aData do
  begin
    // Convert field to a stream for simpler processing.
    lStream := TMemoryStream.Create;
    lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
    lStream.Seek(0, soBeginning);

    if (lField.Tag.WireType = wtVarint) then
      result := DecodeVarint(lStream)
    else if (lField.Tag.WireType = wtLengthDelimited) then
    begin
      // Ignore the size of the field, as the stream already has the correct length.
      DecodeVarint(lStream);
      while (lStream.Position < lStream.Size) do
        result := DecodeVarint(lStream);
    end; // TODO: Catch invalid wire type.

    lStream.Free;
  end;
end;

procedure TVarintWireCodec<T>.EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
begin
  // TODO: Implement
end;

procedure TVarintWireCodec<T>.DecodeRepeatedField(aData: TList<TEncodedField>; aDest: TList<T>);

begin
  // TODO: Implement
end;

procedure TVarintWireCodec<T>.EncodePackedRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
begin
  // TODO: Implement
end;

initialization
begin
  gWireCodecInt32 := TVarintWireCodec<Int32>.Create;
  gWireCodecUInt32 := TVarintWireCodec<UInt32>.Create;

  gWireCodecInt64 := TVarintWireCodec<Int64>.Create;
  gWireCodecUInt64 := TVarintWireCodec<UInt64>.Create;
end;

finalization
begin
  gWireCodecUInt64.Free;
  gWireCodecInt64.Free;

  gWireCodecUInt32.Free;
  gWireCodecInt32.Free;
end;

end.
