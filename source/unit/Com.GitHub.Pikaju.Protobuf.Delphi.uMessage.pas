unit Com.GitHub.Pikaju.Protobuf.Delphi.uMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Com.GitHub.Pikaju.Protobuf.Delphi.uCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag;

type
  // Base class for Protobuf messages.
  // Can be used to encode to / decode from binary data according to the Protobuf
  // specification, see https://developers.google.com/protocol-buffers/docs/encoding.
  TProtobufMessage = class
  private
    // Collection of all fields in a Protobuf message that are yet to be decoded.
    // Fields are indexed by their field number, and stored in a list to support
    // non-packed repeated fields.
    type TEncodedFieldsMap = TDictionary<TFieldNumber, TObjectList<TEncodedField>>;

  private // private keyword required to prevent compilation issues.
    FUnparsedFields: TEncodedFieldsMap;
  
  protected
    procedure EncodeField<T>(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream; aCodec: TWireCodec<T>);
    function DecodeUnknownField<T>(aFieldNumber: TFieldNumber; aCodec: TWireCodec<T>): T;

    procedure EncodeRepeatedField<T>(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream; aCodec: TWireCodec<T>);
    procedure DecodeUnknownRepeatedField<T>(aFieldNumber: TFieldNumber; aDest: TList<T>; aCodec: TWireCodec<T>);

    procedure EncodePackedRepeatedField<T>(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream; aCodec: TPackableWireCodec<T>);

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

procedure TProtobufMessage.EncodeField<T>(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream; aCodec: TWireCodec<T>);
begin
  aCodec.EncodeField(aFieldNumber, aValue, aDest);
end;

function TProtobufMessage.DecodeUnknownField<T>(aFieldNumber: TFieldNumber; aCodec: TWireCodec<T>): T;
begin
  result := aCodec.DecodeField(FUnparsedFields[aFieldNumber]);
  FUnparsedFields.Remove(aFieldNumber);
end;

procedure TProtobufMessage.EncodeRepeatedField<T>(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream; aCodec: TWireCodec<T>);
begin
  aCodec.EncodeRepeatedField(aFieldNumber, aValues, aDest);
end;

procedure TProtobufMessage.DecodeUnknownRepeatedField<T>(aFieldNumber: TFieldNumber; aDest: TList<T>; aCodec: TWireCodec<T>);
begin
  aCodec.DecodeRepeatedField(FUnparsedFields[aFieldNumber], aDest);
  FUnparsedFields.Remove(aFieldNumber);
end;

procedure TProtobufMessage.EncodePackedRepeatedField<T>(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream; aCodec: TPackableWireCodec<T>);
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
end;

procedure TProtobufMessage.Encode(aDest: TStream);
begin
end;

procedure TProtobufMessage.Decode(aSource: TStream);
begin
end;

end.
