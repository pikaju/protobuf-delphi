program TestRunner;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uVarint,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uStringCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uVarintCodec;

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

  WriteLn('Unit uStringCodec:');
  TestStringCodec;
  WriteLn;

  WriteLn('Unit uVarintCodec:');
  TestVarintCodec;
  WriteLn;

  WriteLn('--- All tests succeeded ---');
end.
