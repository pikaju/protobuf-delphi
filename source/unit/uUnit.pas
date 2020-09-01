unit uUnit;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

function Add(aA: Integer; aB: Integer): Integer;

implementation

function Add(aA: Integer; aB: Integer): Integer;
begin
  result := aA + aB;
end;

end.