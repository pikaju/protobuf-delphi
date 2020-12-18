/// <summary>
/// Runtime library support for the protobuf type <c>int64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufInt64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<Int64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>int64</c>.
  /// </summary>
  TProtobufInt64WireCodec = class(TProtobufVarintWireCodec<Int64>)
    // TProtobufVarintWireCodec<Int64> implementation

    public
      function FromUInt64(aValue: UInt64): Int64; override;
      function ToUInt64(aValue: Int64): UInt64; override;

    // IProtobufWireCodec<T> implementation
    
    public
      function GetDefault: Int64; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufVarintWireCodec<Int64> implementation

function TProtobufInt64WireCodec.FromUInt64(aValue: UInt64): Int64;
begin
  ValidateBounds(aValue, 64, True);
  result := Int64(aValue);
end;

function TProtobufInt64WireCodec.ToUInt64(aValue: Int64): UInt64;
begin
  result := UInt64(aValue);
end;

// IProtobufWireCodec<T> implementation

function TProtobufInt64WireCodec.GetDefault: Int64;
begin
  result := PROTOBUF_DEFAULT_VALUE_INT64;
end;

end.
