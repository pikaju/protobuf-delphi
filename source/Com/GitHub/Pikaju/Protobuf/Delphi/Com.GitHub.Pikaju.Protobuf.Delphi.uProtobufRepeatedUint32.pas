/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>uint32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedUint32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedVarintFieldValues<UInt32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues,
  // TProtobufVarintWireCodec for TProtobufRepeatedVarintFieldValues<UInt32> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedVarintFieldValues"/> for protobuf repeated fields of the protobuf type <c>uint32</c>.
  /// </summary>
  TProtobufRepeatedUint32FieldValues = class(TProtobufRepeatedVarintFieldValues<UInt32>)
    protected
      function GetWireCodec: TProtobufVarintWireCodec<UInt32>; override;
  end;

implementation

uses
  // gProtobufWireCodecUint32 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufUint32;

function TProtobufRepeatedUint32FieldValues.GetWireCodec: TProtobufVarintWireCodec<UInt32>;
begin
  result := gProtobufWireCodecUint32 as TProtobufVarintWireCodec<UInt32>;
end;

end.


