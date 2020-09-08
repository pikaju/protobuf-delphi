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
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

type
  TEmpty = class(TProtobufMessage);

procedure TestMessageCodec;

implementation

procedure TestMessageEncoding;
var
  lStream: TMemoryStream;
  lEmpty: TEmpty;
  lEmptyCodec: TProtobufMessageWireCodec<TEmpty>;
begin
  lStream := TMemoryStream.Create;

  lEmpty := TEmpty.Create;
  lEmptyCodec := TProtobufMessageWireCodec<TEmpty>.Create; 
  lEmptyCodec.EncodeField(5, lEmpty, lStream);
  lEmptyCodec.Free;
  lEmpty.Free;
  AssertStreamEquals(lStream, [5 shl 3 or 2, 0], 'Encoding an empty message works');
  lStream.Clear; 

  lStream.Free;
end;

procedure TestMessageDecoding;
var
  aList: TList<TProtobufEncodedField>;
  lEmptyCodec: TProtobufMessageWireCodec<TEmpty>;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  
  aList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.Create(5, wtLengthDelimited), [0]));
  lEmptyCodec := TProtobufMessageWireCodec<TEmpty>.Create; 
  lEmptyCodec.DecodeField(aList).Free;
  lEmptyCodec.Free;

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


