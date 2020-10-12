unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufRepeatedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  // To check for default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedUint32,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedMessage,
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
  lIntField := TProtobufRepeatedUint32Field.Create;
  AssertTrue(lIntField.Count = 0, 'Repeated fields start out empty.');
  lIntField.EmplaceAdd;
  AssertTrue(lIntField.Count = 1, 'Emplacing once results in a count of 1.');
  lIntField.EmplaceAdd;
  AssertTrue(lIntField.Count = 2, 'Emplacing twice results in a count of 2.');
  lIntField.EmplaceAdd;
  AssertTrue(lIntField.Count = 3, 'Emplacing thrice results in a count of 3.');
  AssertTrue(lIntField[1] = PROTOBUF_DEFAULT_VALUE_UINT32, 'Non-messages are set to default values.');
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
  lTestEmpty := TEmpty.Create;
  lMessageField[2] := lTestEmpty;
  AssertTrue(lMessageField[2] = lTestEmpty, 'Values are assignable.');
  lMessageField.Free;
end;

procedure TestClear;
var
  lIntField: TProtobufRepeatedField<UInt32>;
  lMessageField: TProtobufRepeatedField<TEmpty>;
begin
  lIntField := TProtobufRepeatedUint32Field.Create;
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

procedure TestExtractAt;
var
  lIntField: TProtobufRepeatedField<UInt32>;
begin
  lIntField := TProtobufRepeatedUint32Field.Create;
  lIntField.Add(1);
  lIntField.Add(2);
  lIntField.Add(3);
  lIntField.Add(4);
  AssertRepeatedFieldEquals<UInt32>(lIntField, [1, 2, 3, 4], 'Repeated field is filled properly.');
  AssertTrue(lIntField.ExtractAt(3) = 4, 'The proper value at index 3 is extracted from repeated field.');
  AssertRepeatedFieldEquals<UInt32>(lIntField, [1, 2, 3], 'Extracted value at index 3 is gone after extraction.');
  AssertTrue(lIntField.ExtractAt(0) = 1, 'The proper value at index 0 is extracted from repeated field.');
  AssertRepeatedFieldEquals<UInt32>(lIntField, [2, 3], 'Extracted value at index 0 is gone after extraction.');
end;

procedure TestRepeatedField;
begin
  WriteLn('Running TestEmplaceAdd...');
  TestEmplaceAdd;
  WriteLn('Running TestClear...');
  TestClear;
  WriteLn('Running TestExtractAt...');
  TestExtractAt;
end;

end.


