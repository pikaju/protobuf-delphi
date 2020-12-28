/// <summary>
/// Runtime library support for the protobuf type <c>sfixed64</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSfixed64;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufFixedWidthWireCodec<Int64>
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
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>sfixed64</c>.
  /// </summary>
  TProtobufSfixed64WireCodec = class(TProtobufFixedWidthWireCodec<Int64>)
    // TProtobufFixedWidthWireCodec<Int64> implementation

    public
      function GetWireType: TProtobufWireType; override;
      function DecodeValue(aSource: TStream): Int64; override;
      procedure EncodeValue(aValue: Int64; aDest: TStream); override;

    // TProtobufWireCodec<Int64> implementation
    
    public
      function GetDefault: Int64; override;
      function IsDefault(aValue: Int64): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufFixedWidthWireCodec<Int64> implementation

function TProtobufSfixed64WireCodec.GetWireType: TProtobufWireType;
begin
  result := wt64Bit;
end;

function TProtobufSfixed64WireCodec.DecodeValue(aSource: TStream): Int64;
begin
  aSource.Read(result, SizeOf(result));
end;

procedure TProtobufSfixed64WireCodec.EncodeValue(aValue: Int64; aDest: TStream);
begin
  aDest.Write(aValue, SizeOf(aValue));
end;

// TProtobufWireCodec<Int64> implementation

function TProtobufSfixed64WireCodec.GetDefault: Int64;
begin
  result := PROTOBUF_DEFAULT_VALUE_SFIXED64;
end;

function TProtobufSfixed64WireCodec.IsDefault(aValue: Int64): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
