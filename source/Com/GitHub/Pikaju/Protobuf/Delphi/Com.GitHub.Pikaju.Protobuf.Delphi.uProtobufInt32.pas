/// <summary>
/// Runtime library support for the protobuf type <c>int32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufInt32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<Int32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>int32</c>.
  /// </summary>
  TProtobufInt32WireCodec = class(TProtobufVarintWireCodec<Int32>)
    // TProtobufVarintWireCodec<Int32> implementation

    public
      function FromUInt64(aValue: UInt64): Int32; override;
      function ToUInt64(aValue: Int32): UInt64; override;

    // IProtobufWireCodec<T> implementation
    
    public
      function GetDefault: Int32; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufVarintWireCodec<Int32> implementation

function TProtobufInt32WireCodec.FromUInt64(aValue: UInt64): Int32;
begin
  ValidateBounds(aValue, 32, True);
  result := Int32(aValue);
end;

function TProtobufInt32WireCodec.ToUInt64(aValue: Int32): UInt64;
begin
  result := UInt64(aValue);
end;

// IProtobufWireCodec<T> implementation

function TProtobufInt32WireCodec.GetDefault: Int32;
begin
  result := PROTOBUF_DEFAULT_VALUE_INT32;
end;

end.
