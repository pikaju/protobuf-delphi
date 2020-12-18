program ProtobufDelphiTests;

{$mode objfpc}{$H+}

uses
  Classes, consoletestrunner,
    Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufVarint;

type

  { TMyTestRunner }

  TMyTestRunner = class(TTestRunner)
  protected
  // override the protected methods of TTestRunner to customize its behavior
  end;

var
  Application: TMyTestRunner;

begin
  Application := TMyTestRunner.Create(nil);
  Application.Initialize;
  Application.Title:='ProtobufDelphiTests';
  Application.Run;
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
  Application.Free;
end.
