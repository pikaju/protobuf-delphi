unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint32,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestVarintCodec;

implementation

procedure TestInt32Encoding;
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

procedure TestInt32Decoding;
var
  aList: TList<TProtobufEncodedField>;
  lInt32: Int32;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  try
    aList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [$AC, $02]));
    lInt32 := gProtobufWireCodecUint32.DecodeField(aList);
    AssertTrue(lInt32 = 300, 'Decoding a single uint32 works');
  finally
    aList.Free;
  end;
end;

procedure TestVarintCodec;
begin
  WriteLn('Running TestInt32Encoding...');
  TestInt32Encoding;
  WriteLn('Running TestInt32Decoding...');
  TestInt32Decoding;
end;

end.


