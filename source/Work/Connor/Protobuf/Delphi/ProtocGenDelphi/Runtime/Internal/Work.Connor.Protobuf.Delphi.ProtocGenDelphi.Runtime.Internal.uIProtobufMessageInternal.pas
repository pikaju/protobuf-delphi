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
/// Runtime-internal support interface for protobuf message types.
/// </summary>
/// <remarks>
/// Generated code needs to reference this unit in order to operate on protobuf messages.
/// </remarks>
unit Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend IProtobufMessage
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage,
  // Basic protobuf definitions like TProtobufFieldNumber
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // TStream for encoding of messages
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes;
{$ELSE}
  Classes;
{$ENDIF}

type
  /// <summary>
  /// Common runtime-internal interface of all generated classes that represent protobuf message types.
  /// </summary>
  /// <remarks>
  /// Can be used directly to handle messages of unknown type.
  /// The message instance carries transitive ownership of embedded objects in protobuf field values,
  /// and is responsible for their deallocation.
  /// </remarks>
  IProtobufMessageInternal = interface(IProtobufMessage)
    ['{1502E219-B7C4-4CD3-9D6C-DBDA1776DBD9}']
    /// <summary>
    /// Tests if this message has a currently unknown protobuf field (found by <see cref="IProtobufMessage.Decode"/>, but not decoded yet), with a known field number.
    /// </summary>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <returns><c>true</c> if this message has a currently unknown protobuf field with the specified number</returns>
    function HasUnknownField(aField: TProtobufFieldNumber): Boolean;

    /// <summary>
    /// Encodes a protobuf singular field of a message, with this instance as value (<i>message field</i>), using the protobuf binary wire format, and writes it to a stream.
    /// </summary>
    /// <param name="aContainer">Protobuf message containing the field</param>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <param name="aDest">The stream that the encoded field is written to</param>
    /// <remarks>
    /// For convenience, this method may be called on a <c>nil</c> value, since this is the representation for the default value of a protobuf message field.
    /// This should be used within an implementation of <see cref="IProtobufMessage.Encode"/>, after calling the ancestor class implementation.
    /// </remarks>
    procedure EncodeAsSingularField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);

    /// <summary>
    /// Decodes a previously unknown protobuf singular field of a message, which is assumed to be present, using the protobuf binary wire format, and stores the value in this instance (<i>message field</i>).
    /// If the field is present, this embedded message is filled using <see cref="IProtobufMessage.Decode"/>.
    /// The field is then no longer considered unknown.
    /// If the field is present multiple times, the message values are merged, see https://developers.google.com/protocol-buffers/docs/encoding#optional.
    /// </summary>
    /// <param name="aContainer">Protobuf message containing the field</param>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <exception cref="EDecodingSchemaError">If the field was absent</exception>
    /// <exception cref="EDecodingSchemaError">If the unknown field value was not compatible with this message type</exception>
    /// <remarks>
    /// This should be used within an implementation of <see cref="IProtobufMessage.Decode"/>, after calling the ancestor class implementation.
    /// This method is not idempotent. The state of the containing message is changed by the call, since decoding "consumes" the unknown field.
    /// Ownership of this message must be held by the containing message (<i>embedded message</i>).
    /// See also remarks on destruction of transitively owned objects on <see cref="IProtobufMessage.Decode"/>.
    /// </remarks>
    procedure DecodeAsUnknownSingularField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber);

    /// <summary>
    /// Sets the owner of the message, which is responsible for freeing it. This might be a containing message or field value collection.
    /// </summary>
    /// <param name="aOwner">The new owner of the message</param>
    procedure SetOwner(aOwner: TPersistent);
    end;

implementation

end.
