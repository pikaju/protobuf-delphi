unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessageCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Sysutils,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufMessageCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufTag,
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

  try
    lEmpty := TEmpty.Create;
    try
      lEmptyCodec := TProtobufMessageWireCodec<TEmpty>.Create; 
      lEmptyCodec.EncodeField(5, lEmpty, lStream);
      lEmptyCodec.Free;
      AssertStreamEquals(lStream, [5 shl 3 or 2, 0], 'Encoding an empty message works');
      lStream.Clear; 
    finally
      lEmpty.Free;
    end;
  finally
    lStream.Free;
  end;
end;

procedure TestMessageDecoding;
var
  aList: TList<TProtobufEncodedField>;
  lEmptyCodec: TProtobufMessageWireCodec<TEmpty>;
begin
  aList := TObjectList<TProtobufEncodedField>.Create;
  try
    aList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtLengthDelimited), [0]));
    lEmptyCodec := TProtobufMessageWireCodec<TEmpty>.Create; 
    lEmptyCodec.DecodeField(aList).Free;
    lEmptyCodec.Free;
  finally
    aList.Free;
  end;
end;

procedure TestMessageCodec;
begin
  WriteLn('Running TestMessageEncoding...');
  TestMessageEncoding;
  WriteLn('Running TestMessageDecoding...');
  TestMessageDecoding;
end;

end.


