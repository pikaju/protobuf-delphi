/// <summary>
/// Runtime library support for the protobuf type <c>sint64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSint64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<Int64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>sint64</c>.
  /// </summary>
  TProtobufSint64WireCodec = class(TProtobufVarintWireCodec<Int64>)
    // TProtobufVarintWireCodec<Int64> implementation

    public
      function FromUInt64(aValue: UInt64): Int64; override;
      function ToUInt64(aValue: Int64): UInt64; override;

    // TProtobufWireCodec<Int64> implementation
    
    public
      function GetDefault: Int64; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufVarintWireCodec<Int64> implementation

function TProtobufSint64WireCodec.FromUInt64(aValue: UInt64): Int64;
var
  lZigZagValue: UInt64;
begin
  ValidateBounds(aValue, 64, False);
  lZigZagValue := UInt64(aValue);
  result := (lZigZagValue shr 1) xor -(lZigZagValue and 1);
end;

function TProtobufSint64WireCodec.ToUInt64(aValue: Int64): UInt64;
var
  lZigZagValue: UInt64;
begin
  lZigZagValue := aValue shl 1;
  if (aValue < 0) then lZigZagValue := lZigZagValue xor -1;
  result := UInt64(lZigZagValue);
end;

// TProtobufWireCodec<Int64> implementation

function TProtobufSint64WireCodec.GetDefault: Int64;
begin
  result := PROTOBUF_DEFAULT_VALUE_SINT64;
end;

end.
