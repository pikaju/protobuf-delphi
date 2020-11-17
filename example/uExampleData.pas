/// <remarks>
/// This unit corresponds to the protobuf schema definition (.proto file) <c>example_data.proto</c>.
/// </remarks>
unit uExampleData;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes,
{$ELSE}
  Classes,
{$ENDIF}
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufRepeatedUint32,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufUint32,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufRepeatedFieldValues,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uProtobufMessage,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

type
  /// <remarks>
  /// This class corresponds to the protobuf message type <c>MessageY</c>.
  /// </remarks>
  TMessageY = class(TProtobufMessage)
    /// <summary>
    /// Creates an empty <see cref="TMessageY"/> that can be used as a protobuf message.
    /// Initially, all protobuf fields are absent, meaning that they are set to their default values.
    /// </summary>
    /// <remarks>
    /// Protobuf's interpretation of the absence of a field may be counterintuitive for Delphi developers.
    /// For a detailed explanation, see https://developers.google.com/protocol-buffers/docs/proto3#default.
    /// </remarks>
    public constructor Create; override;

    /// <summary>
    /// Destroys the instances and all objects and resources held by it, including the protobuf field values.
    /// </summary>
    /// <remarks>
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public destructor Destroy; override;

    /// <summary>
    /// Renders all protobuf fields absent by setting them to their default values.
    /// </summary>
    /// <remarks>
    /// The resulting instance state is equivalent to a newly constructed <see cref="TMessageY"/>.
    /// For more details, see the documentation of <see cref="Create"/>.
    /// This procedure may cause the destruction of transitively owned objects.
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public procedure Clear; override;

    /// <summary>
    /// Encodes the message using the protobuf binary wire format and writes it to a stream.
    /// </summary>
    /// <param name="aDest">The stream that the encoded message is written to</param>
    public procedure Encode(aDest: TStream); override;

    /// <summary>
    /// Fills the message's protobuf fields by decoding the message using the protobuf binary wire format from data that is read from a stream.
    /// </summary>
    /// <param name="aSource">The stream that the data is read from</param>
    /// <remarks>
    /// Protobuf fields that are not present in the read data are rendered absent by setting them to their default values.
    /// This may cause the destruction of transitively owned objects (this is also the case when a present fields overwrites a previous value)
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public procedure Decode(aSource: TStream); override;

    /// <summary>
    /// Copies the protobuf data from another object to this one.
    /// </summary>
    /// <param name="aSource">Object to copy from</param>
    /// <remarks>
    /// The other object must be a protobuf message of the same type.
    /// This performs a deep copy; hence, no ownership is shared.
    /// This procedure may cause the destruction of transitively owned objects in this message instance.
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public procedure Assign(aSource: TPersistent); override;

    /// <summary>
    /// Renders those protobuf fields absent that belong to <see cref="TMessageY"/> (i.e., are not managed by an ancestor class), by setting them to their default values.
    /// </summary>
    private procedure ClearOwnFields;

    /// <summary>
    /// Copies those protobuf fields that belong to <see cref="TMessageY"/> (i.e., are not managed by an ancestor class), during a call to <see cref="TInterfacedPersistent.Assign"/>.
    /// </summary>
    /// <param name="aSource">Source message to copy from</param>
    private procedure AssignOwnFields(aSource: TMessageY);
  end;

  /// <remarks>
  /// This class corresponds to the protobuf message type <c>MessageX</c>.
  /// </remarks>
  TMessageX = class(TProtobufMessage)
    /// <summary>
    /// Protobuf field number of the protobuf field <c>fieldX</c>.
    /// </summary>
    const PROTOBUF_FIELD_NUMBER_FIELD_X = 1;

    /// <summary>
    /// Protobuf field name of the protobuf field <c>fieldX</c>.
    /// </summary>
    const PROTOBUF_FIELD_NAME_FIELD_X = 'fieldX';

    /// <summary>
    /// Holds the decoded value of the protobuf field <c>fieldX</c>.
    /// </summary>
    private var FFieldX: UInt32;

    /// <summary>
    /// Getter for <see cref="FieldX"/>.
    /// </summary>
    /// <returns>The value of the protobuf field <c>fieldX</c></returns>
    /// <remarks>
    /// May be overridden. Overriders shall only add side-effects and must call the ancestor implementation.
    /// </remarks>
    protected function GetFieldX: UInt32; virtual;

    /// <summary>
    /// Setter for <see cref="FieldX"/>.
    /// </summary>
    /// <param name="aValue">The new value of the protobuf field <c>fieldX</c></param>
    /// <remarks>
    /// May be overridden. Overriders shall only add side-effects and must call the ancestor implementation.
    /// </remarks>
    protected procedure SetFieldX(aValue: UInt32); virtual;

    /// <remarks>
    /// This property corresponds to the protobuf field <c>fieldX</c>.
    /// </remarks>
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_CUSTOM_ATTRIBUTES}
    [ProtobufField(PROTOBUF_FIELD_NAME_FIELD_X, PROTOBUF_FIELD_NUMBER_FIELD_X)]
{$ENDIF}
    public property FieldX: UInt32 read GetFieldX write SetFieldX;

    /// <summary>
    /// Protobuf field number of the protobuf field <c>fieldY</c>.
    /// </summary>
    const PROTOBUF_FIELD_NUMBER_FIELD_Y = 2;

    /// <summary>
    /// Protobuf field name of the protobuf field <c>fieldY</c>.
    /// </summary>
    const PROTOBUF_FIELD_NAME_FIELD_Y = 'fieldY';

    /// <summary>
    /// Holds the decoded value of the protobuf field <c>fieldY</c>.
    /// </summary>
    private var FFieldY: TMessageY;

    /// <summary>
    /// Getter for <see cref="FieldY"/>.
    /// </summary>
    /// <returns>The value of the protobuf field <c>fieldY</c></returns>
    /// <remarks>
    /// May be overridden. Overriders shall only add side-effects and must call the ancestor implementation.
    /// </remarks>
    protected function GetFieldY: TMessageY; virtual;

    /// <summary>
    /// Setter for <see cref="FieldY"/>.
    /// </summary>
    /// <param name="aValue">The new value of the protobuf field <c>fieldY</c></param>
    /// <remarks>
    /// Ownership of the inserted message is transferred to the containing message.
    /// May be overridden. Overriders shall only add side-effects and must call the ancestor implementation.
    /// </remarks>
    protected procedure SetFieldY(aValue: TMessageY); virtual;

    /// <remarks>
    /// This property corresponds to the protobuf field <c>fieldY</c>.
    /// </remarks>
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_CUSTOM_ATTRIBUTES}
    [ProtobufField(PROTOBUF_FIELD_NAME_FIELD_Y, PROTOBUF_FIELD_NUMBER_FIELD_Y)]
{$ENDIF}
    public property FieldY: TMessageY read GetFieldY write SetFieldY;

    /// <summary>
    /// Protobuf field number of the protobuf field <c>fieldZ</c>.
    /// </summary>
    const PROTOBUF_FIELD_NUMBER_FIELD_Z = 3;

    /// <summary>
    /// Protobuf field name of the protobuf field <c>fieldZ</c>.
    /// </summary>
    const PROTOBUF_FIELD_NAME_FIELD_Z = 'fieldZ';

    /// <summary>
    /// Holds the decoded values of the protobuf field <c>fieldZ</c>.
    /// </summary>
    private var FFieldZ: TProtobufRepeatedUint32FieldValues;

    /// <summary>
    /// Getter for <see cref="FieldZ"/>.
    /// </summary>
    /// <returns>The values of the protobuf field <c>fieldZ</c></returns>
    /// <remarks>
    /// The returned collection is still owned by the message.
    /// Developers must ensure that a resulting shared ownership does not lead to unexpected behavior.
    /// May be overridden. Overriders shall only add side-effects and must call the ancestor implementation.
    /// </remarks>
    protected function GetFieldZ: IProtobufRepeatedFieldValues<UInt32>; virtual;

    /// <summary>
    /// Setter for <see cref="FieldZ"/>.
    /// </summary>
    /// <param name="aValues">The new values of the protobuf field <c>fieldZ</c></param>
    /// <remarks>
    /// Ownership of the inserted field value collection is transferred to the containing message.
    /// May be overridden. Overriders shall only add side-effects and must call the ancestor implementation.
    /// </remarks>
    protected procedure SetFieldZ(aValues: IProtobufRepeatedFieldValues<UInt32>); virtual;

    /// <remarks>
    /// This property corresponds to the protobuf field <c>fieldZ</c>.
    /// The collection is always owned by the message.
    /// Developers must ensure that a resulting shared ownership does not lead to unexpected behavior.
    /// </remarks>
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_CUSTOM_ATTRIBUTES}
    [ProtobufField(PROTOBUF_FIELD_NAME_FIELD_Z, PROTOBUF_FIELD_NUMBER_FIELD_Z)]
{$ENDIF}
    public property FieldZ: IProtobufRepeatedFieldValues<UInt32> read GetFieldZ write SetFieldZ;

    /// <summary>
    /// Creates an empty <see cref="TMessageX"/> that can be used as a protobuf message.
    /// Initially, all protobuf fields are absent, meaning that they are set to their default values.
    /// </summary>
    /// <remarks>
    /// Protobuf's interpretation of the absence of a field may be counterintuitive for Delphi developers.
    /// For a detailed explanation, see https://developers.google.com/protocol-buffers/docs/proto3#default.
    /// </remarks>
    public constructor Create; override;

    /// <summary>
    /// Destroys the instances and all objects and resources held by it, including the protobuf field values.
    /// </summary>
    /// <remarks>
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public destructor Destroy; override;

    /// <summary>
    /// Renders all protobuf fields absent by setting them to their default values.
    /// </summary>
    /// <remarks>
    /// The resulting instance state is equivalent to a newly constructed <see cref="TMessageX"/>.
    /// For more details, see the documentation of <see cref="Create"/>.
    /// This procedure may cause the destruction of transitively owned objects.
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public procedure Clear; override;

    /// <summary>
    /// Encodes the message using the protobuf binary wire format and writes it to a stream.
    /// </summary>
    /// <param name="aDest">The stream that the encoded message is written to</param>
    public procedure Encode(aDest: TStream); override;

    /// <summary>
    /// Fills the message's protobuf fields by decoding the message using the protobuf binary wire format from data that is read from a stream.
    /// </summary>
    /// <param name="aSource">The stream that the data is read from</param>
    /// <remarks>
    /// Protobuf fields that are not present in the read data are rendered absent by setting them to their default values.
    /// This may cause the destruction of transitively owned objects (this is also the case when a present fields overwrites a previous value)
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public procedure Decode(aSource: TStream); override;

    /// <summary>
    /// Copies the protobuf data from another object to this one.
    /// </summary>
    /// <param name="aSource">Object to copy from</param>
    /// <remarks>
    /// The other object must be a protobuf message of the same type.
    /// This performs a deep copy; hence, no ownership is shared.
    /// This procedure may cause the destruction of transitively owned objects in this message instance.
    /// Developers must ensure that no shared ownership of current field values or further nested embedded objects is held.
    /// </remarks>
    public procedure Assign(aSource: TPersistent); override;

    /// <summary>
    /// Renders those protobuf fields absent that belong to <see cref="TMessageX"/> (i.e., are not managed by an ancestor class), by setting them to their default values.
    /// </summary>
    private procedure ClearOwnFields;

    /// <summary>
    /// Copies those protobuf fields that belong to <see cref="TMessageX"/> (i.e., are not managed by an ancestor class), during a call to <see cref="TInterfacedPersistent.Assign"/>.
    /// </summary>
    /// <param name="aSource">Source message to copy from</param>
    private procedure AssignOwnFields(aSource: TMessageX);
  end;

implementation

constructor TMessageY.Create;
begin
  inherited;
  ClearOwnFields;
end;

destructor TMessageY.Destroy;
begin
  inherited;
end;

procedure TMessageY.Clear;
begin
  inherited;
  ClearOwnFields;
end;

procedure TMessageY.Encode(aDest: TStream);
begin
  inherited;
end;

procedure TMessageY.Decode(aSource: TStream);
begin
  inherited;
end;

procedure TMessageY.Assign(aSource: TPersistent);
var
  lSource: TMessageY;
begin
  lSource := aSource as TMessageY;
  inherited Assign(lSource);
  AssignOwnFields(lSource);
end;

procedure TMessageY.ClearOwnFields;
begin
end;

procedure TMessageY.AssignOwnFields(aSource: TMessageY);
begin
end;

constructor TMessageX.Create;
begin
  inherited;
  FFieldZ := TProtobufRepeatedUint32FieldValues.Create;
  ClearOwnFields;
end;

destructor TMessageX.Destroy;
begin
  FFieldY.Free;
  FFieldZ.Destroy;
  inherited;
end;

procedure TMessageX.Clear;
begin
  inherited;
  ClearOwnFields;
end;

procedure TMessageX.Encode(aDest: TStream);
begin
  inherited;
  gProtobufWireCodecUint32.EncodeSingularField(FFieldX, self, PROTOBUF_FIELD_NUMBER_FIELD_X, aDest);
  FFieldY.EncodeAsSingularField(self, PROTOBUF_FIELD_NUMBER_FIELD_Y, aDest);
  FFieldZ.EncodeAsRepeatedField(self, PROTOBUF_FIELD_NUMBER_FIELD_Z, aDest);
end;

procedure TMessageX.Decode(aSource: TStream);
begin
  inherited;
  FFieldX := gProtobufWireCodecUint32.DecodeUnknownField(self, PROTOBUF_FIELD_NUMBER_FIELD_X);
  FFieldY.Free;
  FFieldY := PROTOBUF_DEFAULT_VALUE_MESSAGE;
  if HasUnknownField(PROTOBUF_FIELD_NUMBER_FIELD_Y) then
  begin
    FFieldY := TMessageY.Create;
    FFieldY.DecodeAsUnknownSingularField(self, PROTOBUF_FIELD_NUMBER_FIELD_Y);
  end;
  FFieldZ.DecodeAsUnknownRepeatedField(self, PROTOBUF_FIELD_NUMBER_FIELD_Z);
end;

procedure TMessageX.Assign(aSource: TPersistent);
var
  lSource: TMessageX;
begin
  lSource := aSource as TMessageX;
  inherited Assign(lSource);
  AssignOwnFields(lSource);
end;

procedure TMessageX.ClearOwnFields;
begin
  FFieldX := PROTOBUF_DEFAULT_VALUE_UINT32;
  FFieldY.Free;
  FFieldY := PROTOBUF_DEFAULT_VALUE_MESSAGE;
  FFieldZ.Clear;
end;

procedure TMessageX.AssignOwnFields(aSource: TMessageX);
var
  lFieldY: TMessageY;
begin
  FieldX := aSource.FieldX;
  lFieldY := TMessageY.Create;
  lFieldY.Assign(aSource.FieldY);
  FieldY := lFieldY;
  (FieldZ as TInterfacedPersistent).Assign(aSource.FieldZ as TInterfacedPersistent);
end;

function TMessageX.GetFieldX: UInt32;
begin
  result := FFieldX;
end;

procedure TMessageX.SetFieldX(aValue: UInt32);
begin
  FFieldX := aValue;
end;

function TMessageX.GetFieldY: TMessageY;
begin
  result := FFieldY;
end;

procedure TMessageX.SetFieldY(aValue: TMessageY);
begin
  FFieldY.Free;
  FFieldY := aValue;
  FFieldY.SetOwner(self);
end;

function TMessageX.GetFieldZ: IProtobufRepeatedFieldValues<UInt32>;
begin
  result := FFieldZ;
end;

procedure TMessageX.SetFieldZ(aValues: IProtobufRepeatedFieldValues<UInt32>);
begin
  FFieldZ.Free;
  FFieldZ := aValues as TProtobufRepeatedUint32FieldValues;
  FFieldZ.SetOwner(self);
end;

end.
