unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses 
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

type
  ETestFailed = class(Exception);

procedure AssertTrue(aCondition: Boolean; aMessage: String);
procedure AssertStreamEquals(aStream: TStream; aContent: TBytes; aMessage: String);
procedure AssertBytesEqual(aLeft: TBytes; aRight: TBytes; aMessage: String);
procedure AssertRepeatedFieldEquals<T>(aField: TProtobufRepeatedField<T>; aValues: array of T; aMessage: String);

implementation

procedure AssertTrue(aCondition: Boolean; aMessage: String);
begin
  if (not aCondition) then
    raise ETestFailed.Create(aMessage);
end;

procedure AssertStreamEquals(aStream: TStream; aContent: TBytes; aMessage: String);
var
  lByte: Byte;
begin
  lByte := 0;
  AssertTrue(aStream.Size = Length(aContent), aMessage);
  aStream.Seek(0, soBeginning);
  while (aStream.Position < aStream.Size) do
  begin
    aStream.ReadBuffer(lByte, 1);
    AssertTrue(aContent[aStream.Position - 1] = lByte, aMessage);
  end;
end;

procedure AssertBytesEqual(aLeft: TBytes; aRight: TBytes; aMessage: String);
var
  lIndex: Longint;
begin
  AssertTrue(Length(aLeft) = Length(aRight), aMessage);
  for lIndex := 0 to Length(aLeft) - 1 do
    AssertTrue(aLeft[lIndex] = aRight[lIndex], aMessage);
end;

procedure AssertRepeatedFieldEquals<T>(aField: TProtobufRepeatedField<T>; aValues: array of T; aMessage: String);
var
  lIndex: Longint;
begin
  AssertTrue(aField.Count = Length(aValues), aMessage);
  for lIndex := 0 to aField.Count - 1 do
    AssertTrue(aField[lIndex] = aValues[lIndex], aMessage);
end;

end.
