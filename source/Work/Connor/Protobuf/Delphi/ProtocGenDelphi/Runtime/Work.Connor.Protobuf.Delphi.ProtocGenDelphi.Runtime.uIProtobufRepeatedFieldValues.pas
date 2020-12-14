/// Copyright 2020 Connor Roehricht (connor.work)
/// Copyright 2020 Sotax AG
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

/// <summary>
/// Runtime support for protobuf repeated field values.
/// </summary>
/// <remarks>
/// Client code may need to reference this unit in order to operate on protobuf repeated fields.
/// </remarks>
unit Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufRepeatedFieldValues;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To provide a TEnumerator
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

type
  /// <summary>
  /// Ordered collection of protobuf field values that can be stored in a protobuf repeated field.
  /// </summary>
  /// <typeparam name="T">Delphi type representing the field values</typeparam>
  IProtobufRepeatedFieldValues<T> = interface(IInterface)
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
    procedure SetValue(aIndex: Integer; aValue: T);

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
    /// Merges the given field value collection (source) into this one (destination).
    /// The source field values are appended to the destination collection.
    /// If this causes a new message object to be added, a copy is created to preserve ownership.
    /// </summary>
    /// <param name="aSource">Field value collection to merge into this one</param>
    /// <remarks>
    /// The source collection must be a collection of protobuf field values of the same type.
    /// </remarks>
    procedure MergeFrom(aSource: IProtobufRepeatedFieldValues<T>);
  end;

implementation

end.
