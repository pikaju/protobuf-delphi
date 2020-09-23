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
  aList: TList<TProtobufEncodedField>;
  lUint32: UInt32;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  try
    aList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtVarint), [$AC, $02]));
    lUint32 := gProtobufWireCodecUint32.DecodeField(aList);
    AssertTrue(lUint32 = 300, 'Decoding a single uint32 works');
  finally
    aList.Free;
  end;
end;

procedure TestVarintCodec;
begin
  WriteLn('Running TestUint32Encoding...');
  TestUint32Encoding;
  WriteLn('Running TestUint32Decoding...');
  TestUint32Decoding;
end;

end.


