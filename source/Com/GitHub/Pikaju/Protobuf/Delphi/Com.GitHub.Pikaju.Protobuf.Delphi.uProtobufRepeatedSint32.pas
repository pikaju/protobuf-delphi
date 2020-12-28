/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>sint32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedSint32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedVarintFieldValues<Int32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues,
  // TProtobufVarintWireCodec for TProtobufRepeatedVarintFieldValues<Int32> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec,
  // TProtobufSint32WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSint32;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedVarintFieldValues"/> for protobuf repeated fields of the protobuf type <c>sint32</c>.
  /// </summary>
  TProtobufRepeatedSint32FieldValues = class(TProtobufRepeatedVarintFieldValues<Int32>)
    // TProtobufRepeatedVarintFieldValues<Int32> implementation

    protected
      function GetVarintWireCodec: TProtobufVarintWireCodec<Int32>; override;
  end;

implementation

uses
  // gProtobufWireCodecSint32 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufSint32;

// TProtobufRepeatedVarintFieldValues<Int32> implementation

function TProtobufRepeatedSint32FieldValues.GetVarintWireCodec: TProtobufVarintWireCodec<Int32>;
begin
  result := gProtobufWireCodecSint32 as TProtobufSint32WireCodec;
end;

end.
