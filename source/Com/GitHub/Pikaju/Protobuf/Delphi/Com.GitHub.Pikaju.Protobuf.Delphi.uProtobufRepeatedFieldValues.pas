/// <summary>
/// Runtime library support code for protobuf repeated fields.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement IProtobufRepeatedFieldValues<T>
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufRepeatedFieldValues,
  // To implement IProtobufRepeatedFieldValuesInternal<T>
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufRepeatedFieldValuesInternal,
  // To extend TInterfacedPersistent
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes,
{$ELSE}
  Classes,
{$ENDIF}
  // IProtobufMessageInternal for IProtobufRepeatedFieldValuesInternal<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal,
  // EDecodingSchemaError for IProtobufRepeatedFieldValuesInternal<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage,
  // ProtobufFieldNumber for IProtobufRepeatedFieldValuesInternal<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // TList for storage and TEnumerator for IProtobufRepeatedFieldValues<T> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufRepeatedFieldValuesInternal"/>.
  /// </summary>
  TProtobufRepeatedFieldValues<T> = class abstract(TInterfacedPersistent, IProtobufRepeatedFieldValues<T>, IProtobufRepeatedFieldValuesInternal<T>)
    private
      /// <summary>
      /// Owner of the field value collection, which is responsible for freeing it. This might be a containing message.
      /// </summary>
      FOwner: TPersistent;

    // Abstract members

    public
      /// <summary>
      /// Constructs an empty ordered collection of protobuf field values that can be stored in a protobuf repeated field..
      /// </summary>
      constructor Create; virtual; abstract;

      /// <summary>
      /// Destroys the field value collection and contained protobuf field values.
      /// </summary>
      /// <remarks>
      /// Developers must ensure that no shared ownership of the field values or further nested embedded objects is held.
      /// </remarks>
      destructor Destroy; override; abstract;

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

      /// <summary>
      /// Copies the protobuf field values from another collection to this one.
      /// </summary>
      /// <param name="aSource">Collection to copy from</param>
      /// <remarks>
      /// Performs a deep copy; hence, no ownership is shared.
      /// </remarks>
      procedure AssignFieldValues(aSource: TProtobufRepeatedFieldValues<T>); virtual; abstract;

    // IProtobufRepeatedFieldValuesInternal<T> implementation (partially abstract)

    public

      /// <summary>
      /// Encodes a protobuf repeated field with these values, using the protobuf binary wire format, and writes it to a stream.
      /// </summary>
      /// <param name="aContainer">Protobuf message containing the field</param>
      /// <param name="aField">Protobuf field number of the field</param>
      /// <param name="aDest">The stream that the encoded field is written to</param>
      /// <remarks>
      /// This should be used within an implementation of <see cref="IProtobufMessage.Encode"/>, after calling the ancestor class implementation.
      /// </remarks>
      procedure EncodeAsRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream); virtual; abstract;

      /// <summary>
      /// Decodes a previously unknown protobuf repeated field of a message, using the protobuf binary wire format, and stores the values in this instance.
      /// The field is then no longer considered unknown.
      /// </summary>
      /// <param name="aContainer">Protobuf message containing the field</param>
      /// <param name="aField">Protobuf field number of the field</param>
      /// <exception cref="EDecodingSchemaError">If the unknown field values were not compatible with the expected protobuf type</exception>
      /// <remarks>
      /// This should be used within an implementation of <see cref="IProtobufMessage.Decode"/>, after calling the ancestor class implementation.
      /// This method is not idempotent. The state of the containing message is changed by the call, since decoding "consumes" the unknown field.
      /// Ownership of this collection must be held by the containing message.
      /// This method may destroy existing field values held by this collection. Developers must ensure that no shared ownership of the destroyed field values or further nested embedded objects is held.
      /// </remarks>
      procedure DecodeAsUnknownRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber); virtual; abstract;

      /// <summary>
      /// Sets the owner of the field value collection, which is responsible for freeing it. This might be a containing message.
      /// </summary>
      /// <param name="aOwner">The new owner of the collection</param>
      procedure SetOwner(aOwner: TPersistent);

    // IProtobufRepeatedFieldValues<T> implementation (partially abstract)

    public
      /// <summary>
      /// Returns an enumerator for the protobuf field values, which enables usage of <c>for..in</c> loops.
      /// </summary>
      /// <returns>Enumerator for the protobuf field values, in order</returns>
      function GetEnumerator: TEnumerator<T>;

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
      /// Gets or sets the actual number of protobuf field values in the repeated field.
      /// </summary>
      /// <remarks>
      /// If increased, new field values are appended to the repeated field, set to a default value (cf. <see cref="EmplaceAdd"/>).
      /// If reduced, field values at the end of the sequence are destroyed.
      /// Developers must ensure that no shared ownership of destroyed field values or further nested embedded objects is held.
      /// </remarks>
      property Count: Integer read GetCount write SetCount;

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
      procedure SetValue(aIndex: Integer; aValue: T); virtual;

      /// <summary>
      /// Gets or sets a field value at a specified index.
      /// </summary>
      /// <remarks>
      /// When a field value is read, it is still owned by the repeated field and must not be destroyed.
      /// When a field value is written, the previous value is destroyed and ownership of the new field value is transferred to the repeated field.
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
      function Add(const aValue: T): Integer; virtual;

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
      function ExtractAt(aIndex: Integer): T; virtual;

      /// <summary>
      /// Merges the given field value collection (source) into this one (destination).
      /// The source field values are appended to the destination collection.
      /// If this causes a new message object to be added, a copy is created to preserve ownership.
      /// </summary>
      /// <param name="aSource">Field value collection to merge into this one</param>
      /// <remarks>
      /// The source collection must be a collection of protobuf field values of the same type.
      /// </remarks>
      procedure MergeFrom(aSource: IProtobufRepeatedFieldValues<T>); virtual; abstract;

    // TInterfacedPersistent implementation

    public
      /// <summary>
      /// Copies the protobuf data from another object to this one.
      /// </summary>
      /// <param name="aSource">Object to copy from</param>
      /// <remarks>
      /// The other object must be a collection of protobuf field values of the same type.
      /// This performs a deep copy; hence, no ownership is shared.
      /// This procedure may cause the destruction of transitively owned objects in this collection.
      /// Developers must ensure that no shared ownership of the field values or further nested embedded objects is held.
      /// </remarks>
      procedure Assign(aSource: TPersistent); override;

      function GetOwner: TPersistent; override;
  end;

implementation

// IProtobufRepeatedFieldValuesInternal<T> implementation

procedure TProtobufRepeatedFieldValues<T>.SetOwner(aOwner: TPersistent);
begin
  FOwner := aOwner;
end;

// IProtobufRepeatedFieldValues<T> implementation

function TProtobufRepeatedFieldValues<T>.GetEnumerator: TEnumerator<T>;
begin
  result := Storage.GetEnumerator;
end;

function TProtobufRepeatedFieldValues<T>.GetCount: Integer;
begin
  result := Storage.Count;
end;

procedure TProtobufRepeatedFieldValues<T>.SetCount(aCount: Integer);
var
  lOldCount: Integer;
  lIndex: Integer;
begin
  lOldCount := Storage.Count;
  Storage.Count := aCount;
  for lIndex := lOldCount to aCount - 1 do Storage[lIndex] := ConstructElement;
end;

function TProtobufRepeatedFieldValues<T>.GetValue(aIndex: Integer): T;
begin
  result := Storage[aIndex];
end;

procedure TProtobufRepeatedFieldValues<T>.SetValue(aIndex: Integer; aValue: T);
begin
  Storage[aIndex] := aValue;
end;

function TProtobufRepeatedFieldValues<T>.Add(const aValue: T): Integer;
begin
  Storage.Add(aValue);
end;

function TProtobufRepeatedFieldValues<T>.EmplaceAdd: T;
begin
  Count := Count + 1;
  result := GetValue(Count - 1);
end;

procedure TProtobufRepeatedFieldValues<T>.Clear;
begin
  Storage.Clear;
end;

procedure TProtobufRepeatedFieldValues<T>.Delete(aIndex: Integer);
begin
  Storage.Delete(aIndex);
end;

function TProtobufRepeatedFieldValues<T>.ExtractAt(aIndex: Integer): T;
begin
{$IFDEF FPC}
  result := Storage.ExtractIndex(aIndex);
{$ELSE}
  result := Storage.ExtractAt(aIndex);
{$ENDIF}
end;

// TInterfacedPersistent implementation

procedure TProtobufRepeatedFieldValues<T>.Assign(aSource: TPersistent);
var
  lSource: TProtobufRepeatedFieldValues<T>;
begin
  lSource := aSource as TProtobufRepeatedFieldValues<T>;
  AssignFieldValues(lSource);
end;

function TProtobufRepeatedFieldValues<T>.GetOwner: TPersistent;
begin
  result := FOwner;
end;

end.
