unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufEncodedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestEncodedField;

implementation

procedure TestEncoding;
var
  lStream: TMemoryStream;
  lEncodedField: TProtobufEncodedField;
begin
  lStream := TMemoryStream.Create;
  try
    lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [$AC, $02]);
    try
      lEncodedField.Encode(lStream);
      AssertStreamEquals(lStream, [5 shl 3 or 0, $AC, $02], 'Encoding a single varint field works');
      lStream.Clear;
    finally
      lEncodedField.Free;
    end;
    
    lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wt64Bit), [$AC, $02, $5, $FF, $AC, $02, $5, $FB]);
    try
      lEncodedField.Encode(lStream);
      AssertStreamEquals(lStream, [5 shl 3 or 1, $AC, $02, $5, $FF, $AC, $02, $5, $FB], 'Encoding a single 64-bit field works');
      lStream.Clear;
    finally
      lEncodedField.Free;
    end;

    lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtLengthDelimited), [5, 3, 14, 15, 92, 65]);
    try
      lEncodedField.Encode(lStream);
      AssertStreamEquals(lStream, [5 shl 3 or 2, 5, 3, 14, 15, 92, 65], 'Encoding a single length delimited field works');
      lStream.Clear;
    finally
      lEncodedField.Free;
    end;

    lEncodedField := TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wt32Bit), [$AC, $02, $5, $FF]);
    try
      lEncodedField.Encode(lStream);
      AssertStreamEquals(lStream, [5 shl 3 or 5, $AC, $02, $5, $FF], 'Encoding a single 32-bit field works');
      lStream.Clear;
    finally
      lEncodedField.Free;
    end;
  finally
    lStream.Free;
  end;
end;

procedure TestDecoding;
var
  lStream: TMemoryStream;
  lBytes: TBytes;
  lEncodedField: TProtobufEncodedField;
begin
  lStream := TMemoryStream.Create;
  try
    lBytes := [5 shl 3 or 0, $AC, $02, 3, 14, 15, 92, 65];
    lStream.WriteBuffer(lBytes[0], Length(lBytes));
    lStream.Seek(0, soBeginning);
    lEncodedField := TProtobufEncodedField.Create;
    try
      lEncodedField.Decode(lStream);
      AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wtVarint), 'Decoding a varint field produces the correct tag');
      AssertBytesEqual(lEncodedField.Data, [$AC, $02], 'Decoding a varint field reads the correct data');
    finally
      lEncodedField.Free;
    end;
    lStream.Clear;

    lBytes := [5 shl 3 or 1, $AC, $02, $5, $FF, $AC, $02, $5, $FB, 3, 14, 15, 92, 65];
    lStream.WriteBuffer(lBytes[0], Length(lBytes));
    lStream.Seek(0, soBeginning);
    lEncodedField := TProtobufEncodedField.Create;
    try
      lEncodedField.Decode(lStream);
      AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wt64Bit), 'Decoding a 64-bit field produces the correct tag');
      AssertBytesEqual(lEncodedField.Data, [$AC, $02, $5, $FF, $AC, $02, $5, $FB], 'Decoding a 64-bit field reads the correct data');
    finally
      lEncodedField.Free;
    end;
    lStream.Clear;

    lBytes := [5 shl 3 or 2, 5, 3, 14, 15, 92, 65];
    lStream.WriteBuffer(lBytes[0], Length(lBytes));
    lStream.Seek(0, soBeginning);
    lEncodedField := TProtobufEncodedField.Create;
    try
      lEncodedField.Decode(lStream);
      AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wtLengthDelimited), 'Decoding a length delimited field produces the correct tag');
      AssertBytesEqual(lEncodedField.Data, [5, 3, 14, 15, 92, 65], 'Decoding a length delimited field reads the correct data');
    finally
      lEncodedField.Free;
    end;
    lStream.Clear;

    lBytes := [5 shl 3 or 5, $AC, $02, $5, $FF, 3, 14, 15, 92, 65];
    lStream.WriteBuffer(lBytes[0], Length(lBytes));
    lStream.Seek(0, soBeginning);
    lEncodedField := TProtobufEncodedField.Create;
    try
      lEncodedField.Decode(lStream);
      AssertTrue((lEncodedField.Tag.FieldNumber = 5) and (lEncodedField.Tag.WireType = wt32Bit), 'Decoding a 32-bit field produces the correct tag');
      AssertBytesEqual(lEncodedField.Data, [$AC, $02, $5, $FF], 'Decoding a 32-bit field reads the correct data');
    finally
      lEncodedField.Free;
    end;
    lStream.Clear;
  finally
    lStream.Free;
  end;
end;

procedure TestEncodedField;
begin
  WriteLn('Running TestEncoding...');
  TestEncoding;
  WriteLn('Running TestDecoding...');
  TestDecoding;
end;

end.


