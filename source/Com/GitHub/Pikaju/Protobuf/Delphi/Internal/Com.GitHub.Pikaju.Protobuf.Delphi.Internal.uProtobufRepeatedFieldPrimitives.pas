/// <summary>
/// Support code for handling of primitive values in <see cref="uProtobufRepeatedField"/>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufRepeatedFieldPrimitives;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // For TList storage
  Generics.Collections,
  // Runtime library support for protobuf repeated fields
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

type
  /// <summary>
  /// Helper subclass of <see cref="TProtobufRepeatedField"/> for type parameters that are object types.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  TProtobufRepeatedFieldPrimitives<T> = class abstract (TProtobufRepeatedField<T>)
  private
    /// <summary>
    /// Backing storage for <see cref="GetStorage"/> using primitive values.
    /// </summary>
    FStorage: TList<T>;

  protected
    function GetStorage: TList<T>; override;
    function ConstructElement: T; override; abstract;

  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

constructor TProtobufRepeatedFieldPrimitives<T>.Create;
begin
  FStorage := TList<T>.Create;
end;

destructor TProtobufRepeatedFieldPrimitives<T>.Destroy;
begin
  FStorage.Free;
end;

function TProtobufRepeatedFieldPrimitives<T>.GetStorage: TList<T>;
begin
  result := FStorage;
end;

end.
