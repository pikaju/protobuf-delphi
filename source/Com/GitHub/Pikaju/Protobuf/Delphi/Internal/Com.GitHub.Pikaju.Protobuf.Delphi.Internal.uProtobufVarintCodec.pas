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
  TProtobufVarintWireCodec<T> = class(TProtobufPackableWireCodec<T>)
  private
    FBitCount: Integer;
    FSigned: Boolean;

    // Throws an exception if aValue does not fit within the Protobuf type handled by this codec.
    procedure ValidateBounds(aValue: UInt64);
    function CheckedCast(aVarint: UInt64): T;
  public
    constructor Create(aBitCount: Integer; aSigned: Boolean); reintroduce;
    
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream); override;
    function DecodeField(aData: TList<TProtobufEncodedField>): T; override;

    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TProtobufRepeatedField<T>; aDest: TStream); override;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TProtobufRepeatedField<T>); override;
  end;

implementation

constructor TProtobufVarintWireCodec<T>.Create(aBitCount: Integer; aSigned: Boolean);
begin
  FBitCount := aBitCount;
  FSigned := aSigned;
end;

procedure TProtobufVarintWireCodec<T>.ValidateBounds(aValue: UInt64);
var
  lMasked: UInt64;
begin
  if (FSigned) then
  begin
    // For signed types, the sign bit and all padding bits in the UInt64 must have the same value.

    lMasked := aValue and (UInt64(-1) shl (FBitCount - 1));
    // Positive numbers
    if (not ((lMasked = 0) or (lMasked = (UInt64(-1) shl (FBitCount - 1))))) then
      raise Exception.Create('Decoded varint smaller or larger than is allowed by ' + FBitCount.ToString + '-bit signed integer.');
  end
  else
  begin
    // For unsigned types, simply check if there is a binary 1 beyond FBitCount bits.
    if ((UInt64(-1) shl FBitCount) and aValue <> 0) then
      raise Exception.Create('Decoded varint ' + aValue.ToString + ' larger than is allowed by ' + FBitCount.ToString + '-bit unsigned integer.');
  end;
end;

function TProtobufVarintWireCodec<T>.CheckedCast(aVarint: UInt64): T;
begin
  ValidateBounds(aVarint);
  result := T(aVarint);
end;

procedure TProtobufVarintWireCodec<T>.EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream);
begin
  TProtobufTag.WithData(aFieldNumber, wtVarint).Encode(aDest);
  EncodeVarint(UInt64(aValue), aDest);
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
        result := CheckedCast(DecodeVarint(lStream))
      else if (lField.Tag.WireType = wtLengthDelimited) then
      begin
        // Ignore the size of the field, as the stream already has the correct length.
        DecodeVarint(lStream);
        while (lStream.Position < lStream.Size) do
          result := CheckedCast(DecodeVarint(lStream));
      end; // TODO: Catch invalid wire type.
    finally
      lStream.Free;
    end;
  end;
end;

procedure TProtobufVarintWireCodec<T>.EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TProtobufRepeatedField<T>; aDest: TStream);
var
  lValue: T;
begin
  TProtobufTag.WithData(aFieldNumber, wtLengthDelimited).Encode(aDest);
  for lValue in aValues do
    EncodeVarint(UInt64(lValue), aDest);
end;

procedure TProtobufVarintWireCodec<T>.DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TProtobufRepeatedField<T>);
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
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
        aDest.Add(CheckedCast(DecodeVarint(lStream)))
      else if (lField.Tag.WireType = wtLengthDelimited) then
      begin
        // Ignore the size of the field, as the stream already has the correct length.
        DecodeVarint(lStream);
        while (lStream.Position < lStream.Size) do
          aDest.Add(CheckedCast(DecodeVarint(lStream)));
      end; // TODO: Catch invalid wire type.
    finally
      lStream.Free;
    end;
  end;
end;

end.
