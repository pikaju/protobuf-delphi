/// <summary>
/// Runtime library support for the protobuf type <c>bytes</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufBytes;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufDelimitedWireCodec<TBytes>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDelimitedWireCodec,
  // TBytes for TProtobufDelimitedWireCodec<TBytes> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.SysUtils;
{$ELSE}
  SysUtils;
{$ENDIF}


type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>bytes</c>.
  /// </summary>
  TProtobufBytesWireCodec = class(TProtobufDelimitedWireCodec<TBytes>)
    // TProtobufDelimitedWireCodec<TBytes> implementation

    public
      function FromBytes(aValue: TBytes): TBytes; override;
      function ToBytes(aValue: TBytes): TBytes; override;

    // TProtobufWireCodec<TBytes> implementation
    
    public
      function GetDefault: TBytes; override;
      function IsDefault(aValue: TBytes): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufDelimitedWireCodec<TBytes> implementation

function TProtobufBytesWireCodec.FromBytes(aValue: TBytes): TBytes;
begin
  result := aValue;
end;

function TProtobufBytesWireCodec.ToBytes(aValue: TBytes): TBytes;
begin
  result := aValue;
end;

// TProtobufWireCodec<TBytes> implementation

function TProtobufBytesWireCodec.GetDefault: TBytes;
begin
  result := PROTOBUF_DEFAULT_VALUE_BYTES;
end;

function TProtobufBytesWireCodec.IsDefault(aValue: TBytes): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
