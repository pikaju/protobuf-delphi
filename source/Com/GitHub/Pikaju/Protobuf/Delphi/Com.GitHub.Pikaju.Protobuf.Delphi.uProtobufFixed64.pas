/// <summary>
/// Runtime library support for the protobuf type <c>fixed64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixed64;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufFixedWidthWireCodec<UInt64>
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
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>fixed64</c>.
  /// </summary>
  TProtobufFixed64WireCodec = class(TProtobufFixedWidthWireCodec<UInt64>)
    // TProtobufFixedWidthWireCodec<UInt64> implementation

    public
      function GetWireType: TProtobufWireType; override;
      function DecodeValue(aSource: TStream): UInt64; override;
      procedure EncodeValue(aValue: UInt64; aDest: TStream); override;

    // TProtobufWireCodec<UInt64> implementation
    
    public
      function GetDefault: UInt64; override;
      function IsDefault(aValue: UInt64): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufFixedWidthWireCodec<UInt64> implementation

function TProtobufFixed64WireCodec.GetWireType: TProtobufWireType;
begin
  result := wt64Bit;
end;

function TProtobufFixed64WireCodec.DecodeValue(aSource: TStream): UInt64;
begin
  aSource.Read(result, SizeOf(result));
end;

procedure TProtobufFixed64WireCodec.EncodeValue(aValue: UInt64; aDest: TStream);
begin
  aDest.Write(aValue, SizeOf(aValue));
end;

// TProtobufWireCodec<UInt64> implementation

function TProtobufFixed64WireCodec.GetDefault: UInt64;
begin
  result := PROTOBUF_DEFAULT_VALUE_FIXED64;
end;

function TProtobufFixed64WireCodec.IsDefault(aValue: UInt64): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
