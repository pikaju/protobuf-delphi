/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>fixed64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixed64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFixedWidthFieldValues<UInt64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues,
  // TProtobufFixedWidthWireCodec for TProtobufRepeatedFixedWidthFieldValues<UInt64> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
  // TProtobufFixed64WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixed64;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedFixedWidthFieldValues"/> for protobuf repeated fields of the protobuf type <c>fixed64</c>.
  /// </summary>
  TProtobufRepeatedFixed64FieldValues = class(TProtobufRepeatedFixedWidthFieldValues<UInt64>)
    // TProtobufRepeatedFixedWidthFieldValues<UInt64> implementation

    protected
      function GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<UInt64>; override;
  end;

implementation

uses
  // gProtobufWireCodecFixed64 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufFixed64;

// TProtobufRepeatedFixedWidthFieldValues<UInt64> implementation

function TProtobufRepeatedFixed64FieldValues.GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<UInt64>;
begin
  result := gProtobufWireCodecFixed64 as TProtobufFixed64WireCodec;
end;

end.
