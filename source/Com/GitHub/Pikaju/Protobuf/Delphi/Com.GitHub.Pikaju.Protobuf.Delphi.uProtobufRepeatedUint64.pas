/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>uint64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedUint64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedVarintFieldValues<UInt64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues,
  // TProtobufVarintWireCodec for TProtobufRepeatedVarintFieldValues<UInt64> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec,
  // TProtobufUint64WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint64;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedVarintFieldValues"/> for protobuf repeated fields of the protobuf type <c>uint64</c>.
  /// </summary>
  TProtobufRepeatedUint64FieldValues = class(TProtobufRepeatedVarintFieldValues<UInt64>)
    // TProtobufRepeatedVarintFieldValues<UInt64> implementation

    protected
      function GetVarintWireCodec: TProtobufVarintWireCodec<UInt64>; override;
  end;

implementation

uses
  // gProtobufWireCodecUint64 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufUint64;

// TProtobufRepeatedVarintFieldValues<UInt64> implementation

function TProtobufRepeatedUint64FieldValues.GetVarintWireCodec: TProtobufVarintWireCodec<UInt64>;
begin
  result := gProtobufWireCodecUint64 as TProtobufUint64WireCodec;
end;

end.
