unit uProtobufMessageTest;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses Classes, uProtobufMessage;

type
  TEmpty = class(TMessage);

procedure TestProtobufMessage;
procedure TestEmptyMessage;

implementation

procedure TestProtobufMessage;
begin
  WriteLn('Running TestEmptyMessage...');
  TestEmptyMessage;
end;

procedure TestEmptyMessage;
var
  lEmpty: TEmpty;
  lStream: TStream;
begin
  lEmpty := TEmpty.Create;
  lStream := TMemoryStream.Create;

  lEmpty.Encode(lStream);
  Assert((lStream.Position = 0) and (lStream.Size = 0), 'Empty messages produce an empty stream');
  lEmpty.Decode(lStream);

  lStream.Free;
  lEmpty.Free;
end;

end.