/// <summary>
/// Runtime library support for the protobuf type <c>uint32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // Runtime library support for protobuf field encoding/decoding
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // Wire codec implementation for all <i>varint</i> protobuf types
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarintCodec;

var
  /// <summary>
  /// <i>Field codec</i> for <c>protoc-gen-delphi</c> that defines the encoding/decoding of
  /// protobuf fields of type <c>uint32</c> from/to the protobuf binary wire format.
  /// </summary>
  gProtobufWireCodecUint32: TProtobufWireCodec<UInt32>;

implementation

type
  /// <summary>
  /// TODO
  /// </summary>
  TProtobufUint32WireCodec = class(TProtobufVarintWireCodec<UInt32>)
  protected
    function FromUInt64(aValue: UInt64): UInt32; override;
    function ToUInt64(aValue: UInt32): UInt64; override;
  end;

function TProtobufUint32WireCodec.FromUInt64(aValue: UInt64): UInt32;
begin
  ValidateBounds(aValue, 32, False);
  result := UInt32(aValue);
end;

function TProtobufUint32WireCodec.ToUInt64(aValue: UInt32): UInt64;
begin
  result := UInt64(aValue);
end;

initialization
begin
  gProtobufWireCodecUInt32 := TProtobufUint32WireCodec.Create;
end;

finalization
begin
  gProtobufWireCodecUInt32.Free;
end;

end.
