/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>sfixed32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedSfixed32;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFixedWidthFieldValues<Int32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues,
  // TProtobufFixedWidthWireCodec for TProtobufRepeatedFixedWidthFieldValues<Int32> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
  // TProtobufSfixed32WireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSfixed32;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedFixedWidthFieldValues"/> for protobuf repeated fields of the protobuf type <c>sfixed32</c>.
  /// </summary>
  TProtobufRepeatedSfixed32FieldValues = class(TProtobufRepeatedFixedWidthFieldValues<Int32>)
    // TProtobufRepeatedFixedWidthFieldValues<Int32> implementation

    protected
      function GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Int32>; override;
  end;

implementation

uses
  // gProtobufWireCodecSfixed32 as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufSfixed32;

// TProtobufRepeatedFixedWidthFieldValues<Int32> implementation

function TProtobufRepeatedSfixed32FieldValues.GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<Int32>;
begin
  result := gProtobufWireCodecSfixed32 as TProtobufSfixed32WireCodec;
end;

end.
