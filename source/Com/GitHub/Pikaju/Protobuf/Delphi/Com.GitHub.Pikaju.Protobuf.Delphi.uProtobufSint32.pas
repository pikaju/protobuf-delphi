/// <summary>
/// Runtime library support for the protobuf type <c>sint32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSint32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<Int32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>sint32</c>.
  /// </summary>
  TProtobufSint32WireCodec = class(TProtobufVarintWireCodec<Int32>)
    // TProtobufVarintWireCodec<Int32> implementation

    public
      function FromUInt64(aValue: UInt64): Int32; override;
      function ToUInt64(aValue: Int32): UInt64; override;

    // TProtobufWireCodec<Int32> implementation
    
    public
      function GetDefault: Int32; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufVarintWireCodec<Int32> implementation

function TProtobufSint32WireCodec.FromUInt64(aValue: UInt64): Int32;
var
  lZigZagValue: UInt32;
begin
  ValidateBounds(aValue, 32, False);
  lZigZagValue := UInt32(aValue);
  result := (lZigZagValue shr 1) xor -(lZigZagValue and 1);
end;

function TProtobufSint32WireCodec.ToUInt64(aValue: Int32): UInt64;
var
  lZigZagValue: UInt32;
begin
  lZigZagValue := aValue shl 1;
  if (aValue < 0) then lZigZagValue := lZigZagValue xor -1;
  result := UInt64(lZigZagValue);
end;

// TProtobufWireCodec<Int32> implementation

function TProtobufSint32WireCodec.GetDefault: Int32;
begin
  result := PROTOBUF_DEFAULT_VALUE_SINT32;
end;

end.
