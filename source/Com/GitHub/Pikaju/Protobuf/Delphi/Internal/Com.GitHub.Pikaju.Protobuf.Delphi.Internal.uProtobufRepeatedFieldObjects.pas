/// <summary>
/// Support code for handling of object values in <see cref="uProtobufRepeatedField"/>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufRepeatedFieldObjects;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // For TObjectList storage
  Generics.Collections,
  // Runtime library support for protobuf repeated fields
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

type
  /// <summary>
  /// Helper subclass of <see cref="TProtobufRepeatedField"/> for type parameters that are default-constructable object types.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  TProtobufRepeatedFieldObjects<T: constructor> = class abstract (TProtobufRepeatedField<T>)
  private
    /// <summary>
    /// Backing storage for <see cref="GetStorage"/> using object values.
    /// The list manages ownership of its elements.
    /// </summary>
    FStorage: TObjectList<T>;

  protected
    function GetStorage: TList<T>; override;
    function ConstructElement: T; override;

  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

constructor TProtobufRepeatedFieldObjects<T>.Create;
begin
  FStorage := TObjectList<T>.Create;
end;

destructor TProtobufRepeatedFieldObjects<T>.Destroy;
begin
  FStorage.Free;
end;

function TProtobufRepeatedFieldObjects<T>.GetStorage: TList<T>;
begin
  result := FStorage;
end;

function TProtobufRepeatedFieldObjects<T>.ConstructElement: T;
begin
  result := T.Create;
end;

end.
