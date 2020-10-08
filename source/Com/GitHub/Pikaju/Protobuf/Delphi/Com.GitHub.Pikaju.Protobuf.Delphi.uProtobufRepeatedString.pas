/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>string</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedString;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  // Basic definitions of <c>protoc-gen-delphi</c>, independent of the runtime library implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // Support code for handling primitive values in repeated fields
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufRepeatedFieldPrimitives;

type
  /// <summary>
  /// Concrete subclass of <see cref="TProtobufRepeatedField"/> for protobuf repeated fields of the protobuf type <c>string</c>.
  /// </summary>
  TProtobufRepeatedStringField = class(TProtobufRepeatedFieldPrimitives<UnicodeString>)
  protected
    function ConstructElement: UnicodeString; override;
  end;

implementation

function TProtobufRepeatedStringField.ConstructElement: UnicodeString;
begin
  result := PROTOBUF_DEFAULT_VALUE_STRING;
end;

end.
