unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes;

// Encodes an unsigned integer according to the Protobuf Base 128 Varint specification.
// See: https://developers.google.com/protocol-buffers/docs/encoding#varints.
// Appends the resulting (variable length of) bytes to a given binary stream.
// params:
//   aVarint: Integer value to be encoded using the Varint format.
//   aDest: Stream to which binary data is appended.
procedure EncodeVarint(aVarint: UInt64; aDest: TStream);

// Decodes an unsigned integer according to the Protobuf Base 128 Varint specification.
// See: https://developers.google.com/protocol-buffers/docs/encoding#varints.
// params:
//   aSource: Stream from which the binary data should be read.
// return:
//   The decoded varint in its language specific integer representation.
function DecodeVarint(aSource: TStream) : UInt64;

implementation

procedure EncodeVarint(aVarint: UInt64; aDest: TStream);
var
  lByte: Byte;
begin
  repeat
    // Read the smallest 7 bit from the Varint.
    lByte := aVarint and $7F;
    aVarint := aVarint shr 7;
    // Set the most significant bit of the byte only if we are done after this iteration.
    if (aVarint <> 0) then
      lByte := lByte or $80;
    // Write the constructed byte to the stream.
    aDest.WriteBuffer(lByte, 1);
  until (aVarint = 0);
end;

function DecodeVarint(aSource: TStream) : UInt64;
var
  lByte: Byte;
  lCurrentOffset: Integer;
begin
  // The idea of this function is to read 7 bit batches worth of data into the correct
  // position of the result variable. We do this until the most significant bit is 0.
  result := 0;
  lCurrentOffset := 0;
  repeat
    aSource.ReadBuffer(lByte, 1);
    // Insert the 7 least significant bits of the byte into the desired location.
    result := result or (UInt64(lByte and $7f) shl lCurrentOffset);
    lCurrentOffset := lCurrentOffset + 7;
  until (lByte and $80 = 0);
end;

end.
