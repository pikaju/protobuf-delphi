/// <summary>
/// Runtime library support for the protobuf type <c>float</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFloat;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufFixedWidthWireCodec<Single>
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
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>float</c>.
  /// </summary>
  TProtobufFloatWireCodec = class(TProtobufFixedWidthWireCodec<Single>)
    // TProtobufFixedWidthWireCodec<Single> implementation

    public
      function GetWireType: TProtobufWireType; override;
      function DecodeValue(aSource: TStream): Single; override;
      procedure EncodeValue(aValue: Single; aDest: TStream); override;

    // TProtobufWireCodec<Single> implementation
    
    public
      function GetDefault: Single; override;
      function IsDefault(aValue: Single): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufFixedWidthWireCodec<Single> implementation

function TProtobufFloatWireCodec.GetWireType: TProtobufWireType;
begin
  result := wt32Bit;
end;

function TProtobufFloatWireCodec.DecodeValue(aSource: TStream): Single;
begin
  aSource.Read(result, SizeOf(result));
end;

procedure TProtobufFloatWireCodec.EncodeValue(aValue: Single; aDest: TStream);
begin
  aDest.Write(aValue, SizeOf(aValue));
end;

// TProtobufWireCodec<Single> implementation

function TProtobufFloatWireCodec.GetDefault: Single;
begin
  result := PROTOBUF_DEFAULT_VALUE_FLOAT;
end;

function TProtobufFloatWireCodec.IsDefault(aValue: Single): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
