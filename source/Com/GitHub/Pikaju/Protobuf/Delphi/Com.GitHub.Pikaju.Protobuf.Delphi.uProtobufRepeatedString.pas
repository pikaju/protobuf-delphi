/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>string</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedString;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedDelimitedFieldValues<UnicodeString>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedDelimitedFieldValues,
  // TProtobufWireCodec for TProtobufRepeatedDelimitedFieldValues<UnicodeString> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // TProtobufStringWireCodec as wire codec
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufString;

type
  /// <summary>
  /// Concrete subclass of <see cref="T:TProtobufRepeatedDelimitedFieldValues"/> for protobuf repeated fields of the protobuf type <c>string</c>.
  /// </summary>
  TProtobufRepeatedStringFieldValues = class(TProtobufRepeatedDelimitedFieldValues<UnicodeString>)

    // TProtobufRepeatedDelimitedFieldValues<UnicodeString> implementation
    protected
      function GetWireCodec: TProtobufWireCodec<UnicodeString>; override;
  end;

implementation

uses
  // gProtobufWireCodecString as field codec
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufString;

// TProtobufRepeatedDelimitedFieldValues<UnicodeString> implementation

function TProtobufRepeatedStringFieldValues.GetWireCodec: TProtobufWireCodec<UnicodeString>;
begin
  result := gProtobufWireCodecString as TProtobufStringWireCodec;
end;

end.
