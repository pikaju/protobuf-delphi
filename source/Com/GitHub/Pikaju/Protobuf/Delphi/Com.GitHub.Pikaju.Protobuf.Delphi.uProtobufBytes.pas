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

    // IProtobufWireCodec<TBytes> implementation
    
    public
      function GetDefault: TBytes; override;
  end;

implementation

// TProtobufDelimitedWireCodec<TBytes> implementation

function TProtobufBytesWireCodec.FromBytes(aValue: TBytes): TBytes;
begin
  result := aValue;
end;

function TProtobufBytesWireCodec.ToBytes(aValue: TBytes): TBytes;
begin
  result := aValue;
end;

// IProtobufWireCodec<TBytes> implementation

function TProtobufBytesWireCodec.GetDefault: TBytes;
begin
  SetLength(result, 0);
end;

end.
