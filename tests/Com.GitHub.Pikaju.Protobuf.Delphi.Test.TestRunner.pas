program TestRunner;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uVarint;

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

  WriteLn('--- All tests succeeded ---');
end.
