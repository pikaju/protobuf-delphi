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
/// Runtime support interface for protobuf message types.
/// </summary>
/// <remarks>
/// This unit defines the common interface of all generated classes representing protobuf message types, <see cref="IProtobufMessage"/>.
/// Client code should reference it indirectly through <see cref="N:Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uProtobufMessage"/>.
/// </remarks>
unit Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // TStream for encoding and decoding of messages
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes,
{$ELSE}
  Classes,
{$ENDIF}
  // To declare custom exceptions
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.SysUtils;
{$ELSE}
  SysUtils;
{$ENDIF}

type
  /// <summary>
  /// Indicates that protobuf decoding failed since a message was not compatible with its expected schema.
  /// </summary>
  EDecodingSchemaError = class(Exception);

  /// <summary>
  /// Common interface of all generated classes that represent protobuf message types.
  /// </summary>
  /// <remarks>
  /// Can be used directly to handle messages of unknown type.
  /// The message instance carries transitive ownership of embedded objects in protobuf field values,
  /// and is responsible for their deallocation.
  /// </remarks>
  IProtobufMessage = interface(IInterface)
    ['{95678C3F-5E26-4B5D-AFAB-0311928C3BA7}']

    /// <summary>
    /// Renders all protobuf fields absent by setting them to their default values.
    /// </summary>
    /// <remarks>
    /// The resulting instance state is equivalent to a newly constructed empty message.
    /// For more details, see the documentation of <see cref="M:Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uProtobufMessage.TProtobufMessage.Create"/>.
    /// This procedure may cause the destruction of transitively owned objects.
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    procedure Clear;

    /// <summary>
    /// Encodes the message using the protobuf binary wire format and writes it to a stream.
    /// </summary>
    /// <param name="aDest">The stream that the encoded message is written to</param>
    /// <remarks>
    /// Since the protobuf binary wire format does not include length information for top-level messages,
    /// the recipient may not be able to detect the end of the message when reading it from a stream.
    /// If this is required, use <see cref="EncodeDelimited"/> instead.
    /// </remarks>
    procedure Encode(aDest: TStream);

    /// <summary>
    /// Encodes the message using the protobuf binary wire format and writes it to a stream, prefixed with length information.
    /// </summary>
    /// <param name="aDest">The stream that the encoded message is written to</param>
    /// <remarks>
    /// Unlike <see cref="Encode"/>, this method enables the recipient to detect the end of the message by decoding it using
    /// <see cref="DecodeDelimited"/>.
    /// </remarks>
    procedure EncodeDelimited(aDest: TStream);

    /// <summary>
    /// Fills the message's protobuf fields by decoding the message using the protobuf binary wire format from data that is read from a stream.
    /// Data is read until <see cref="TStream.Read"/> returns 0.
    /// </summary>
    /// <param name="aSource">The stream that the data is read from</param>
    /// <exception cref="EDecodingSchemaError">If the message on the stream was not compatible with this message type</exception>
    /// <remarks>
    /// Protobuf fields that are not present in the read data are rendered absent by setting them to their default values.
    /// This may cause the destruction of transitively owned objects (this is also the case when a present fields overwrites a previous value).
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// This method should not be used on streams where the actual size of their contents may not be known yet (this might result in data loss).
    /// If this is required, use <see cref="DecodeDelimited"/> instead.
    /// </remarks>
    procedure Decode(aSource: TStream);

    /// <summary>
    /// Fills the message's protobuf fields by decoding the message using the protobuf binary wire format from data that is read from a stream.
    /// The data must be prefixed with message length information, as implemented by <see cref="EncodeDelimited"/>.
    /// </summary>
    /// <param name="aSource">The stream that the data is read from</param>
    /// <exception cref="EDecodingSchemaError">If the message on the stream was not compatible with this message type</exception>
    /// <remarks>
    /// See remarks on <see cref="Decode">.
    /// </remarks>
    procedure DecodeDelimited(aSource: TStream);
  end;

implementation

end.
