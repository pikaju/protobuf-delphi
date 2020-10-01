unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // TStream for encoding and decoding of messages in the protobuf binary wire format
  Classes,
  Generics.Collections,
  Sysutils,
  // Basic definitions of <c>protoc-gen-delphi</c>, independent of the runtime library implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // Runtime library support for protobuf field encoding/decoding
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // Runtime library support for protobuf repeated fields
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufVarint;

type
  /// <summary>
  /// Common ancestor of all generated classes that represent protobuf message types.
  /// </summary>
  /// <remarks>
  /// Can be used directly to handle messages of unknown type.
  /// The message instance carries transitive ownership of embedded objects in protobuf field values,
  /// and is responsible for their deallocation.
  /// </remarks>
  TProtobufMessage = class

  public
    /// <summary>
    /// Constructs an empty message with all protobuf fields absent, meaning that they are set to their default values.
    /// </summary>
    /// <remarks>
    /// Protobuf's interpretation of the absence of a field may be counterintuitive for Delphi developers.
    /// For a detailed explanation, see https://developers.google.com/protocol-buffers/docs/proto3#default.
    /// </remarks>
    constructor Create; virtual;

    /// <summary>
    /// Destroys the message and all objects and resources held by it, including the protobuf field values.
    /// </summary>
    /// <remarks>
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    destructor Destroy; override;

    /// <summary>
    /// Renders all protobuf fields absent by setting them to their default values.
    /// </summary>
    /// <remarks>
    /// The resulting instance state is equivalent to a newly constructed empty message.
    /// For more details, see the documentation of <see cref="Create"/>.
    /// This procedure may cause the destruction of transitively owned objects.
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    procedure Clear; virtual;

    /// <summary>
    /// Encodes the message using the protobuf binary wire format and writes it to a stream.
    /// </summary>
    /// <param name="aDest">The stream that the encoded message is written to</param>
    /// <remarks>
    /// Since the protobuf binary wire format does not include length information for top-level messages,
    /// the recipient may not be able to detect the end of the message when reading it from a stream.
    /// If this is required, use <see cref="EncodeDelimited"/> instead.
    /// </remarks>
    procedure Encode(aDest: TStream); virtual;

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
    /// <remarks>
    /// Protobuf fields that are not present in the read data are rendered absent by setting them to their default values.
    /// This may cause the destruction of transitively owned objects (this is also the case when a present fields overwrites a previous value).
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// This method should not be used on streams where the actual size of their contents may not be known yet (this might result in data loss).
    /// If this is required, use <see cref="DecodeDelimited"/> instead.
    /// </remarks>
    procedure Decode(aSource: TStream); virtual;

    /// <summary>
    /// Fills the message's protobuf fields by decoding the message using the protobuf binary wire format from data that is read from a stream.
    /// The data must be prefixed with message length information, as implemented by <see cref="EncodeDelimited"/>.
    /// </summary>
    /// <param name="aSource">The stream that the data is read from</param>
    /// <remarks>
    /// See remarks on <see cref="Decode">.
    /// </remarks>
    procedure DecodeDelimited(aSource: TStream);

  protected
    /// <summary>
    /// Encodes a protobuf field with a specific protobuf type using the protobuf binary wire format and writes it to a stream.
    /// </summary>
    /// <typeparam name="T">"Private" Delphi type representing values of the field within internal variables</typeparam>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <param name="aCodec">Field codec that specifies the encoding to the binary wire format of the protobuf type</param>
    /// <param name="aDest">The stream that the encoded field is written to</param>
    /// <remarks>
    /// This method is not used for message fields, see <see cref="EncodeMessageField"/>.
    /// This should be used within an implementation of <see cref="Encode"/>, after calling the ancestor class implementation.
    /// </remarks>
    procedure EncodeField<T>(aValue: T; aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TStream);

    /// <summary>
    /// Encodes a protobuf field with a specific protobuf message type (<i>message field</i>) using the protobuf binary wire format and writes it to a stream.
    /// </summary>
    /// <typeparam name="T">Delphi type representing the protobuf message type of the field</typeparam>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <param name="aDest">The stream that the encoded field is written to</param>
    /// <remarks>
    /// This should be used within an implementation of <see cref="Encode"/>, after calling the ancestor class implementation.
    /// </remarks>
    procedure EncodeMessageField<T: TProtobufMessage>(aValue: T; aField: TProtobufFieldNumber; aDest: TStream);

    /// <summary>
    /// TODO doc, TODO packing?
    /// </summary>
    procedure EncodeRepeatedField<T>(aSource: TProtobufRepeatedField<T>; aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TStream);

    /// <summary>
    /// Decodes a previously unknown protobuf field with a specific protobuf type.
    /// </summary>
    /// <typeparam name="T">"Private" Delphi type representing values of the field within internal variables</typeparam>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <param name="aCodec">Field codec that specifies the decoding from the binary wire format of the protobuf type</param>
    /// <returns>The decoded field value</returns>
    /// <remarks>
    /// This method is not used for message fields, see <see cref="DecodeUnknownMessageField"/>.
    /// This should be used within an implementation of <see cref="Decode"/>, after calling the ancestor class implementation.
    /// This method is not idempotent. The state of this instance is changed by the call, since decoding "consumes" the unknown field.
    /// </remarks>
    function DecodeUnknownField<T>(aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>): T;

    /// <summary>
    /// Decodes a previously unknown protobuf field with a specific protobuf message type (<i>message field</i>).
    /// If the field is present, an instance representing the embedded message is constructed and filled using <see cref="Create"/> and <see cref="Decode"/>.
    /// The field is then no longer considered unknown.
    /// If the field is present multiple times, the last value is used, see https://developers.google.com/protocol-buffers/docs/encoding#optional.
    /// If the field is absent, <c>nil</c> is returned (which is the representation of the default value).
    /// </summary>
    /// <typeparam name="T">Delphi type representing the protobuf message type of the field</typeparam>
    /// <param name="aField">Protobuf field number of the field</param>
    /// <returns>The decoded field value</returns>
    /// <remarks>
    /// This should be used within an implementation of <see cref="Decode"/>, after calling the ancestor class implementation.
    /// This method is not idempotent. The state of this instance is changed by the call, since decoding "consumes" the unknown field.
    /// Ownership of the returned object, if one is allocated, is transferred to the caller (which should be an instance of a descendant class).
    /// </remarks>
    function DecodeUnknownMessageField<T: TProtobufMessage>(aField: TProtobufFieldNumber): T;
    
    /// <summary>
    /// TODO doc
    /// </summary>
    procedure DecodeUnknownRepeatedField<T>(aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TProtobufRepeatedField<T>);

  private
    /// <summary>
    /// Collection of all fields in a Protobuf message that are yet to be decoded (<i>unparsed</i>).
    /// Fields are indexed by their field number, and stored in a list to support non-packed repeated fields.
    /// </summary>
    type TEncodedFieldsMap = TDictionary<TProtobufFieldNumber, TObjectList<TProtobufEncodedField>>;

  private // private keyword required to prevent compilation issues
    /// <summary>
    /// Unparsed fields in this message. See <see cref="TEncodedFieldsMap"/> for details.
    /// </summary>
    FUnparsedFields: TEncodedFieldsMap;
  end;

implementation

constructor TProtobufMessage.Create;
begin
  FUnparsedFields := TEncodedFieldsMap.Create;
end;

destructor TProtobufMessage.Destroy;
begin
  FUnparsedFields.Free;
end;

procedure TProtobufMessage.Clear;
begin;
  FUnparsedFields.Clear;
end;

procedure TProtobufMessage.Encode(aDest: TStream);
var
  lEncodedFieldList: TList<TProtobufEncodedField>;
  lEncodedField: TProtobufEncodedField;
begin
  for lEncodedFieldList in FUnparsedFields.Values do
  begin
    for lEncodedField in lEncodedFieldList do
      lEncodedField.Encode(aDest);
  end;
end;

procedure TProtobufMessage.EncodeDelimited(aDest: TStream);
var
  lTempStream: TStream;
  lLength: UInt64;
begin
  lTempStream := TMemoryStream.Create;
  try
    Encode(lTempStream);
    lTempStream.Seek(0, soBeginning);
    lLength := lTempStream.Size;
    EncodeVarint(lLength, aDest);
    aDest.CopyFrom(lTempStream, lLength);
  finally
    lTempStream.Free;
  end;
end;

procedure TProtobufMessage.Decode(aSource: TStream);
var
  lEncodedField: TProtobufEncodedField;
begin
  FUnparsedFields.Clear;
  while (aSource.Position < aSource.Size) do
  begin
    lEncodedField := TProtobufEncodedField.Create;
    lEncodedField.Decode(aSource);
    if (not FUnparsedFields.ContainsKey(lEncodedField.Tag.FieldNumber)) then
      FUnparsedFields.Add(lEncodedField.Tag.FieldNumber, TObjectList<TProtobufEncodedField>.Create);
    FUnparsedFields[lEncodedField.Tag.FieldNumber].Add(lEncodedField);
  end;
end;

procedure TProtobufMessage.DecodeDelimited(aSource: TStream);
var
  lTempStream: TStream;
  lLength: UInt64;
begin
  lLength := DecodeVarint(aSource);
  lTempStream := TMemoryStream.Create;
  try
    lTempStream.CopyFrom(aSource, lLength);
    lTempStream.Seek(0, soBeginning);
    Decode(lTempStream);
  finally
    lTempStream.Free;
  end;
end;

procedure TProtobufMessage.EncodeField<T>(aValue: T; aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TStream);
begin
  aCodec.EncodeField(aField, aValue, aDest);
end;

procedure TProtobufMessage.EncodeMessageField<T>(aValue: T; aField: TProtobufFieldNumber; aDest: TStream);
var
  lStream: TStream;
begin
  // Encode the message to a temporary stream first to determine its size.
  lStream := TMemoryStream.Create;
  try
    aValue.Encode(lStream);
    lStream.Seek(0, soBeginning);

    TProtobufTag.WithData(aField, wtLengthDelimited).Encode(aDest);
    EncodeVarint(lStream.Size, aDest);
    aDest.CopyFrom(lStream, lStream.Size);
  finally
    lStream.Free;
  end;
end;

procedure TProtobufMessage.EncodeRepeatedField<T>(aSource: TProtobufRepeatedField<T>; aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TStream);
begin
  // TODO not implemented
end;

function TProtobufMessage.DecodeUnknownField<T>(aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>): T;
begin
  if (FUnparsedFields.ContainsKey(aField)) then
  begin
    result := aCodec.DecodeField(FUnparsedFields[aField]);
    FUnparsedFields.Remove(aField);
  end;
end;

function TProtobufMessage.DecodeUnknownMessageField<T>(aField: TProtobufFieldNumber): T;
var
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  result := T(PROTOBUF_DEFAULT_VALUE_MESSAGE);

  if (FUnparsedFields.ContainsKey(aField)) then
  begin
    // TODO: Merge multiple messages together, see:
    // https://developers.google.com/protocol-buffers/docs/encoding#optional:
    for lField in FUnparsedFields[aField] do
    begin
      if (lField.Tag.WireType = wtLengthDelimited) then
      begin
        // Convert field to a stream for simpler processing.
        lStream := TMemoryStream.Create;
        try
          lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
          lStream.Seek(0, soBeginning);

          // Ignore the length of the field and let the message decode until the end of the stream.
          DecodeVarint(lStream);
          if (result = T(PROTOBUF_DEFAULT_VALUE_MESSAGE)) then
            result := T.Create;
          
          result.Decode(lStream);
        finally
          lStream.Free;
        end;

      end; // TODO: Catch invalid wire type.
    end;

    FUnparsedFields.Remove(aField);
  end;
end;

procedure TProtobufMessage.DecodeUnknownRepeatedField<T>(aField: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TProtobufRepeatedField<T>);
begin
  // TODO not implemented
end;

end.
