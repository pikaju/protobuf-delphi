unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag;

type
  // Base class for Protobuf messages.
  // Can be used to encode to / decode from binary data according to the Protobuf
  // specification, see https://developers.google.com/protocol-buffers/docs/encoding.
  TProtobufMessage = class
  private
    // Collection of all fields in a Protobuf message that are yet to be decoded.
    // Fields are indexed by their field number, and stored in a list to support
    // non-packed repeated fields.
    type TEncodedFieldsMap = TDictionary<TProtobufFieldNumber, TObjectList<TProtobufEncodedField>>;

  private // private keyword required to prevent compilation issues.
    FUnparsedFields: TEncodedFieldsMap;
  
  protected
    procedure EncodeField<T>(aFieldNumber: TProtobufFieldNumber; aValue: T; aCodec: TProtobufWireCodec<T>; aDest: TStream);
    function DecodeUnknownField<T>(aFieldNumber: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>): T;

    procedure EncodeRepeatedField<T>(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aCodec: TProtobufWireCodec<T>; aDest: TStream);
    procedure DecodeUnknownRepeatedField<T>(aFieldNumber: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TList<T>);

    procedure EncodePackedRepeatedField<T>(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aCodec: TProtobufPackableWireCodec<T>; aDest: TStream);

  public
    // Creates a new message instance.
    // Default initializes all fields according to the Protobuf specification,
    // see: https://developers.google.com/protocol-buffers/docs/proto3#default.
    constructor Create;

    // Destroys this message instance.
    // Frees all embedded messages contained inside this message.
    destructor Destroy; override;

    // Sets all field values to their Protobuf defaults. Embedded messages are set to nil.
    // See: https://developers.google.com/protocol-buffers/docs/proto3#default
    procedure Clear; virtual;

    // Encodes this message into a binary format and adds the resulting bytes to a stream.
    // params:
    //   aDest: Stream to append binary data to.
    procedure Encode(aDest: TStream);

    // Reads a binary stream to the end and finds all Protobuf fields.
    // The fields of this object will be populated where possible.
    // Fields that are not present in the data stream are default initialized.
    // params:
    //   aSource: Stream to read binary data from.
    procedure Decode(aSource: TStream);
  end;

implementation

procedure TProtobufMessage.EncodeField<T>(aFieldNumber: TProtobufFieldNumber; aValue: T; aCodec: TProtobufWireCodec<T>; aDest: TStream);
begin
  aCodec.EncodeField(aFieldNumber, aValue, aDest);
end;

function TProtobufMessage.DecodeUnknownField<T>(aFieldNumber: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>): T;
begin
  result := aCodec.DecodeField(FUnparsedFields[aFieldNumber]);
  FUnparsedFields.Remove(aFieldNumber);
end;

procedure TProtobufMessage.EncodeRepeatedField<T>(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aCodec: TProtobufWireCodec<T>; aDest: TStream);
begin
  aCodec.EncodeRepeatedField(aFieldNumber, aValues, aDest);
end;

procedure TProtobufMessage.DecodeUnknownRepeatedField<T>(aFieldNumber: TProtobufFieldNumber; aCodec: TProtobufWireCodec<T>; aDest: TList<T>);
begin
  aCodec.DecodeRepeatedField(FUnparsedFields[aFieldNumber], aDest);
  FUnparsedFields.Remove(aFieldNumber);
end;

procedure TProtobufMessage.EncodePackedRepeatedField<T>(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aCodec: TProtobufPackableWireCodec<T>; aDest: TStream);
begin
  aCodec.EncodePackedRepeatedField(aFieldNumber, aValues, aDest);
end;

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

end.
