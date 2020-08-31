unit uUnitTest;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses uUnit;

procedure TestAdd();

implementation

procedure TestAdd();
begin
  WriteLn(Add(1, 2));
end;

end.