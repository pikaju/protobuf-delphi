/// <summary>
/// Runtime library support for protobuf repeated fields of protobuf message types.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  // Basic definitions of <c>protoc-gen-delphi</c>, independent of the runtime library implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // Runtime library support for protobuf message types
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  // Support code for handling object values in repeated fields
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufRepeatedFieldObjects;

type
  /// <summary>
  /// Concrete subclass of <see cref="TProtobufRepeatedField"/> for protobuf repeated fields of a protobuf message type.
  /// </summary>
  /// <typeparam name="T">Delphi class that represents the protobuf message type of the field values</typeparam>
  TProtobufRepeatedMessageField<T: TProtobufMessage, constructor> = class(TProtobufRepeatedFieldObjects<T>);

implementation

end.
