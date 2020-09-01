program TestRunner;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses uProtobufMessageTest;

begin
  WriteLn;
  WriteLn('--- Beginning unit tests ---');
  WriteLn;
  TestProtobufMessage;

  WriteLn;
  WriteLn('--- All tests succeeded ---');
end.