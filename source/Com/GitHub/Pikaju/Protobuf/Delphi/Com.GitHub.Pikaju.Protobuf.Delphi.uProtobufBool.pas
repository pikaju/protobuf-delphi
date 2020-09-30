/// <summary>
/// Runtime library support for the protobuf type <c>bool</c>.
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
  /// protobuf fields of type <c>bool</c> from/to the protobuf binary wire format.
  /// </summary>
  gProtobufWireCodecBool: TProtobufWireCodec<Boolean>;

implementation

initialization
begin
  gProtobufWireCodecBool := TProtobufVarintWireCodec<Boolean>.Create(1, False);
end;

finalization
begin
  gProtobufWireCodecBool.Free;
end;

end.
