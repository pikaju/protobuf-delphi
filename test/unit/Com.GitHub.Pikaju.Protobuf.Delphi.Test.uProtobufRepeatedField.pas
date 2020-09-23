unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufRepeatedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBasicField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedMessageField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

type
  TEmpty = class(TProtobufMessage);

procedure TestRepeatedField;

implementation

procedure TestEmplaceAdd;
var
  lIntField: TProtobufRepeatedField<UInt32>;
  lMessageField: TProtobufRepeatedField<TEmpty>;
  lTestEmpty: TEmpty;
begin
  // For non-message fields, the value created by EmplaceAdd is not defined, so we do not need to test it.
  lIntField := TProtobufRepeatedBasicField<UInt32>.Create;
  AssertTrue(lIntField.Count = 0, 'Repeated fields start out empty.');
  lIntField.EmplaceAdd;
  AssertTrue(lIntField.Count = 1, 'Emplacing once results in a count of 1.');
  lIntField.EmplaceAdd;
  AssertTrue(lIntField.Count = 2, 'Emplacing twice results in a count of 2.');
  lIntField.EmplaceAdd;
  AssertTrue(lIntField.Count = 3, 'Emplacing thrice results in a count of 3.');
  lIntField[2] := 5;
  AssertTrue(lIntField[2] = 5, 'Values are assignable.');
  lIntField.Free;

  lMessageField := TProtobufRepeatedMessageField<TEmpty>.Create;
  AssertTrue(lMessageField.Count = 0, 'Repeated fields start out empty.');
  lMessageField.EmplaceAdd;
  AssertTrue(lMessageField.Count = 1, 'Emplacing once results in a count of 1.');
  lMessageField.EmplaceAdd;
  AssertTrue(lMessageField.Count = 2, 'Emplacing twice results in a count of 2.');
  lMessageField.EmplaceAdd;
  AssertTrue(lMessageField.Count = 3, 'Emplacing thrice results in a count of 3.');
  AssertTrue(Assigned(lMessageField[1]), 'Messages are assigned automatically by the TProtobufRepeatedMessageField, making it the owner.');
  lMessageField[2] := lTestEmpty;
  AssertTrue(lMessageField[2] = lTestEmpty, 'Values are assignable.');
  lMessageField.Free;
end;

procedure TestClear;
var
  lIntField: TProtobufRepeatedField<UInt32>;
  lMessageField: TProtobufRepeatedField<TEmpty>;
begin
  lIntField := TProtobufRepeatedBasicField<UInt32>.Create;
  AssertTrue(lIntField.Count = 0, 'Repeated fields start out empty.');
  lIntField.EmplaceAdd;
  lIntField.EmplaceAdd;
  lIntField.EmplaceAdd;
  AssertTrue(lIntField.Count = 3, 'Emplacing thrice results in a count of 3.');
  lIntField.Clear;
  AssertTrue(lIntField.Count = 0, 'Clearing results in a count of 0.');
  lIntField.Free;

  lMessageField := TProtobufRepeatedMessageField<TEmpty>.Create;
  AssertTrue(lMessageField.Count = 0, 'Repeated fields start out empty.');
  lMessageField.EmplaceAdd;
  lMessageField.EmplaceAdd;
  lMessageField.EmplaceAdd;
  AssertTrue(lMessageField.Count = 3, 'Emplacing thrice results in a count of 3.');
  lMessageField.Clear;
  AssertTrue(lMessageField.Count = 0, 'Clearing results in a count of 0.');
  lMessageField.Free;
end;

procedure TestRepeatedField;
begin
  WriteLn('Running TestEmplaceAdd...');
  TestEmplaceAdd;
  WriteLn('Running TestClear...');
  TestClear;
end;

end.


