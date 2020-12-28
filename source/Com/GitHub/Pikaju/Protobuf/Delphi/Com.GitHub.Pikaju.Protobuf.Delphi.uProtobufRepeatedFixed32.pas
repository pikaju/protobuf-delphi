/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>fixed32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixed32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFixedWidthFieldValues<UInt32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues,
  // TProtobufFixedWidthWireCodec for TProtobufRepeatedFixedWidthFieldValues<UInt32> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
  // TProtobufFixed32WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixed32;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedFixedWidthFieldValues"/> for protobuf repeated fields of the protobuf type <c>fixed32</c>.
  /// </summary>
  TProtobufRepeatedFixed32FieldValues = class(TProtobufRepeatedFixedWidthFieldValues<UInt32>)
    // TProtobufRepeatedFixedWidthFieldValues<UInt32> implementation

    protected
      function GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<UInt32>; override;
  end;

implementation

uses
  // gProtobufWireCodecFixed32 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufFixed32;

// TProtobufRepeatedFixedWidthFieldValues<UInt32> implementation

function TProtobufRepeatedFixed32FieldValues.GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<UInt32>;
begin
  result := gProtobufWireCodecFixed32 as TProtobufFixed32WireCodec;
end;

end.
