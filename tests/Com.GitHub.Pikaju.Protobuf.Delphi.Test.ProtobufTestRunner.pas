program TestRunner;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufVarint,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessageCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufStringCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufVarintCodec;

begin
  WriteLn;
  WriteLn('--- Beginning unit tests ---');
  WriteLn;

  WriteLn('Unit uMessage:');
  TestMessage;
  WriteLn;

  WriteLn('Unit uTag:');
  TestTag;
  WriteLn;

  WriteLn('Unit uVarint:');
  TestVarint;
  WriteLn;
  
  WriteLn('--- Testing codecs ---');
  WriteLn;

  WriteLn('Unit uMessageCodec:');
  TestMessageCodec;
  WriteLn;

  WriteLn('Unit uStringCodec:');
  TestStringCodec;
  WriteLn;

  WriteLn('Unit uVarintCodec:');
  TestVarintCodec;
  WriteLn;

  WriteLn('--- All tests succeeded ---');
end.
