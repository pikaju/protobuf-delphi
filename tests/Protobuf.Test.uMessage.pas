unit Protobuf.Test.uMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses Classes, Protobuf.Test.uTestUtility, Protobuf.uMessage;

type
  TEmpty = class(TProtobufMessage);

procedure TestMessage;

implementation

procedure TestEmptyMessage;
var
  lEmpty: TEmpty;
  lStream: TStream;
begin
  lEmpty := TEmpty.Create;
  lStream := TMemoryStream.Create;

  lEmpty.Encode(lStream);
  AssertTrue((lStream.Position = 0) and (lStream.Size = 0), 'Empty messages produce an empty stream.');
  lEmpty.Decode(lStream);

  lStream.Free;
  lEmpty.Free;
end;

procedure TestMessage;
begin
  WriteLn('Running TestEmptyMessage...');
  TestEmptyMessage;
end;

end.
