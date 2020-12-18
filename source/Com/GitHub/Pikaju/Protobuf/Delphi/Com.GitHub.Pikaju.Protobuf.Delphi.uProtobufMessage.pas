/// <summary>
/// Runtime library support code for protobuf message types.
/// </summary>
/// <remarks>
/// This unit defines the common ancestor of all generated classes representing protobuf message types, <see cref="TProtobufMessage"/>.
/// Client code should reference it indirectly through <see cref="N:Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uProtobufMessage"/>.
/// </remarks>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement IProtobufMessage
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage,
  // To implement IProtobufMessageInternal
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal,
  // To extend TInterfacedPersistent, TStream for IProtobufMessage implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes,
{$ELSE}
  Classes,
{$ENDIF}
  // For handling protobuf encoded fields
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  // TProtobufFieldNumber for IProtobufMessageInternal implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // TDictionary and TObjectList for storing unparsed fields
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

type
  /// <summary>
  /// Common ancestor of all generated classes that represent protobuf message types.
  /// </summary>
  /// <remarks>
  /// Can be used directly to handle messages of unknown type.
  /// The message instance carries transitive ownership of embedded objects in protobuf field values,
  /// and is responsible for their deallocation.
  /// </remarks>
  TProtobufMessage = class(TInterfacedPersistent, IProtobufMessage, IProtobufMessageInternal)
    public
      /// <summary>
      /// Collection of all fields in a Protobuf message that are yet to be decoded (<i>unparsed</i>).
      /// Fields are indexed by their field number, and stored in a list to support non-packed repeated fields.
      /// </summary>
      type TEncodedFieldsMap = TDictionary<TProtobufFieldNumber, TObjectList<TProtobufEncodedField>>;

    private
      /// <summary>
      /// Owner of the message, which is responsible for freeing it. This might be a containing message or field value collection.
      /// </summary>
      FOwner: TPersistent;

      /// <summary>
      /// Unparsed fields in this message. See <see cref="TEncodedFieldsMap"/> for details.
      /// </summary>
      FUnparsedFields: TEncodedFieldsMap;

    public
      /// <summary>
      /// Unparsed fields in this message. See <see cref="TEncodedFieldsMap"/> for details.
      /// </summary>
      property UnparsedFields: TEncodedFieldsMap read FUnparsedFields;

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

    // IProtobufMessage implementation

    public
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
      /// <exception cref="EDecodingSchemaError">If the message on the stream was not compatible with this message type</exception>
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
      /// <exception cref="EDecodingSchemaError">If the message on the stream was not compatible with this message type</exception>
      /// <param name="aSource">The stream that the data is read from</param>
      /// <remarks>
      /// See remarks on <see cref="Decode">.
      /// </remarks>
      procedure DecodeDelimited(aSource: TStream);

      /// <summary>
      /// Merges the given message (source) into this one (destination).
      /// All singular present (non-default) scalar fields in the source replace those in the destination.
      /// All singular embedded messages are merged recursively.
      /// All repeated fields are concatenated, with the source field values being appended to the destination field.
      /// If this causes a new message object to be added, a copy is created to preserve ownership.
      /// </summary>
      /// <param name="aSource">Message to merge into this one</param>
      /// <remarks>
      /// The source message must be a protobuf message of the same type.
      /// This procedure does not cause the destruction of any transitively owned objects in this message instance (append-only).
      /// </remarks>
      procedure MergeFrom(aSource: IProtobufMessage); virtual;

    // IProtobufMessageInternal implementation

    public
      /// <summary>
      /// Tests if this message has a currently unknown protobuf field (found by <see cref="Decode"/>, but not decoded yet), with a known field number.
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
      /// This should be used within an implementation of <see cref="Encode"/>, after calling the ancestor class implementation.
      /// </remarks>
      procedure EncodeAsSingularField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);

      /// <summary>
      /// Decodes a previously unknown protobuf singular field of a message, which is assumed to be present, using the protobuf binary wire format, and stores the value in this instance (<i>message field</i>).
      /// If the field is present, this embedded message is filled using <see cref="Decode"/>.
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
      /// Ownership of this message is transferred to the containing message (<i>embedded message</i>).
      /// See also remarks on destruction of transitively owned objects on <see cref="Decode"/>.
      /// </remarks>
      procedure DecodeAsUnknownSingularField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber);

      /// <summary>
      /// Sets the owner of the message, which is responsible for freeing it. This might be a containing message or field value collection.
      /// </summary>
      /// <param name="aOwner">The new owner of the message</param>
      procedure SetOwner(aOwner: TPersistent);

    // TInterfacedPersistent implementation

    public
      /// <summary>
      /// Copies the protobuf data from another object to this one.
      /// </summary>
      /// <param name="aSource">Object to copy from</param>
      /// <remarks>
      /// The other object must be a protobuf message of the same type.
      /// This performs a deep copy; hence, no ownership is shared.
      /// This procedure may cause the destruction of transitively owned objects in this message instance.
      /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
      /// </remarks>
      procedure Assign(aSource: TPersistent); override;

      function GetOwner: TPersistent; override;
  end;

implementation

uses
  // For encoding and decoding of protobuf tags
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  // For encoding and decoding of varint type lengths
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint;

constructor TProtobufMessage.Create;
begin
  FUnparsedFields := TEncodedFieldsMap.Create;
end;

destructor TProtobufMessage.Destroy;
begin
  FUnparsedFields.Free;
end;

// IProtobufMessage implementation

procedure TProtobufMessage.Clear;
begin
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

procedure TProtobufMessage.MergeFrom(aSource: IProtobufMessage);
var
  lSource: TProtobufMessage;
  lFieldNumber: TProtobufFieldNumber;
  lEncodedField: TProtobufEncodedField;
  lFieldCopy: TProtobufEncodedField;
begin
  lSource := aSource as TProtobufMessage;
  for lFieldNumber in lSource.FUnparsedFields.Keys do
  begin
    if (not FUnparsedFields.ContainsKey(lFieldNumber)) then
      FUnparsedFields.Add(lFieldNumber, TObjectList<TProtobufEncodedField>.Create);
    for lEncodedField in lSource.FUnparsedFields[lFieldNumber] do
    begin
      lFieldCopy := TProtobufEncodedField.Create;
      lFieldCopy.Assign(lEncodedField);
      FUnparsedFields[lFieldNumber].Add(lFieldCopy);
    end;
  end;
end;

// IProtobufMessageInternal implementation

function TProtobufMessage.HasUnknownField(aField: TProtobufFieldNumber): Boolean;
begin
  result := FUnparsedFields.ContainsKey(aField);
end;

procedure TProtobufMessage.EncodeAsSingularField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);
var
  lStream: TStream;
begin
  // Encode the message to a temporary stream first to determine its size.
  lStream := TMemoryStream.Create;
  try
    Encode(lStream);
    lStream.Seek(0, soBeginning);

    TProtobufTag.WithData(aField, wtLengthDelimited).Encode(aDest);
    EncodeVarint(lStream.Size, aDest);
    aDest.CopyFrom(lStream, lStream.Size);
  finally
    lStream.Free;
  end;
end;

procedure TProtobufMessage.DecodeAsUnknownSingularField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber);
var
  lContainer: TProtobufMessage;
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  lContainer := aContainer as TProtobufMessage;
  // TODO: Merge multiple messages together, see:
  // https://developers.google.com/protocol-buffers/docs/encoding#optional:
  for lField in lContainer.FUnparsedFields[aField] do
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
        Decode(lStream);
      finally
        lStream.Free;
      end;

    end; // TODO: Catch invalid wire type.
  end;

  lContainer.FUnparsedFields.Remove(aField);
end;

procedure TProtobufMessage.SetOwner(aOwner: TPersistent);
begin
  FOwner := aOwner;
end;

// TInterfacedPersistent implementation

procedure TProtobufMessage.Assign(aSource: TPersistent);
var
  lSource: TProtobufMessage;
  lField: TProtobufFieldNumber;
  lEncodedField: TProtobufEncodedField;
  lCopiedField: TProtobufEncodedField;
begin
  lSource := aSource as TProtobufMessage;
  FUnparsedFields.Clear;
  for lField in lSource.FUnparsedFields.Keys do
  begin
    FUnparsedFields[lField] := TObjectList<TProtobufEncodedField>.Create;
    for lEncodedField in lSource.FUnparsedFields[lField] do
    begin
      lCopiedField := TProtobufEncodedField.Create;
      lCopiedField.Assign(lEncodedField);
      FUnparsedFields[lField].Add(lCopiedField);
    end;
  end;
end;

function TProtobufMessage.GetOwner: TPersistent;
begin
  result := FOwner;
end;

end.
