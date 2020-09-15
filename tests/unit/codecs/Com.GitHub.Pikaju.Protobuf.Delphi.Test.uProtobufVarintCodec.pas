unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestVarintCodec;

implementation

procedure TestInt32Encoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;

  gProtobufWireCodecInt32.EncodeField(5, 10, lStream);
  AssertStreamEquals(lStream, [5 shl 3 or 0, 10], 'Encoding a single int32 works');
  lStream.Clear;

  lStream.Free;
end;

procedure TestInt32Decoding;
var
  aList: TList<TProtobufEncodedField>;
  lInt32: Int32;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;

  aList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [$AC, $02]));
  lInt32 := gProtobufWireCodecInt32.DecodeField(aList);
  AssertTrue(lInt32 = 300, 'Decoding a single int32 works');

  aList.Free;
end;

procedure TestVarintCodec;
begin
  WriteLn('Running TestInt32Encoding...');
  TestInt32Encoding;
  WriteLn('Running TestInt32Decoding...');
  TestInt32Decoding;
end;

end.


