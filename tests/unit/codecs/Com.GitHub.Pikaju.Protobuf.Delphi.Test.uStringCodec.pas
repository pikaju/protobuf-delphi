unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uStringCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uStringCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uTestUtility;

procedure TestStringCodec;

implementation

procedure TestStringEncoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;

  gWireCodecString.EncodeField(5, 'すし is delicious', lStream);
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
  aList: TList<TEncodedField>;
  lInt32: Int32;
begin
  aList := TObjectList<TEncodedField>.Create;
  aList.Add(TEncodedField.CreateWithData(
    TTag.Create(5, wtLengthDelimited),
    [19, $e3, $81, $99, $e3, $81, $97, $20, $69, $73, $20, $64, $65, $6c, $69, $63, $69, $6f, $75, $73]
  ));

  AssertTrue(gWireCodecString.DecodeField(aList) = 'すし is delicious', 'Decoding a single string works');

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


