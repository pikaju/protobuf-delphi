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
/// Runtime-internal support interface for protobuf repeated field values.
/// </summary>
/// <remarks>
/// Generated code needs to reference this unit in order to operate on protobuf repeated field values.
/// </remarks>
unit Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufRepeatedFieldValuesInternal;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend IProtobufRepeatedFieldValues
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufRepeatedFieldValues,
  // To operate on repeated fields in messages
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal,
  // Basic protobuf definitions like TProtobufFieldNumber
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // To throw EDecodingSchemaError
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage,
  // TStream for encoding of messages
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes;
{$ELSE}
  Classes;
{$ENDIF}

type
  /// <summary>
  /// Runtime-internal interface for implementations of <see cref="IProtobufRepeatedFieldValues"/>.
  /// </summary>
  /// <typeparam name="T">Delphi type representing the field values</typeparam>
  IProtobufRepeatedFieldValuesInternal<T> = interface(IProtobufRepeatedFieldValues<T>)
    /// <summary>
    /// Encodes a protobuf repeated field with these values, using the protobuf binary wire format, and writes it to a stream.
    /// </summary>
    /// <param name="aContainer">Protobuf message containing the field</param>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <param name="aDest">The stream that the encoded field is written to</param>
    /// <remarks>
    /// This should be used within an implementation of <see cref="IProtobufMessage.Encode"/>, after calling the ancestor class implementation.
    /// </remarks>
    procedure EncodeAsRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);

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
    procedure DecodeAsUnknownRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber);

    /// <summary>
    /// Sets the owner of the field value collection, which is responsible for freeing it. This might be a containing message.
    /// </summary>
    /// <param name="aOwner">The new owner of the collection</param>
    procedure SetOwner(aOwner: TPersistent);
  end;

implementation

end.
