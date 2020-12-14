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
/// Runtime-internal interface for <c>protoc-gen-delphi</c> <i>field codecs</i> that define the encoding/decoding of
/// protobuf fields from/to the protobuf binary wire format (<i>wire codecs</i>, see <see cref="T:IProtobufWireCodec"/>).
/// </summary>
unit Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufWireCodec;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // Runtime-internal support for message types
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal,
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
  /// <i>Field codec</i> for <c>protoc-gen-delphi</c> that defines the encoding/decoding of
  /// protobuf fields of a specific type (determined by the implementing class) from/to the protobuf binary wire format.
  /// </summary>
  /// <typeparam name="T">"Private" Delphi type representing values of the field within runtime-internal variables</typeparam>
  IProtobufWireCodec<T> = interface(IInterface)
    ['{6A1D7319-BEF7-4328-A9DF-253E2972207B}']
    /// <summary>
    /// Encodes a protobuf singular field of a message, using the protobuf binary wire format, and writes it to a stream.
    /// </summary>
    /// <param name="aValue">Value of the field</param>
    /// <param name="aContainer">Protobuf message containing the field</param>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <param name="aDest">The stream that the encoded field is written to</param>
    /// <remarks>
    /// This method is not used for message fields, see <see cref="IProtobufMessageInternal.EncodeAsSingularField"/>.
    /// This should be used within an implementation of <see cref="IProtobufMessage.Encode"/>, after calling the ancestor class implementation.
    /// </remarks>
    procedure EncodeSingularField(aValue: T; aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);

    /// <summary>
    /// Decodes a previously unknown protobuf singular field of a message, using the protobuf binary wire format.
    /// The field is then no longer considered unknown.
    /// If the field is present multiple times, the last value is used, see https://developers.google.com/protocol-buffers/docs/encoding#optional.
    /// If the field is absent, the default value for the protobuf type is returned.
    /// </summary>
    /// <param name="aContainer">Protobuf message containing the field</param>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <returns>The decoded field value</returns>
    /// <exception cref="EDecodingSchemaError">If the unknown field value was not compatible with the expected type</exception>
    /// <remarks>
    /// This method is not used for message fields, see <see cref="IProtobufMessageInternal.DecodeAsUnknownSingularField"/>.
    /// This should be used within an implementation of <see cref="IProtobufMessage.Decode"/>, after calling the ancestor class implementation.
    /// This method is not idempotent. The state of the containing message is changed by the call, since decoding "consumes" the unknown field.
    /// </remarks>
    function DecodeUnknownField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber): T;
  end;

implementation

end.
