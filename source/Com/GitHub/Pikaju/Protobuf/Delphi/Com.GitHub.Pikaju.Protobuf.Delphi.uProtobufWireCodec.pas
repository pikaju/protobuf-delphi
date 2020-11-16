/// <summary>
/// Runtime library support code for encoding/decoding of
/// protobuf fields from/to the protobuf binary wire format.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement IProtobufWireCodec<T>
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufWireCodec,
  // IProtobufMessageInternal for IProtobufWireCodec<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal,
  // EDecodingSchemaError for IProtobufWireCodec<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage,
  // TProtobufFieldNumber for IProtobufWireCodec<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // TStream for encoding and decoding of messages
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes;
{$ELSE}
  Classes;
{$ENDIF}

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/>.
  /// </summary>
  TProtobufWireCodec<T> = class abstract(TInterfacedObject, IProtobufWireCodec<T>)
    /// <summary>
    /// Provides the default value of this codec's protobuf type.
    /// </summary>
    /// <returns>The protobuf type's default value</returns>
    function GetDefault: T; virtual; abstract;

    // IProtobufWireCodec<T> implementation

    public
      /// <summary>
      /// Encodes a protobuf singular field of a message using the protobuf binary wire format and writes it to a stream.
      /// </summary>
      /// <param name="aValue">Value of the field</param>
      /// <param name="aContainer">Protobuf message containing the field</param>
      /// <param name="aField">Protobuf field number of the field</param>
      /// <param name="aDest">The stream that the encoded field is written to</param>
      /// <remarks>
      /// This method is not used for message fields, see <see cref="IProtobufMessageInternal.EncodeAsSingularField"/>.
      /// This should be used within an implementation of <see cref="IProtobufMessage.Encode"/>, after calling the ancestor class implementation.
      /// </remarks>
      procedure EncodeSingularField(aValue: T; aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream); virtual; abstract;

      /// <summary>
      /// Decodes a previously unknown protobuf singular field of a message.
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
      /// This method is not idempotent. The state of the message is changed by the call, since decoding "consumes" the unknown field.
      /// </remarks>
      function DecodeUnknownField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber): T; virtual; abstract;
  end;

implementation

end.
