/// <summary>
/// Runtime library support for the protobuf enum types.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEnum;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<TProtobufEnumFieldValue>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec,
  // TProtobufEnumFieldValue to represent protobuf enum values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for protobuf enum types.
  /// </summary>
  TProtobufEnumWireCodec = class(TProtobufVarintWireCodec<TProtobufEnumFieldValue>)
    // TProtobufVarintWireCodec<TProtobufEnumFieldValue> implementation

    public
      function FromUInt64(aValue: UInt64): TProtobufEnumFieldValue; override;
      function ToUInt64(aValue: TProtobufEnumFieldValue): UInt64; override;

    // IProtobufWireCodec<T> implementation
    
    public
      function GetDefault: TProtobufEnumFieldValue; override;
  end;

implementation

// TProtobufVarintWireCodec<TProtobufEnumFieldValue> implementation

function TProtobufEnumWireCodec.FromUInt64(aValue: UInt64): TProtobufEnumFieldValue;
begin
  // "Enumerator constants must be in the range of a 32-bit integer. Since enum values
  // use varint encoding on the wire, negative values are inefficient and thus not recommended."
  // See: https://developers.google.com/protocol-buffers/docs/proto3#enum
  ValidateBounds(aValue, 32, True);
  result := TProtobufEnumFieldValue(aValue);
end;

function TProtobufEnumWireCodec.ToUInt64(aValue: TProtobufEnumFieldValue): UInt64;
begin
  result := UInt64(aValue);
end;

// IProtobufWireCodec<T> implementation

function TProtobufEnumWireCodec.GetDefault: TProtobufEnumFieldValue;
begin
  result := PROTOBUF_DEFAULT_VALUE_ENUM;
end;

end.
