unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uVarintCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uTestUtility,
  Com.GitHub.Pikaju.Protobuf.Delphi.uVarintCodec;

procedure TestVarintCodec;

implementation

procedure TestEncoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;

  lStream.Free;
end;

procedure TestDecoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;
  lStream.Free;
end;

procedure TestVarintCodec;
begin
  WriteLn('Running TestEncoding...');
  TestEncoding;
  WriteLn('Running TestDecoding...');
  TestDecoding;
end;

end.


