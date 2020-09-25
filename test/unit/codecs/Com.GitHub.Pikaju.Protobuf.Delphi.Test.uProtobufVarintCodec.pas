unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBasicField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint32,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestVarintCodec;

implementation

procedure TestUint32Encoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;
  try
    gProtobufWireCodecUint32.EncodeField(5, 10, lStream);
    AssertStreamEquals(lStream, [5 shl 3 or 0, 10], 'Encoding a single uint32 works');
    lStream.Clear;
  finally
    lStream.Free;
  end;
end;

procedure TestUint32Decoding;
var
  lList: TList<TProtobufEncodedField>;
  lUint32: UInt32;
begin
  lList := TObjectList<TProtobufEncodedField>.Create;
  try
    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [$AC, $02]));
    lUint32 := gProtobufWireCodecUint32.DecodeField(lList);
    AssertTrue(lUint32 = 300, 'Decoding a single uint32 works');
  finally
    lList.Free;
  end;
end;

procedure TestRepeatedUint32Encoding;
var
  lStream: TMemoryStream;
  lRepeatedField: TProtobufRepeatedField<UInt32>;
begin
  lStream := TMemoryStream.Create;
  lRepeatedField := TProtobufRepeatedBasicField<UInt32>.Create;
  try
    lRepeatedField.Add(3);
    lRepeatedField.Add(300);
    lRepeatedField.Add(0);
    gProtobufWireCodecUint32.EncodeRepeatedField(5, lRepeatedField, lStream);
    AssertStreamEquals(lStream, [5 shl 3 or 2, 3, $AC, $02, 0], 'Encoding three uint32s works');
    lRepeatedField.Clear;
    lStream.Clear;
  finally
    lRepeatedField.Free;
    lStream.Free;
  end;
end;

procedure TestRepeatedUint32Decoding;
var
  lList: TList<TProtobufEncodedField>;
  lRepeatedField: TProtobufRepeatedField<UInt32>;
begin
  lList := TObjectList<TProtobufEncodedField>.Create;
  lRepeatedField := TProtobufRepeatedBasicField<UInt32>.Create;
  try
    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [3]));
    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [$AC, $02]));
    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [0]));
    gProtobufWireCodecUint32.DecodeRepeatedField(lList, lRepeatedField);
    AssertRepeatedFieldEquals<UInt32>(lRepeatedField, [3, 300, 0], 'Decoding a non-packed repeated uint32 works');
    lRepeatedField.Clear;
    lList.Clear;

    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtLengthDelimited), [3, 4, $AC, $02]));
    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtLengthDelimited), [1, 0]));
    gProtobufWireCodecUint32.DecodeRepeatedField(lList, lRepeatedField);
    AssertRepeatedFieldEquals<UInt32>(lRepeatedField, [4, 300, 0], 'Decoding a packed repeated uint32 works');
    lRepeatedField.Clear;
    lList.Clear;
  finally
    lRepeatedField.Free;
    lList.Free;
  end;
end;

procedure TestVarintCodec;
begin
  WriteLn('Running TestUint32Encoding...');
  TestUint32Encoding;
  WriteLn('Running TestUint32Decoding...');
  TestUint32Decoding;

  WriteLn('Running TestRepeatedUint32Encoding...');
  TestRepeatedUint32Encoding;
  WriteLn('Running TestRepeatedUint32Decoding...');
  TestRepeatedUint32Decoding;
end;

end.


