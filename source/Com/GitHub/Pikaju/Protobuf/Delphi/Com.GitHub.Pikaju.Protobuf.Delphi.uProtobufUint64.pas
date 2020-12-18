/// <summary>
/// Runtime library support for the protobuf type <c>uint64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<UInt64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>uint64</c>.
  /// </summary>
  TProtobufUint64WireCodec = class(TProtobufVarintWireCodec<UInt64>)
    // TProtobufVarintWireCodec<UInt64> implementation

    public
      function FromUInt64(aValue: UInt64): UInt64; override;
      function ToUInt64(aValue: UInt64): UInt64; override;

    // IProtobufWireCodec<T> implementation
    
    public
      function GetDefault: UInt64; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufVarintWireCodec<UInt64> implementation

function TProtobufUint64WireCodec.FromUInt64(aValue: UInt64): UInt64;
begin
  ValidateBounds(aValue, 64, False);
  result := UInt64(aValue);
end;

function TProtobufUint64WireCodec.ToUInt64(aValue: UInt64): UInt64;
begin
  result := UInt64(aValue);
end;

// IProtobufWireCodec<T> implementation

function TProtobufUint64WireCodec.GetDefault: UInt64;
begin
  result := PROTOBUF_DEFAULT_VALUE_UINT64;
end;

end.
