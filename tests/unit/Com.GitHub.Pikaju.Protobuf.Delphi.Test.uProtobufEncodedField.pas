unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufEncodedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag;

procedure TestEncodedField;

implementation

procedure TestEncoding;
var
  lStream: TMemoryStream;
  lEncodedField: TProtobufEncodedField;
begin
  lStream := TMemoryStream.Create;

  lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [$AC, $02]);
  lEncodedField.Encode(lStream);
  AssertStreamEquals(lStream, [5 shl 3 or 0, $AC, $02], 'Encoding a single varint field works');
  lStream.Clear;
  lEncodedField.Free;
  
  lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wt64Bit), [$AC, $02, $5, $FF, $AC, $02, $5, $FB]);
  lEncodedField.Encode(lStream);
  AssertStreamEquals(lStream, [5 shl 3 or 1, $AC, $02, $5, $FF, $AC, $02, $5, $FB], 'Encoding a single 64-bit field works');
  lStream.Clear;
  lEncodedField.Free;

  lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtLengthDelimited), [5, 3, 14, 15, 92, 65]);
  lEncodedField.Encode(lStream);
  AssertStreamEquals(lStream, [5 shl 3 or 2, 5, 3, 14, 15, 92, 65], 'Encoding a single length delimited field works');
  lStream.Clear;
  lEncodedField.Free;

  lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wt32Bit), [$AC, $02, $5, $FF]);
  lEncodedField.Encode(lStream);
  AssertStreamEquals(lStream, [5 shl 3 or 5, $AC, $02, $5, $FF], 'Encoding a single 32-bit field works');
  lStream.Clear;
  lEncodedField.Free;

  lStream.Free;
end;

procedure TestDecoding;
var
  lStream: TMemoryStream;
  lBytes: TBytes;
  lEncodedField: TProtobufEncodedField;
begin
  lStream := TMemoryStream.Create;

  lBytes := [5 shl 3 or 0, $AC, $02, 3, 14, 15, 92, 65];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  lEncodedField := TProtobufEncodedField.Create;
  lEncodedField.Decode(lStream);
  AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wtVarint), 'Decoding a varint field produces the correct tag');
  AssertBytesEqual(lEncodedField.Data, [$AC, $02], 'Decoding a varint field reads the correct data');
  lEncodedField.Free;
  lStream.Clear;

  lBytes := [5 shl 3 or 1, $AC, $02, $5, $FF, $AC, $02, $5, $FB, 3, 14, 15, 92, 65];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  lEncodedField := TProtobufEncodedField.Create;
  lEncodedField.Decode(lStream);
  AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wt64Bit), 'Decoding a 64-bit field produces the correct tag');
  AssertBytesEqual(lEncodedField.Data, [$AC, $02, $5, $FF, $AC, $02, $5, $FB], 'Decoding a 64-bit field reads the correct data');
  lEncodedField.Free;
  lStream.Clear;

  lBytes := [5 shl 3 or 2, 5, 3, 14, 15, 92, 65];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  lEncodedField := TProtobufEncodedField.Create;
  lEncodedField.Decode(lStream);
  AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wtLengthDelimited), 'Decoding a length delimited field produces the correct tag');
  AssertBytesEqual(lEncodedField.Data, [5, 3, 14, 15, 92, 65], 'Decoding a length delimited field reads the correct data');
  lEncodedField.Free;
  lStream.Clear;

  lBytes := [5 shl 3 or 5, $AC, $02, $5, $FF, 3, 14, 15, 92, 65];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  lEncodedField := TProtobufEncodedField.Create;
  lEncodedField.Decode(lStream);
  AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wt32Bit), 'Decoding a 32-bit field produces the correct tag');
  AssertBytesEqual(lEncodedField.Data, [$AC, $02, $5, $FF], 'Decoding a 32-bit field reads the correct data');
  lEncodedField.Free;
  lStream.Clear;

  lStream.Free;
end;

procedure TestEncodedField;
begin
  WriteLn('Running TestEncoding...');
  TestEncoding;
  WriteLn('Running TestDecoding...');
  TestDecoding;
end;

end.


