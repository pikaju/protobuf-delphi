/// <summary>
/// Runtime library support for the protobuf type <c>double</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDouble;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufFixedWidthWireCodec<Double>
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
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>double</c>.
  /// </summary>
  TProtobufDoubleWireCodec = class(TProtobufFixedWidthWireCodec<Double>)
    // TProtobufFixedWidthWireCodec<Double> implementation

    public
      function GetWireType: TProtobufWireType; override;
      function DecodeValue(aSource: TStream): Double; override;
      procedure EncodeValue(aValue: Double; aDest: TStream); override;

    // TProtobufWireCodec<Double> implementation
    
    public
      function GetDefault: Double; override;
      function IsDefault(aValue: Double): Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufFixedWidthWireCodec<Double> implementation

function TProtobufDoubleWireCodec.GetWireType: TProtobufWireType;
begin
  result := wt64Bit;
end;

function TProtobufDoubleWireCodec.DecodeValue(aSource: TStream): Double;
begin
  aSource.Read(result, SizeOf(result));
end;

procedure TProtobufDoubleWireCodec.EncodeValue(aValue: Double; aDest: TStream);
begin
  aDest.Write(aValue, SizeOf(aValue));
end;

// TProtobufWireCodec<Double> implementation

function TProtobufDoubleWireCodec.GetDefault: Double;
begin
  result := PROTOBUF_DEFAULT_VALUE_DOUBLE;
end;

function TProtobufDoubleWireCodec.IsDefault(aValue: Double): Boolean;
begin
  result := aValue = GetDefault;
end;

end.
