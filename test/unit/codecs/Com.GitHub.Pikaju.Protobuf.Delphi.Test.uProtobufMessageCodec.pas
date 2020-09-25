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
  TMockMessage = class(TProtobufMessage)
  private
    FData: TBytes;
  public
    procedure Encode(aDest: TStream); override;
    procedure Decode(aSource: TStream); override;

    property Data: TBytes read FData write FData;
  end;

procedure TestMessageCodec;

implementation

procedure TMockMessage.Encode(aDest: TStream);
begin
  aDest.WriteBuffer(FData[0], Length(FData));
end;

procedure TMockMessage.Decode(aSource: TStream);
begin
  SetLength(FData, aSource.Size - aSource.Position);
  aSource.ReadBuffer(FData[0], Length(FData));
end;

procedure TestMessageEncoding;
var
  lStream: TMemoryStream;
  lMessage: TMockMessage;
  lCodec: TProtobufMessageWireCodec<TMockMessage>;
begin
  lStream := TMemoryStream.Create;
  lMessage := TMockMessage.Create;
  lCodec := TProtobufMessageWireCodec<TMockMessage>.Create; 
  try
      lMessage.Data := [];
      lCodec.EncodeField(5, lMessage, lStream);
      AssertStreamEquals(lStream, [5 shl 3 or 2, 0], 'Encoding an empty message works');
      lStream.Clear; 

      lMessage.Data := [3, 14, 15, 92, 65, 35, 89, 79];
      lCodec.EncodeField(5, lMessage, lStream);
      AssertStreamEquals(lStream, [5 shl 3 or 2, 8, 3, 14, 15, 92, 65, 35, 89, 79], 'Encoding a message with data works');
      lStream.Clear; 
  finally
    lCodec.Free;
    lMessage.Free;
    lStream.Free;
  end;
end;

procedure TestMessageDecoding;
var
  lList: TList<TProtobufEncodedField>;
  lMessage: TMockMessage;
  lCodec: TProtobufMessageWireCodec<TMockMessage>;
begin
  lList := TObjectList<TProtobufEncodedField>.Create;
  lMessage := TMockMessage.Create;
  lCodec := TProtobufMessageWireCodec<TMockMessage>.Create; 
  try
    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtLengthDelimited), [0]));
    lMessage := lCodec.DecodeField(lList);
    AssertBytesEqual(lMessage.Data, [], 'Decoding an empty message works');
    lMessage.Free;
    lList.Clear;

    lList.Add(TProtobufEncodedField.CreateWithData(TProtobufTag.WithData(5, wtLengthDelimited), [8, 3, 14, 15, 92, 65, 35, 89, 79]));
    lMessage := lCodec.DecodeField(lList);
    AssertBytesEqual(lMessage.Data, [3, 14, 15, 92, 65, 35, 89, 79], 'Decoding a message with data works');
    lMessage.Free;
    lList.Clear;
  finally
    lCodec.Free;
    lList.Free;
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


