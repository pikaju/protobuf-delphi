/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>int64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedInt64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedVarintFieldValues<Int64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues,
  // TProtobufVarintWireCodec for TProtobufRepeatedVarintFieldValues<Int64> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec,
  // TProtobufInt64WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufInt64;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedVarintFieldValues"/> for protobuf repeated fields of the protobuf type <c>int64</c>.
  /// </summary>
  TProtobufRepeatedInt64FieldValues = class(TProtobufRepeatedVarintFieldValues<Int64>)
    // TProtobufRepeatedVarintFieldValues<Int64> implementation

    protected
      function GetVarintWireCodec: TProtobufVarintWireCodec<Int64>; override;
  end;

implementation

uses
  // gProtobufWireCodecInt64 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufInt64;

// TProtobufRepeatedVarintFieldValues<Int64> implementation

function TProtobufRepeatedInt64FieldValues.GetVarintWireCodec: TProtobufVarintWireCodec<Int64>;
begin
  result := gProtobufWireCodecInt64 as TProtobufInt64WireCodec;
end;

end.
