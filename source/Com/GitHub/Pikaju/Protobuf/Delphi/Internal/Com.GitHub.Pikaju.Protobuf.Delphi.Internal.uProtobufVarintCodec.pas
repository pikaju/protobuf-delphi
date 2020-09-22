unit Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarint;

type
  TProtobufVarintWireCodec<T> = class(TProtobufPackableWireCodec<T>)
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream); override;
    function DecodeField(aData: TList<TProtobufEncodedField>): T; override;

    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TList<T>); override;

    procedure EncodePackedRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream); override;
  end;

var
  gProtobufWireCodecInt32: TProtobufVarintWireCodec<Int32>;
  gProtobufWireCodecUInt32: TProtobufVarintWireCodec<UInt32>;

  gProtobufWireCodecInt64: TProtobufVarintWireCodec<Int64>;
  gProtobufWireCodecUInt64: TProtobufVarintWireCodec<UInt64>;

  gProtobufWireCodecEnum: TProtobufVarintWireCodec<TProtobufEnumFieldValue>;

implementation

procedure TProtobufVarintWireCodec<T>.EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream);
begin
  TProtobufTag.WithData(aFieldNumber, wtVarint).Encode(aDest);
  EncodeVarint(aValue, aDest);
end;

function TProtobufVarintWireCodec<T>.DecodeField(aData: TList<TProtobufEncodedField>): T;
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  result := PROTOBUF_DEFAULT_VALUE_NUMERIC;

  // https://developers.google.com/protocol-buffers/docs/encoding#optional:
  // For numeric types and strings, if the same field appears multiple times, the parser accepts the last value it sees.
  for lField in aData do
  begin
    // Convert field to a stream for simpler processing.
    lStream := TMemoryStream.Create;
    try
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
    finally
      lStream.Free;
    end;
  end;
end;

procedure TProtobufVarintWireCodec<T>.EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream);
begin
  // TODO: Implement
end;

procedure TProtobufVarintWireCodec<T>.DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TList<T>);

begin
  // TODO: Implement
end;

procedure TProtobufVarintWireCodec<T>.EncodePackedRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream);
begin
  // TODO: Implement
end;

initialization
begin
  gProtobufWireCodecInt32 := TProtobufVarintWireCodec<Int32>.Create;
  gProtobufWireCodecUInt32 := TProtobufVarintWireCodec<UInt32>.Create;

  gProtobufWireCodecInt64 := TProtobufVarintWireCodec<Int64>.Create;
  gProtobufWireCodecUInt64 := TProtobufVarintWireCodec<UInt64>.Create;

  gProtobufWireCodecEnum := TProtobufVarintWireCodec<TProtobufEnumFieldValue>.Create;
end;

finalization
begin
  gProtobufWireCodecEnum.Free;

  gProtobufWireCodecUInt64.Free;
  gProtobufWireCodecInt64.Free;

  gProtobufWireCodecUInt32.Free;
  gProtobufWireCodecInt32.Free;
end;

end.
