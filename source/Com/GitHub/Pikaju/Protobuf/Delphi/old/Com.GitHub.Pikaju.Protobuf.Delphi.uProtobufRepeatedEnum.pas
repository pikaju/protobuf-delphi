/// <summary>
/// Runtime library support for protobuf repeated fields of protobuf enum types.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedEnum;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  // Basic definitions of <c>protoc-gen-delphi</c>, independent of the runtime library implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // Support code for handling protobuf repeated fields
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufRepeatedFieldPrimitives;

type
  /// <summary>
  /// Concrete subclass of <see cref="TProtobufRepeatedField"/> for protobuf repeated fields of a protobuf enum type.
  /// </summary>
  /// <typeparam name="T">Delphi enumerated type that represents the protobuf enum type of the field values</typeparam>
  TProtobufRepeatedEnumField<T{: enum}>= class(TProtobufRepeatedFieldPrimitives<T>)
  protected
    function ConstructElement: T; override;
  end;

implementation

function TProtobufRepeatedEnumField<T>.ConstructElement: T;
begin
  FillChar(result, SizeOf(T), 0);
end;

end.
