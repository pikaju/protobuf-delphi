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

initialization
begin
  gProtobufWireCodecEnum := TProtobufVarintWireCodec<TProtobufEnumFieldValue>.Create;
end;

finalization
begin
  gProtobufWireCodecEnum.Free;
end;

end.
