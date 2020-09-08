unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uTag;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uTestUtility,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag;

procedure TestTag;

implementation

procedure TestEncoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;

  EncodeTag(TProtobufTag.Create(5, wtVarint), lStream);
  AssertStreamEquals(lStream, [$28], 'Encoding tag (5, wtVarint) produces $28.');
  lStream.Clear;

  EncodeTag(TProtobufTag.Create(1, wt64Bit), lStream);
  AssertStreamEquals(lStream, [$09], 'Encoding tag (1, wt64Bit) produces $09.');
  lStream.Clear;

  EncodeTag(TProtobufTag.Create($FF, wt32Bit), lStream);
  AssertStreamEquals(lStream, [$FD, $0F], 'Encoding tag ($FF, wt32Bit) produces $FD, $0F.');
  lStream.Clear;

  lStream.Free;
end;

procedure TestDecoding;
var
  lStream: TMemoryStream;
  lBytes: TBytes;
  lTag: TProtobufTag;
begin
  lStream := TMemoryStream.Create;

  lBytes := [$28];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  lTag := DecodeTag(lStream);
  AssertTrue((lTag.FieldNumber = 5) and (lTag.WireType = wtVarint), 'Decoding $28 produces tag (5, wtVarint).');
  lStream.Clear;

  lBytes := [$09];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  lTag := DecodeTag(lStream);
  AssertTrue((lTag.FieldNumber = 1) and (lTag.WireType = wt64Bit), 'Decoding $09 produces tag (1, wt64Bit).');
  lStream.Clear;

  lBytes := [$FD, $0F];
  lStream.WriteBuffer(lBytes[0], Length(lBytes));
  lStream.Seek(0, soBeginning);
  lTag := DecodeTag(lStream);
  AssertTrue((lTag.FieldNumber = $FF) and (lTag.WireType = wt32Bit), 'Decoding $FD, $0F produces tag ($FF, wt32Bit).');
  lStream.Clear;

  lStream.Free;
end;

procedure TestTag;
begin
  WriteLn('Running TestEncoding...');
  TestEncoding;
  WriteLn('Running TestDecoding...');
  TestDecoding;
end;

end.

