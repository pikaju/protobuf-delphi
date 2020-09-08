unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDefaultValues;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

const
  // Protobuf default values. See: https://developers.google.com/protocol-buffers/docs/proto3#default.

  PROTOBUF_DEFAULT_VALUE_STRING: UnicodeString = '';
  PROTOBUF_DEFAULT_VALUE_BOOL = False;
  PROTOBUF_DEFAULT_VALUE_NUMERIC = 0;
  PROTOBUF_DEFAULT_VALUE_ENUM = 0;
  PROTOBUF_DEFAULT_VALUE_MESSAGE = nil;

implementation

end.
