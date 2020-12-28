/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>sfixed64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedSfixed64;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFixedWidthFieldValues<Int64>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues,
  // TProtobufFixedWidthWireCodec for TProtobufRepeatedFixedWidthFieldValues<Int64> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
  // TProtobufSfixed64WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSfixed64;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedFixedWidthFieldValues"/> for protobuf repeated fields of the protobuf type <c>sfixed64</c>.
  /// </summary>
  TProtobufRepeatedSfixed64FieldValues = class(TProtobufRepeatedFixedWidthFieldValues<Int64>)
    // TProtobufRepeatedFixedWidthFieldValues<Int64> implementation

    protected
      function GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Int64>; override;
  end;

implementation

uses
  // gProtobufWireCodecSfixed64 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufSfixed64;

// TProtobufRepeatedFixedWidthFieldValues<Int64> implementation

function TProtobufRepeatedSfixed64FieldValues.GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Int64>;
begin
  result := gProtobufWireCodecSfixed64 as TProtobufSfixed64WireCodec;
end;

end.
