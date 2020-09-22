/// <summary>
/// Runtime library support for the protobuf type <c>uint32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // Wire codec interface
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // Wire codec implementation for all <i>varint</i> protobuf types
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarintCodec;

var
  /// <summary>
  /// <i>Field codec</i> for <c>protoc-gen-delphi</c> that defines the encoding/decoding of
  /// protobuf fields of type <c>uint32</c> from/to the protobuf binary wire format.
  /// </summary>
  gProtobufWireCodecUInt32: TProtobufWireCodec<UInt32>;

implementation

initialization
begin
  gProtobufWireCodecUInt32 := TProtobufVarintWireCodec<UInt32>.Create;
end;

finalization
begin
  gProtobufWireCodecUInt32.Free;
end;

end.
