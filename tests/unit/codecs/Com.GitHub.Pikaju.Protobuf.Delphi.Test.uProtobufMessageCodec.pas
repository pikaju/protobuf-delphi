unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessageCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessageCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestMessageCodec;

implementation

procedure TestMessageEncoding;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;

  

  lStream.Free;
end;

procedure TestMessageDecoding;
var
  aList: TList<TProtobufEncodedField>;
  lInt32: Int32;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  

  aList.Free;
end;

procedure TestMessageCodec;
begin
  WriteLn('Running TestMessageEncoding...');
  TestMessageEncoding;
  WriteLn('Running TestMessageDecoding...');
  TestMessageDecoding;
end;

end.


