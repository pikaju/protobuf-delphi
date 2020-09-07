unit Com.GitHub.Pikaju.Protobuf.Delphi.uTag;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Com.GitHub.Pikaju.Protobuf.Delphi.uVarint;

type
  // Representation of a Protobuf field number. See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
  TFieldNumber = UInt32;

  // Enum of all Protobuf wire types. See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
  TWireType = (
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
  TTag = record
  private
    FFieldNumber: TFieldNumber;
    FWireType: TWireType;
  public
    // Constructs a tag using a field number and a wire type.
    constructor Create(aFieldNumber: TFieldNumber; aWireType: TWireType);

    property FieldNumber: TFieldNumber read FFieldNumber;
    property WireType: TWireType read FWireType;
  end;

  // Encodes a Protobuf tag according to the specification.
  // This is done by combining the field number and wire type with bitwise operations,
  // and then writing the result as a varint.
  // See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
  // params:
  //   aTag: Tag to be encoded.
  //   aDest: Stream to which binary data is appended.
  procedure EncodeTag(aTag: TTag; aDest: TStream);

  // Decodes a Protobuf tag according to the specification from a binary stream.
  // This is done by reading a varint and then extracting the field number and wire
  // type using bitwise operations.
  // See: https://developers.google.com/protocol-buffers/docs/encoding#structure.
  // params:
  //   aSource: Stream from which the binary data should be read.
  // return:
  //   The decoded tag.
  function DecodeTag(aSource: TStream): TTag;

implementation

constructor TTag.Create(aFieldNumber: TFieldNumber; aWireType: TWireType);
begin
  FFieldNumber := aFieldNumber;
  FWireType := aWireType;
end;

procedure EncodeTag(aTag: TTag; aDest: TStream);
begin
  EncodeVarint((aTag.FieldNumber shl 3) or Ord(aTag.WireType), aDest);
end;

function DecodeTag(aSource: TStream): TTag;
var
  lVarint: UInt64;
begin
  lVarint := DecodeVarint(aSource);
  result := TTag.Create(lVarint shr 3, TWireType(lVarint and $7));
end;

end.

