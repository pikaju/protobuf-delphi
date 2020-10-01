unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uExampleMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage;

procedure TestMessage;

implementation

procedure TestEncoding;
var
  lStream: TStream;

  lMessageY: TMessageY;
begin
  lStream := TMemoryStream.Create;

  lMessageY := TMessageY.Create;
  lMessageY.FieldX := TMessageX.Create;
  try
    lMessageY.Encode(lStream);
    AssertStreamEquals(lStream, [1 shl 3 or 2, 0], 'Encoding a message with a message field works.');
  finally
    lMessageY.Free;

    lStream.Free;
  end;
end;

procedure TestDecoding;
var
  lStream: TMemoryStream;
  lBytes: TBytes;

  lMessageY: TMessageY;
begin
  lStream := TMemoryStream.Create;

  lMessageY := TMessageY.Create;
  try
    lBytes := [1 shl 3 or 2, 0];
    lStream.WriteBuffer(lBytes[0], Length(lBytes));
    lStream.Seek(0, soBeginning);
    lMessageY.Decode(lStream);
    AssertTrue(Assigned(lMessageY.FieldX), 'Decoding a message with a message field assigns the message.');
    lStream.Clear;

    lMessageY.Decode(lStream);
    AssertTrue(not Assigned(lMessageY.FieldX), 'Decoding a message from an empty stream unassigns message fields.');
    lStream.Clear;
  finally
    lMessageY.Free;

    lStream.Free;
  end;
end;

procedure TestMessage;
begin
  WriteLn('Running TestEncoding...');
  TestEncoding;
  WriteLn('Running TestDecoding...');
  TestDecoding;
end;

end.
