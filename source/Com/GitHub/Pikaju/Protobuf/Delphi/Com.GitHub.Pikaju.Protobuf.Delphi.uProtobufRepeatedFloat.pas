/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>float</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFloat;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFixedWidthFieldValues<Single>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues,
  // TProtobufFixedWidthWireCodec for TProtobufRepeatedFixedWidthFieldValues<Single> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
  // TProtobufFloatWireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFloat;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedFixedWidthFieldValues"/> for protobuf repeated fields of the protobuf type <c>float</c>.
  /// </summary>
  TProtobufRepeatedFloatFieldValues = class(TProtobufRepeatedFixedWidthFieldValues<Single>)
    // TProtobufRepeatedFixedWidthFieldValues<Single> implementation

    protected
      function GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Single>; override;
  end;

implementation

uses
  // gProtobufWireCodecFloat as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufFloat;

// TProtobufRepeatedFixedWidthFieldValues<Single> implementation

function TProtobufRepeatedFloatFieldValues.GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Single>;
begin
  result := gProtobufWireCodecFloat as TProtobufFloatWireCodec;
end;

end.
