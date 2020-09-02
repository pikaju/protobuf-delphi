unit Protobuf.uMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses Classes, Generics.Collections, Protobuf.uEncodedField, Protobuf.uTag;

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
    FEncodedFields: TEncodedFieldsMap;

  public
    // Creates a new message instance.
    // Default initializes all fields according to the Protobuf specification,
    // see https://developers.google.com/protocol-buffers/docs/proto3#default.
    constructor Create;

    // Destroys this message instance.
    // Frees all embedded messages contained inside this message.
    destructor Destroy; override;

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

constructor TProtobufMessage.Create;
begin
  FEncodedFields := TEncodedFieldsMap.Create;
end;

destructor TProtobufMessage.Destroy;
begin
  FEncodedFields.Free;
end;

procedure TProtobufMessage.Encode(aDest: TStream);
begin
end;

procedure TProtobufMessage.Decode(aSource: TStream);
begin
end;

end.
