unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufRepeatedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

type
  TEmpty = class(TProtobufMessage);

procedure TestRepeatedField;

implementation

procedure TestEmplaceAdd;
var
  lIntField: TProtobufRepeatedField<UInt32>;
  lMessageField: TProtobufRepeatedField<TEmpty>;
begin
  // For non-message fields, the value created by EmplaceAdd is not defined, so we do not need to test it.
  lIntField := TProtobufRepeatedField<UInt32>.Create;
  AssertTrue(lIntField.Count = 0, 'Repeated fields start out empty.');
  lIntField.EmplaceAdd();
  AssertTrue(lIntField.Count = 1, 'Emplacing once results in a count of 1.');
  lIntField.EmplaceAdd();
  AssertTrue(lIntField.Count = 2, 'Emplacing twice results in a count of 2.');
  lIntField.EmplaceAdd();
  AssertTrue(lIntField.Count = 3, 'Emplacing thrice results in a count of 3.');
  lIntField.Free;

  lMessageField := TProtobufRepeatedField<TEmpty>.Create;
  lMessageField.EmplaceAdd();
  AssertTrue(Assigned(lMessageField[0]), 'Messages are assigned automatically by the TProtobufRepeatedField, making it the owner.');
  lMessageField.Free;
end;

procedure TestRepeatedField;
begin
  WriteLn('Running TestEmplaceAdd...');
  TestEmplaceAdd;
end;

end.


