unit Protobuf.Test.uTestUtility;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses 
  Classes,
  Sysutils;

type
  ETestFailed = class(Exception);

procedure AssertTrue(aCondition: Boolean; aMessage: String);
procedure AssertStreamEquals(aStream: TStream; aContent: TBytes; aMessage: String);

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
  AssertTrue(aStream.Size = Length(aContent), aMessage);
  aStream.Seek(0, soBeginning);
  while (aStream.Position < aStream.Size) do
  begin
    aStream.ReadBuffer(lByte, 1);
    AssertTrue(aContent[aStream.Position - 1] = lByte, aMessage);
  end;
end;

end.
