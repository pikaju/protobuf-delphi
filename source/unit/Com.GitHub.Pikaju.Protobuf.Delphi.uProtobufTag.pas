unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint;

type
  // Enum of all Protobuf wire types. See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
  TProtobufWireType = (
    wtUnknown = -1,
    wtVarint = 0,
    wt64Bit = 1,
    wtLengthDelimited = 2,
    wtStartGroup = 3,
    wtEndGroup = 4,
    wt32Bit = 5
  );

  // Record type of a Protobuf tag.
  // Simply combines a field number and a wire type for convenience.
  // See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
  TProtobufTag = record
  private
    FFieldNumber: TProtobufFieldNumber;
    FWireType: TProtobufWireType;
  public
    // Constructs a tag using a field number and a wire type.
    class function WithData(aFieldNumber: TProtobufFieldNumber; aWireType: TProtobufWireType): TProtobufTag; static;

    // Encodes the Protobuf tag according to the specification.
    // This is done by combining the field number and wire type with bitwise operations,
    // and then writing the result as a varint.
    // See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
    // params:
    //   aDest: Stream to which binary data is appended.
    procedure Encode(aDest: TStream);

    // Decodes the Protobuf tag according to the specification from a binary stream.
    // This is done by reading a varint and then extracting the field number and wire
    // type using bitwise operations.
    // See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
    // params:
    //   aSource: Stream from which the binary data should be read.
    procedure Decode(aSource: TStream);

    property FieldNumber: TProtobufFieldNumber read FFieldNumber;
    property WireType: TProtobufWireType read FWireType;
  end;

implementation

class function TProtobufTag.WithData(aFieldNumber: TProtobufFieldNumber; aWireType: TProtobufWireType): TProtobufTag;
begin
  result.FFieldNumber := aFieldNumber;
  result.FWireType := aWireType;
end;

procedure TProtobufTag.Encode(aDest: TStream);
begin
  EncodeVarint((FieldNumber shl 3) or Ord(WireType), aDest);
end;

procedure TProtobufTag.Decode(aSource: TStream);
var
  lVarint: UInt64;
begin
  lVarint := DecodeVarint(aSource);
  FFieldNumber := lVarint shr 3;
  FWireType := TProtobufWireType(lVarint and $7);
end;

end.

