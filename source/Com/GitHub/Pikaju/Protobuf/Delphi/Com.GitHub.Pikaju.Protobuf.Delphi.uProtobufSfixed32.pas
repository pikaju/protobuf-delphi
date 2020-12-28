/// <summary>
/// Runtime library support for the protobuf type <c>sfixed32</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSfixed32;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufFixedWidthWireCodec<Int32>
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
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>sfixed32</c>.
  /// </summary>
  TProtobufSfixed32WireCodec = class(TProtobufFixedWidthWireCodec<Int32>)
    // TProtobufFixedWidthWireCodec<Int32> implementation

    public
      function GetWireType: TProtobufWireType; override;
      function DecodeValue(aSource: TStream): Int32; override;
      procedure EncodeValue(aValue: Int32; aDest: TStream); override;

    // TProtobufWireCodec<Int32> implementation
    
    public
      function GetDefault: Int32; override;
      function IsDefault(aValue: Int32): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufFixedWidthWireCodec<Int32> implementation

function TProtobufSfixed32WireCodec.GetWireType: TProtobufWireType;
begin
  result := wt32Bit;
end;

function TProtobufSfixed32WireCodec.DecodeValue(aSource: TStream): Int32;
begin
  aSource.Read(result, SizeOf(result));
end;

procedure TProtobufSfixed32WireCodec.EncodeValue(aValue: Int32; aDest: TStream);
begin
  aDest.Write(aValue, SizeOf(aValue));
end;

// TProtobufWireCodec<Int32> implementation

function TProtobufSfixed32WireCodec.GetDefault: Int32;
begin
  result := PROTOBUF_DEFAULT_VALUE_SFIXED32;
end;

function TProtobufSfixed32WireCodec.IsDefault(aValue: Int32): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
