unit Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarint;

type
  EProtobufInvalidValue = class(Exception);

  TProtobufVarintWireCodec<T> = class(TProtobufPackableWireCodec<T>)
  protected
    // Throws an exception if aValue does not fit within the Protobuf type handled by this codec.
    // TODO
    class procedure ValidateBounds(aValue: UInt64; aBitCount: Integer; aSigned: Boolean);

    /// <summary>
    /// TODO
    /// </summary>
    function FromUInt64(aValue: UInt64): T; virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    function ToUInt64(aValue: T): UInt64; virtual; abstract;
  public
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream); override;
    function DecodeField(aData: TList<TProtobufEncodedField>): T; override;
    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TProtobufRepeatedField<T>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TProtobufRepeatedField<T>); override;
  end;

implementation

class procedure TProtobufVarintWireCodec<T>.ValidateBounds(aValue: UInt64; aBitCount: Integer; aSigned: Boolean);
var
  lMasked: UInt64;
begin
  if (aSigned) then
  begin
    // For signed types, the sign bit and all padding bits in the UInt64 must have the same value.

    lMasked := aValue and (UInt64(-1) shl (aBitCount - 1));
    // Positive numbers
    if ((lMasked <> 0) and (lMasked <> (UInt64(-1) shl (aBitCount - 1)))) then
      raise EProtobufInvalidValue.Create('Decoded varint smaller or larger than is allowed by ' + aBitCount.ToString + '-bit signed integer.');
  end
  else
  begin
    // For unsigned types, simply check if there is a binary 1 beyond FBitCount bits.
    if ((UInt64(-1) shl aBitCount) and aValue <> 0) then
      raise EProtobufInvalidValue.Create('Decoded varint ' + aValue.ToString + ' larger than is allowed by ' + aBitCount.ToString + '-bit unsigned integer.');
  end;
end;

procedure TProtobufVarintWireCodec<T>.EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream);
begin
  TProtobufTag.WithData(aFieldNumber, wtVarint).Encode(aDest);
  EncodeVarint(ToUInt64(aValue), aDest);
end;

function TProtobufVarintWireCodec<T>.DecodeField(aData: TList<TProtobufEncodedField>): T;
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  result := T(PROTOBUF_DEFAULT_VALUE_NUMERIC);

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
          result := FromUInt64(DecodeVarint(lStream))
        else if (lField.Tag.WireType = wtLengthDelimited) then
        begin
          // Ignore the size of the field, as the stream already has the correct length.
          DecodeVarint(lStream);
          while (lStream.Position < lStream.Size) do
            result := FromUInt64(DecodeVarint(lStream));
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
    EncodeVarint(ToUInt64(lValue), aDest);
end;

procedure TProtobufVarintWireCodec<T>.DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TProtobufRepeatedField<T>);
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  // Default value for repeated fields is empty.
  aDest.Clear;

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
          aDest.Add(FromUInt64(DecodeVarint(lStream)))
        else if (lField.Tag.WireType = wtLengthDelimited) then
        begin
          // Ignore the size of the field, as the stream already has the correct length.
          DecodeVarint(lStream);
          while (lStream.Position < lStream.Size) do
            aDest.Add(FromUInt64(DecodeVarint(lStream)));
        end; // TODO: Catch invalid wire type.
      finally
        lStream.Free;
      end;
    end;
  end;
end;

end.
