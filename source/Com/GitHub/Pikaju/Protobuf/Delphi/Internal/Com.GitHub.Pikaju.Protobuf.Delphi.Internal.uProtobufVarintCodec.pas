unit Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarint;

type
  TProtobufVarintWireCodec<T> = class(TProtobufPackableWireCodec<T>)
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream); override;
    function DecodeField(aData: TList<TProtobufEncodedField>): T; override;

    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TProtobufRepeatedField<T>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TProtobufRepeatedField<T>); override;
  end;

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

  if (Assigned(aData)) then
  begin
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
end;

procedure TProtobufVarintWireCodec<T>.EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TProtobufRepeatedField<T>; aDest: TStream);
var
  lValue: T;
begin
  TProtobufTag.WithData(aFieldNumber, wtLengthDelimited).Encode(aDest);
  for lValue in aValues do
    EncodeVarint(lValue, aDest);
end;

procedure TProtobufVarintWireCodec<T>.DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TProtobufRepeatedField<T>);
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  if (Assigned(aData)) then
  begin
    // For each field, we will decide wether to decode a packed or non-packed repeated varint.
    for lField in aData do
    begin
      // Convert field to a stream for simpler processing.
      lStream := TMemoryStream.Create;
      try
        lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
        lStream.Seek(0, soBeginning);

        if (lField.Tag.WireType = wtVarint) then
          aDest.Add(DecodeVarint(lStream))
        else if (lField.Tag.WireType = wtLengthDelimited) then
        begin
          // Ignore the size of the field, as the stream already has the correct length.
          DecodeVarint(lStream);
          while (lStream.Position < lStream.Size) do
            aDest.Add(DecodeVarint(lStream));
        end; // TODO: Catch invalid wire type.
      finally
        lStream.Free;
      end;
    end;
  end;
end;

end.
