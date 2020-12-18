/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>bytes</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBytes;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedDelimitedFieldValues<TBytes>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedDelimitedFieldValues,
  // TProtobufWireCodec for TProtobufRepeatedDelimitedFieldValues<TBytes> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // TProtobufBytesWireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufBytes,
  // TBytes to represent values
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.SysUtils;
{$ELSE}
  SysUtils;
{$ENDIF}


type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedDelimitedFieldValues"/> for protobuf repeated fields of the protobuf type <c>bytes</c>.
  /// </summary>
  TProtobufRepeatedBytesFieldValues = class(TProtobufRepeatedDelimitedFieldValues<TBytes>)

    // TProtobufRepeatedDelimitedFieldValues<TBytes> implementation
    protected
      function GetWireCodec: TProtobufWireCodec<TBytes>; override;
  end;

implementation

uses
  // gProtobufWireCodecBytes as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufBytes;

// TProtobufRepeatedDelimitedFieldValues<TBytes> implementation

function TProtobufRepeatedBytesFieldValues.GetWireCodec: TProtobufWireCodec<TBytes>;
begin
  result := gProtobufWireCodecBytes as TProtobufBytesWireCodec;
end;

end.
