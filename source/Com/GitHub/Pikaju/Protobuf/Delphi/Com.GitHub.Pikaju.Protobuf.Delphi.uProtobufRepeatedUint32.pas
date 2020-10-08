/// <summary>
/// Runtime library support for protobuf repeated fields of the protobuf type <c>uint32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedUint32;

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
  /// Concrete subclass of <see cref="TProtobufRepeatedField"/> for protobuf repeated fields of the protobuf type <c>uint32</c>.
  /// </summary>
  TProtobufRepeatedUint32Field = class(TProtobufRepeatedFieldPrimitives<UInt32>)
  protected
    function ConstructElement: UInt32; override;
  end;

implementation

function TProtobufRepeatedUint32Field.ConstructElement: UInt32;
begin
  result := PROTOBUF_DEFAULT_VALUE_UINT32;
end;

end.
