/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>bool</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBool;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedVarintFieldValues<Boolean>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues,
  // TProtobufVarintWireCodec for TProtobufRepeatedVarintFieldValues<Boolean> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedVarintFieldValues"/> for protobuf repeated fields of the protobuf type <c>bool</c>.
  /// </summary>
  TProtobufRepeatedBoolFieldValues = class(TProtobufRepeatedVarintFieldValues<Boolean>)
    // TProtobufRepeatedVarintFieldValues<Boolean> implementation

    protected
      function GetVarintWireCodec: TProtobufVarintWireCodec<Boolean>; override;
  end;

implementation

uses
  // gProtobufWireCodecBool as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufBool;

// TProtobufRepeatedVarintFieldValues<Boolean> implementation

function TProtobufRepeatedBoolFieldValues.GetVarintWireCodec: TProtobufVarintWireCodec<Boolean>;
begin
  result := gProtobufWireCodecBool as TProtobufVarintWireCodec<Boolean>;
end;

end.

