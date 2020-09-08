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

  WriteLn('Unit Protobuf.uMessage:');
  TestMessage;
  WriteLn;

  WriteLn('Unit Protobuf.uTag:');
  TestTag;
  WriteLn;

  WriteLn('Unit Protobuf.uVarint:');
  TestVarint;
  WriteLn;
  
  WriteLn('--- Testing codecs ---');
  WriteLn;

  WriteLn('Unit Protobuf.uStringCodec:');
  TestStringCodec;
  WriteLn;

  WriteLn('Unit Protobuf.uVarintCodec:');
  TestVarintCodec;
  WriteLn;

  WriteLn('--- All tests succeeded ---');
end.
