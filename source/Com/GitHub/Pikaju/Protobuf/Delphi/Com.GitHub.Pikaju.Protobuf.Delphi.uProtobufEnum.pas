/// <summary>
/// Runtime library support for protobuf enum types.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEnum;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // Runtime library support for protobuf field encoding/decoding
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // Wire codec implementation for all <i>varint</i> protobuf types
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarintCodec,
  // For <see cref="TProtobufEnumFieldValue"/>
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

var
  /// <summary>
  /// <i>Field codec</i> for <c>protoc-gen-delphi</c> that defines the encoding/decoding of
  /// protobuf fields of enum types from/to the protobuf binary wire format.
  /// </summary>
  gProtobufWireCodecEnum: TProtobufWireCodec<TProtobufEnumFieldValue>;

implementation

type
  /// <summary>
  /// TODO
  /// </summary>
  TProtobufEnumWireCodec = class(TProtobufVarintWireCodec<TProtobufEnumFieldValue>)
  protected
    function FromUInt64(aValue: UInt64): TProtobufEnumFieldValue; override;
    function ToUInt64(aValue: TProtobufEnumFieldValue): UInt64; override;

    function GetDefault: TProtobufEnumFieldValue; override;
  end;

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

function TProtobufEnumWireCodec.GetDefault: TProtobufEnumFieldValue;
begin
  result := PROTOBUF_DEFAULT_VALUE_ENUM;
end;

initialization
begin
  gProtobufWireCodecEnum := TProtobufEnumWireCodec.Create;
end;

finalization
begin
  gProtobufWireCodecEnum.Free;
end;

end.
