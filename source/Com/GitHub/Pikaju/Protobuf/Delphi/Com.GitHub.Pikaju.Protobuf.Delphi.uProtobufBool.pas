/// <summary>
/// Runtime library support for the protobuf type <c>bool</c>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufBool;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement TProtobufVarintWireCodec<Boolean>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for the protobuf type <c>bool</c>.
  /// </summary>
  TProtobufBoolWireCodec = class(TProtobufVarintWireCodec<Boolean>)
    // TProtobufVarintWireCodec<Boolean> implementation

    public
      function FromUInt64(aValue: UInt64): Boolean; override;
      function ToUInt64(aValue: Boolean): UInt64; override;

    // TProtobufWireCodec<Boolean> implementation
    
    public
      function GetDefault: Boolean; override;
  end;

implementation

uses
  // For protobuf default values
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

// TProtobufVarintWireCodec<Boolean> implementation

function TProtobufBoolWireCodec.FromUInt64(aValue: UInt64): Boolean;
begin
  ValidateBounds(aValue, 1, False);
  result := Boolean(aValue);
end;

function TProtobufBoolWireCodec.ToUInt64(aValue: Boolean): UInt64;
begin
  result := UInt64(aValue);
end;

// TProtobufWireCodec<Boolean> implementation

function TProtobufBoolWireCodec.GetDefault: Boolean;
begin
  result := PROTOBUF_DEFAULT_VALUE_BOOL;
end;

end.
