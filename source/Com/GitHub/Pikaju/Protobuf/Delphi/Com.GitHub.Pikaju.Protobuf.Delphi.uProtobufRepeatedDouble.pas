/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>double</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedDouble;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFixedWidthFieldValues<Double>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues,
  // TProtobufFixedWidthWireCodec for TProtobufRepeatedFixedWidthFieldValues<Double> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
  // TProtobufDoubleWireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDouble;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedFixedWidthFieldValues"/> for protobuf repeated fields of the protobuf type <c>double</c>.
  /// </summary>
  TProtobufRepeatedDoubleFieldValues = class(TProtobufRepeatedFixedWidthFieldValues<Double>)
    // TProtobufRepeatedFixedWidthFieldValues<Double> implementation

    protected
      function GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Double>; override;
  end;

implementation

uses
  // gProtobufWireCodecDouble as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufDouble;

// TProtobufRepeatedFixedWidthFieldValues<Double> implementation

function TProtobufRepeatedDoubleFieldValues.GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Double>;
begin
  result := gProtobufWireCodecDouble as TProtobufDoubleWireCodec;
end;

end.
