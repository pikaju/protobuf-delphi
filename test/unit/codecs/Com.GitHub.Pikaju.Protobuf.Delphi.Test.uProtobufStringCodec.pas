unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufStringCodec;

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
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufString,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestStringCodec;

implementation

procedure TestStringEncoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;
  try
    gProtobufWireCodecString.EncodeField(5, 'すし is delicious', lStream);
    AssertStreamEquals(
      lStream,
      [5 shl 3 or 2, 19, $e3, $81, $99, $e3, $81, $97, $20, $69, $73, $20, $64, $65, $6c, $69, $63, $69, $6f, $75, $73],
      'Encoding a single string works'
    );
    lStream.Clear;
  finally
    lStream.Free;
  end;
end;

procedure TestStringDecoding;
var
  aList: TList<TProtobufEncodedField>;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  try
    aList.Add(TProtobufEncodedField.CreateWithData(
      TProtobufTag.WithData(5, wtLengthDelimited),
      [19, $e3, $81, $99, $e3, $81, $97, $20, $69, $73, $20, $64, $65, $6c, $69, $63, $69, $6f, $75, $73]
    ));

    AssertTrue(gProtobufWireCodecString.DecodeField(aList) = 'すし is delicious', 'Decoding a single string works');
  finally
    aList.Free;
  end;
end;

procedure TestRepeatedStringEncoding;
var
  lStream: TMemoryStream;
  lRepeatedField: TProtobufRepeatedField<UnicodeString>;
begin
  lStream := TMemoryStream.Create;
  lRepeatedField := TProtobufRepeatedBasicField<UnicodeString>.Create;
  try
    lRepeatedField.Add('was');
    lRepeatedField.Add('gehdn');
    lRepeatedField.Add('eig');
    gProtobufWireCodecString.EncodeRepeatedField(5, lRepeatedField, lStream);
    AssertStreamEquals(
      lStream,
      [
        5 shl 3 or 2, 3, $77, $61, $73, // was
        5 shl 3 or 2, 5, $67, $65, $68, $64, $6e, // gehdn
        5 shl 3 or 2, 3, $65, $69, $67 // eig
      ],
      'Encoding a three strings works'
    );
    lRepeatedField.Clear;
    lStream.Clear;
  finally
    lRepeatedField.Free;
    lStream.Free;
  end;
end;

procedure TestRepeatedStringDecoding;
var
  aList: TList<TProtobufEncodedField>;
  lRepeatedField: TProtobufRepeatedField<UnicodeString>;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  lRepeatedField := TProtobufRepeatedBasicField<UnicodeString>.Create;
  try
    aList.Add(TProtobufEncodedField.CreateWithData(
      TProtobufTag.WithData(5, wtLengthDelimited),
      [19, $e3, $81, $99, $e3, $81, $97, $20, $69, $73, $20, $64, $65, $6c, $69, $63, $69, $6f, $75, $73]
    ));
    gProtobufWireCodecString.DecodeRepeatedField(aList, lRepeatedField);
    AssertRepeatedFieldEquals<UnicodeString>(lRepeatedField, ['was', 'gehdn', 'eig'], 'Decoding a single string works');
    lRepeatedField.Clear;
  finally
    lRepeatedField.Free;
    aList.Free;
  end;
end;

procedure TestStringCodec;
begin
  WriteLn('Running TestStringEncoding...');
  TestStringEncoding;
  WriteLn('Running TestStringDecoding...');
  TestStringDecoding;

  WriteLn('Running TestRepeatedStringEncoding...');
  TestRepeatedStringEncoding;
  WriteLn('Running TestRepeatedStringDecoding...');
  TestRepeatedStringDecoding;
end;

end.


