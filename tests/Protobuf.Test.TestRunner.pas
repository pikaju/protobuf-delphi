program TestRunner;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses Protobuf.Test.uMessage;

begin
  WriteLn;
  WriteLn('--- Beginning unit tests ---');
  WriteLn;
  TestProtobufMessage;

  WriteLn;
  WriteLn('--- All tests succeeded ---');
end.