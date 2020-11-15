/// <summary>
/// Runtime library support for the protobuf type <c>uint32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<UInt32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>uint32</c>.
  /// </summary>
  TProtobufUint32WireCodec = class(TProtobufVarintWireCodec<UInt32>)
    // TProtobufVarintWireCodec<UInt32> implementation

    public
      function FromUInt64(aValue: UInt64): UInt32; override;
      function ToUInt64(aValue: UInt32): UInt64; override;
      function GetDefault: UInt32; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufVarintWireCodec<UInt32> implementation

function TProtobufUint32WireCodec.FromUInt64(aValue: UInt64): UInt32;
begin
  ValidateBounds(aValue, 32, False);
  result := UInt32(aValue);
end;

function TProtobufUint32WireCodec.ToUInt64(aValue: UInt32): UInt64;
begin
  result := UInt64(aValue);
end;

function TProtobufUint32WireCodec.GetDefault: UInt32;
begin
  result := PROTOBUF_DEFAULT_VALUE_UINT32;
end;

end.
