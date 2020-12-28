/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>sint64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedSint64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedVarintFieldValues<Int64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues,
  // TProtobufVarintWireCodec for TProtobufRepeatedVarintFieldValues<Int64> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec,
  // TProtobufSint64WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSint64;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedVarintFieldValues"/> for protobuf repeated fields of the protobuf type <c>sint64</c>.
  /// </summary>
  TProtobufRepeatedSint64FieldValues = class(TProtobufRepeatedVarintFieldValues<Int64>)
    // TProtobufRepeatedVarintFieldValues<Int64> implementation

    protected
      function GetVarintWireCodec: TProtobufVarintWireCodec<Int64>; override;
  end;

implementation

uses
  // gProtobufWireCodecSint64 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufSint64;

// TProtobufRepeatedVarintFieldValues<Int64> implementation

function TProtobufRepeatedSint64FieldValues.GetVarintWireCodec: TProtobufVarintWireCodec<Int64>;
begin
  result := gProtobufWireCodecSint64 as TProtobufSint64WireCodec;
end;

end.
