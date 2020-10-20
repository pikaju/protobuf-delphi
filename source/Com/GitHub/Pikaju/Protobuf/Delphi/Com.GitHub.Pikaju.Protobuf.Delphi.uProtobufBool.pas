/// <summary>
/// Runtime library support for the protobuf type <c>bool</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufBool;

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

uses
  // Main protobuf file for default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

type
  /// <summary>
  /// TODO
  /// </summary>
  TProtobufBoolWireCodec = class(TProtobufVarintWireCodec<Boolean>)
  protected
    function FromUInt64(aValue: UInt64): Boolean; override;
    function ToUInt64(aValue: Boolean): UInt64; override;

    function GetDefault: Boolean; override;
  end;

function TProtobufBoolWireCodec.FromUInt64(aValue: UInt64): Boolean;
begin
  ValidateBounds(aValue, 1, False);
  result := Boolean(aValue);
end;

function TProtobufBoolWireCodec.ToUInt64(aValue: Boolean): UInt64;
begin
  result := UInt64(aValue);
end;

function TProtobufBoolWireCodec.GetDefault: Boolean;
begin
  result := PROTOBUF_DEFAULT_VALUE_BOOL;
end;

initialization
begin
  gProtobufWireCodecBool := TProtobufBoolWireCodec.Create;
end;

finalization
begin
  gProtobufWireCodecBool.Free;
end;

end.
