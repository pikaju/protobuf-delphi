/// <summary>
/// Runtime library implementation of support code for handling protobuf repeated fields 
/// in generated Delphi code.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // For TEnumerable implementation and TList storage
  Generics.Collections;

type
  /// <summary>
  /// Collection of protobuf field values of a repeated field within a message type instance.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  TProtobufRepeatedField<T> = class(TEnumerable<T>)
  private
    /// <summary>
    /// Getter for <see cref="Count"/>.
    /// </summary>
    /// <returns>The number of field values</returns>
    function GetCount: Integer;

    /// <summary>
    /// Setter for <see cref="Count"/>.
    /// </summary>
    /// <param name="aCount">The new number of field values</param>
    procedure SetCount(aCount: Integer);

    /// <summary>
    /// Indexed getter for <see cref="Values"/>.
    /// </summary>
    /// <param name="aIndex">The index to read from</param>
    /// <returns>The field value at the specified index</returns>
    function GetValue(aIndex: Integer): T;

    /// <summary>
    /// Indexed setter for <see cref="Values"/>.
    /// </summary>
    /// <param name="aIndex">The index to write to</param>
    /// <param name="aValue">The new field value at the specified index</param>
    procedure SetValue(aIndex: Integer; aValue: T);

  public
    /// <summary>
    /// Constructs an empty repeated field.
    /// </summary>
    constructor Create; virtual; abstract;

    /// <summary>
    /// Destroys the repeated field and all objects and resources held by it, i.e., the protobuf field values and their transitively held resources.
    /// </summary>
    /// <remarks>
    /// Developers must ensure that no shared ownership of the field values or further nested embedded objects is held.
    /// </remarks>
    destructor Destroy; override; abstract;

    /// <summary>
    /// Gets or sets the actual number of protobuf field values in the repeated field.
    /// </summary>
    /// <remarks>
    /// If increased, new field values are appended to the repeated field, set to a default value (cf. <see cref="EmplaceAdd"/>).
    /// If reduced, field values at the end of the sequence are destroyed.
    /// Developers must ensure that no shared ownership of destroyed field values or further nested embedded objects is held.
    /// </remarks>
    property Count: Integer read GetCount write SetCount;

    /// <summary>
    /// Gets or sets a field value at a specified index.
    /// </summary>
    /// <remarks>
    /// When a field value is read, it is still owned by the repeated field and must not be destroyed.
    /// When a field value is written, the previous value is destroyed.
    /// Developers must ensure that no shared ownership of the destroyed field value or further nested embedded objects is held.
    /// </remarks>
    /// <param name="aIndex">The index to access</param>
    property Values[aIndex: Integer]: T read GetValue write SetValue; default;

    /// <summary>
    /// Adds a field value to the end of the sequence.
    /// </summary>
    /// <param name="aValue">The field value to add</param>
    /// <returns>The index of the new field value</return>
    /// <remarks>
    /// This operation transfers ownership of the added field value to the repeated field.
    /// </remarks>
    function Add(const aValue: T): Integer;

    /// <summary>
    /// Adds a default field value to the end of the sequence.
    /// </summary>
    /// <returns>The new field value</return>
    /// <remarks>
    /// The default value for a non-message field type is the protobuf default value for the type.
    /// The default value for a message field type is an empty instance of the message type.
    /// </remarks>
    function EmplaceAdd: T;

    /// <summary>
    /// Removes all field values.
    /// </summary>
    /// <remarks>
    /// Developers must ensure that no shared ownership of the destroyed field values or further nested embedded objects is held.
    /// </remarks>
    procedure Clear;

    /// <summary>
    /// Removes and destroys a field value at the specified index.
    /// </summary>
    /// <param name="aIndex">The index to delete at</param>
    /// <remarks>
    /// Developers must ensure that no shared ownership of the destroyed field value or further nested embedded objects is held.
    /// </remarks>
    procedure Delete(aIndex: Integer);

    /// <summary>
    /// Removes a field value at the specified index and transfers ownership to the caller.
    /// </summary>
    /// <param name="aIndex">The index to extract a value from</param>
    /// <remarks>
    /// Unlike <see cref="Delete"/>, this method does not destroy the value. The caller is reponsible for managing (and eventually releasing)
    /// all resources held by the value.
    /// </remarks>
    function ExtractAt(aIndex: Integer): T;

    /// <summary>
    /// Returns the repeated field's enumerator of field values to implement <see cref="TEnumerable"/>.
    /// </summary>
    /// <returns>Enumerator of the field values in sequence order</returns>
    function DoGetEnumerator: TEnumerator<T>; override;
  
  protected
    /// <summary>
    /// Getter for <see cref="Storage"/>.
    /// </summary>
    /// <returns>The internal backing storage</returns>
    function GetStorage: TList<T>; virtual; abstract;

    /// <summary>
    /// Internal list as backing storage for field values.
    /// </summary>
    property Storage: TList<T> read GetStorage;

    /// <summary>
    /// Constructs a new default field value for insertion into the backing storage.
    /// </summary>
    /// <returns>The new field value</returns>
    /// <remarks>
    /// The default value for a non-message field type is the protobuf default value for the type.
    /// The default value for a message field type is an empty instance of the message type.
    /// </remarks>
    function ConstructElement: T; virtual; abstract;
  end;

implementation

function TProtobufRepeatedField<T>.GetCount;
begin
  result := Storage.Count;
end;

procedure TProtobufRepeatedField<T>.SetCount(aCount: Integer);
var
  lOldCount: Integer;
  lIndex: Integer;
begin
  lOldCount := Storage.Count;
  Storage.Count := aCount;
  for lIndex := lOldCount to aCount - 1 do Storage[lIndex] := ConstructElement;
end;

function TProtobufRepeatedField<T>.GetValue(aIndex: Integer): T;
begin
  result := Storage[aIndex];
end;

procedure TProtobufRepeatedField<T>.SetValue(aIndex: Integer; aValue: T);
begin
  Storage[aIndex] := aValue;
end;

function TProtobufRepeatedField<T>.Add(const aValue: T): Integer;
begin
  Storage.Add(aValue);
end;

function TProtobufRepeatedField<T>.EmplaceAdd: T;
begin
  Count := Count + 1;
  result := GetValue(Count - 1);
end;

procedure TProtobufRepeatedField<T>.Clear;
begin
  Storage.Clear;
end;

procedure TProtobufRepeatedField<T>.Delete(aIndex: Integer);
begin
  Storage.Delete(aIndex);
end;

function TProtobufRepeatedField<T>.ExtractAt(aIndex: Integer): T;
begin
  result := Storage.ExtractIndex(aIndex);
end;

function TProtobufRepeatedField<T>.DoGetEnumerator: TEnumerator<T>;
begin
  result := Storage.GetEnumerator;
end;

end.
