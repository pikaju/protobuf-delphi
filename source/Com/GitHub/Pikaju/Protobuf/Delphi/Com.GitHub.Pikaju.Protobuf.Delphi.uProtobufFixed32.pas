/// <summary>
/// Runtime library support for the protobuf type <c>fixed32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixed32;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufFixedWidthWireCodec<UInt32>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
  // For wire type
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  // TStream for encoding of messages
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes;
{$ELSE}
  Classes;
{$ENDIF}

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>fixed32</c>.
  /// </summary>
  TProtobufFixed32WireCodec = class(TProtobufFixedWidthWireCodec<UInt32>)
    // TProtobufFixedWidthWireCodec<UInt32> implementation

    public
      function GetWireType: TProtobufWireType; override;
      function DecodeValue(aSource: TStream): UInt32; override;
      procedure EncodeValue(aValue: UInt32; aDest: TStream); override;

    // TProtobufWireCodec<UInt32> implementation
    
    public
      function GetDefault: UInt32; override;
      function IsDefault(aValue: UInt32): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufFixedWidthWireCodec<UInt32> implementation

function TProtobufFixed32WireCodec.GetWireType: TProtobufWireType;
begin
  result := wt32Bit;
end;

function TProtobufFixed32WireCodec.DecodeValue(aSource: TStream): UInt32;
begin
  aSource.Read(result, SizeOf(result));
end;

procedure TProtobufFixed32WireCodec.EncodeValue(aValue: UInt32; aDest: TStream);
begin
  aDest.Write(aValue, SizeOf(aValue));
end;

// TProtobufWireCodec<UInt32> implementation

function TProtobufFixed32WireCodec.GetDefault: UInt32;
begin
  result := PROTOBUF_DEFAULT_VALUE_FIXED32;
end;

function TProtobufFixed32WireCodec.IsDefault(aValue: UInt32): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
