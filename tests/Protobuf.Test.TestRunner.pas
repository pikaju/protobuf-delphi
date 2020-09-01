program TestRunner;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses Protobuf.Test.uMessage, Protobuf.Test.uVarint;

begin
  WriteLn;
  WriteLn('--- Beginning unit tests ---');
  WriteLn;

  WriteLn('Unit Protobuf.uMessage:');
  TestMessage;
  WriteLn;

  WriteLn('Unit Protobuf.uVarint:');
  TestVarint;
  WriteLn;

  WriteLn('--- All tests succeeded ---');
end.
