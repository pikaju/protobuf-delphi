/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>int32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedInt32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedVarintFieldValues<Int32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues,
  // TProtobufVarintWireCodec for TProtobufRepeatedVarintFieldValues<Int32> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec,
  // TProtobufInt32WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufInt32;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedVarintFieldValues"/> for protobuf repeated fields of the protobuf type <c>int32</c>.
  /// </summary>
  TProtobufRepeatedInt32FieldValues = class(TProtobufRepeatedVarintFieldValues<Int32>)
    // TProtobufRepeatedVarintFieldValues<Int32> implementation

    protected
      function GetVarintWireCodec: TProtobufVarintWireCodec<Int32>; override;
  end;

implementation

uses
  // gProtobufWireCodecInt32 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufInt32;

// TProtobufRepeatedVarintFieldValues<Int32> implementation

function TProtobufRepeatedInt32FieldValues.GetVarintWireCodec: TProtobufVarintWireCodec<Int32>;
begin
  result := gProtobufWireCodecInt32 as TProtobufInt32WireCodec;
end;

end.
