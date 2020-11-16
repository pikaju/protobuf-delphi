unit Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufMessage;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Sysutils,
  uExampleData,
  Com.GitHub.Pikaju.Protobuf.Delphi.Test.uProtobufTestUtility;

procedure TestMessage;

implementation

procedure TestEncoding;
var
  lStream: TStream;

  lMessageX: TMessageX;
begin
  lStream := TMemoryStream.Create;

  lMessageX := TMessageX.Create;
  lMessageX.FieldY := TMessageY.Create;
  try
    lMessageX.Encode(lStream);
    AssertStreamEquals(lStream, [2 shl 3 or 2, 0], 'Encoding a message with a message field works.');
  finally
    lMessageX.Free;

    lStream.Free;
  end;
end;

procedure TestDecoding;
var
  lStream: TMemoryStream;
  lBytes: TBytes;

  lMessageX: TMessageX;
begin
  lStream := TMemoryStream.Create;

  lMessageX := TMessageX.Create;
  try
    lBytes := [2 shl 3 or 2, 0];
    lStream.WriteBuffer(lBytes[0], Length(lBytes));
    lStream.Seek(0, soBeginning);
    lMessageX.Decode(lStream);
    AssertTrue(Assigned(lMessageX.FieldY), 'Decoding a message with a message field assigns the message.');
    lStream.Clear;

    lMessageX.Decode(lStream);
    AssertTrue(not Assigned(lMessageX.FieldY), 'Decoding a message from an empty stream unassigns message fields.');
    lStream.Clear;
  finally
    lMessageX.Free;

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
