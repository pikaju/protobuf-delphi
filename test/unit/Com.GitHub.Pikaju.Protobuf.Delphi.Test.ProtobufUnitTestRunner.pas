program ProtobufUnitTestRunner;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufVarint;

begin
  WriteLn;
  WriteLn('--- Beginning unit tests ---');
  WriteLn;

  WriteLn('Unit uProtobufEncodedField:');
  TestEncodedField;
  WriteLn;

  WriteLn('Unit uProtobufMessage:');
  TestMessage;
  WriteLn;

  WriteLn('Unit uProtobufRepeatedField:');
  TestRepeatedField;
  WriteLn;

  WriteLn('Unit uProtobufTag:');
  TestTag;
  WriteLn;

  WriteLn('Unit uProtobufVarint:');
  TestVarint;
  WriteLn;

  WriteLn('--- All tests succeeded ---');
end.
