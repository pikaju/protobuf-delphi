unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage;

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
  try
    lEmpty.Encode(lStream);
    AssertTrue((lStream.Position = 0) and (lStream.Size = 0), 'Empty messages produce an empty stream.');
    lEmpty.Decode(lStream);
  finally
    lStream.Free;
    lEmpty.Free;
  end;
end;

procedure TestMessage;
begin
  WriteLn('Running TestEmptyMessage...');
  TestEmptyMessage;
end;

end.
