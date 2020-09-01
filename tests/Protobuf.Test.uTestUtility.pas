unit Protobuf.Test.uTestUtility;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

type
  ETestFailed = class(Exception);

procedure AssertEquals<T>(aA: T; aB: T);
begin
  if (aA <> aB) then
    raise ETestFailed.Create('AssertEquals failed');
end;