unit Protobuf.Test.uVarint;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses Classes, Sysutils, Protobuf.Test.uTestUtility, Protobuf.uVarint;

procedure TestVarint;

implementation

procedure TestEncoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;

  // Test 0.
  EncodeVarint(0, lStream);
  AssertStreamEquals(lStream, [0], 'Encoding 0 produces a single byte of value 0.');
  lStream.Clear;

  // Test 300 from example: https://developers.google.com/protocol-buffers/docs/encoding#varints.
  EncodeVarint(300, lStream);
  AssertStreamEquals(lStream, [$AC, $02], 'Encoding 300 produces binary 1010 1100 0000 0010.');
  lStream.Clear;

  // Test boundary from $7F to $80.
  EncodeVarint($7F, lStream);
  AssertStreamEquals(lStream, [$7F], 'Encoding $7F produces a single byte with value $7F.');
  lStream.Clear;
  EncodeVarint($80, lStream);
  AssertStreamEquals(lStream, [$80, $01], 'Encoding $80 produces $80, $01.');
  lStream.Clear;

  // Test biggest 64 bit Integer.
  EncodeVarint(UInt64($FFFFFFFFFFFFFFFF), lStream);
  AssertStreamEquals(lStream, [$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $01], 'Biggest 64-bit integer produces the correct 10 bytes.');
  lStream.Clear;

  lStream.Free;
end;

procedure TestDecoding;
var
  lStream: TMemoryStream;
  lBytes: TBytes;
begin
  lStream := TMemoryStream.Create;

  // Test 0.
  lBytes := [0];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  AssertTrue(DecodeVarint(lStream) = 0, 'Decoding a single 0 byte returns 0.');
  lStream.Clear;

  // Test 300 from example: https://developers.google.com/protocol-buffers/docs/encoding#varints.
  lBytes := [$AC, $02];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  AssertTrue(DecodeVarint(lStream) = 300, 'Decoding binary 1010 1100 0000 0010 return 300.');
  lStream.Clear;

  // Test biggest 64 bit Integer.
  lBytes := [$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $01];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  AssertTrue(DecodeVarint(lStream) = UInt64($FFFFFFFFFFFFFFFF), 'Decoding biggest 64-bit integer works.');
  lStream.Clear;

  // Test that only the desired bytes are read.
  lBytes := [$12, $34, $AC, $02, $56, $78, $9F];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(2, soBeginning);
  AssertTrue(DecodeVarint(lStream) = 300, 'Decoding only reads the desired amount of bytes.');
  AssertTrue(lStream.Position = 4, 'Decoding ends with the correct stream position');
  lStream.Clear;

  lStream.Free;
end;

procedure TestVarint;
begin
  WriteLn('Running TestEncoding...');
  TestEncoding;
  WriteLn('Running TestDecoding...');
  TestDecoding;
end;

end.
