/// <summary>
/// Runtime library support for the protobuf type <c>string</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufString;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufDelimitedWireCodec<UnicodeString>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDelimitedWireCodec,
  // TBytes for TProtobufDelimitedWireCodec<UnicodeString> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.SysUtils;
{$ELSE}
  SysUtils;
{$ENDIF}


type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>string</c>.
  /// </summary>
  TProtobufStringWireCodec = class(TProtobufDelimitedWireCodec<UnicodeString>)
    // TProtobufDelimitedWireCodec<UnicodeString> implementation

    public
      function FromBytes(aValue: TBytes): UnicodeString; override;
      function ToBytes(aValue: UnicodeString): TBytes; override;

    // TProtobufWireCodec<UnicodeString> implementation
    
    public
      function GetDefault: UnicodeString; override;
      function IsDefault(aValue: UnicodeString): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufDelimitedWireCodec<UnicodeString> implementation

function TProtobufStringWireCodec.FromBytes(aValue: TBytes): UnicodeString;
begin
  result := TEncoding.UTF8.GetString(aValue);
end;

function TProtobufStringWireCodec.ToBytes(aValue: UnicodeString): TBytes;
begin
  result := TEncoding.UTF8.GetBytes(aValue);
end;

// TProtobufWireCodec<UnicodeString> implementation

function TProtobufStringWireCodec.GetDefault: UnicodeString;
begin
  result := PROTOBUF_DEFAULT_VALUE_STRING;
end;

function TProtobufStringWireCodec.IsDefault(aValue: UnicodeString): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
