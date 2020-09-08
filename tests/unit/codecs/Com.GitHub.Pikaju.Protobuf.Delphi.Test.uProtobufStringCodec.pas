unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufStringCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufStringCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestStringCodec;

implementation

procedure TestStringEncoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;

  gProtobufWireCodecString.EncodeField(5, 'すし is delicious', lStream);
  AssertStreamEquals(
    lStream,
    [5 shl 3 or 2, 19, $e3, $81, $99, $e3, $81, $97, $20, $69, $73, $20, $64, $65, $6c, $69, $63, $69, $6f, $75, $73],
    'Encoding a single string works'
  );
  lStream.Clear;

  lStream.Free;
end;

procedure TestStringDecoding;
var
  aList: TList<TProtobufEncodedField>;
  lInt32: Int32;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  aList.Add(TProtobufEncodedField.CreateWithData(
    TProtobufTag.Create(5, wtLengthDelimited),
    [19, $e3, $81, $99, $e3, $81, $97, $20, $69, $73, $20, $64, $65, $6c, $69, $63, $69, $6f, $75, $73]
  ));

  AssertTrue(gProtobufWireCodecString.DecodeField(aList) = 'すし is delicious', 'Decoding a single string works');

  aList.Free;
end;

procedure TestStringCodec;
begin
  WriteLn('Running TestStringEncoding...');
  TestStringEncoding;
  WriteLn('Running TestStringDecoding...');
  TestStringDecoding;
end;

end.


