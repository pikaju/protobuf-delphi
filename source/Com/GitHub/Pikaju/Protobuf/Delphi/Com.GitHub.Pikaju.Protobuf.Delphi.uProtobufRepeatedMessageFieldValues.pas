/// <summary>
/// Support code for handling of message type values in <see cref="N:Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues"/>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedMessageFieldValues;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFieldValues<T>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues,
  // TProtobufMessage to represent values
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  // IProtobufRepeatedFieldValues<T> for IProtobufRepeatedFieldValues<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufRepeatedFieldValues,
  // TObjectList for TProtobufRepeatedFieldValues<T> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

type
  /// <summary>
  /// Helper subclass of <see cref="T:TProtobufRepeatedFieldValues"/> for type parameters that represent protobuf message types.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  /// <remarks>
  /// The class name is not "TProtobufRepeatedMessageFieldValues" as one might expect, to work around an FPC bug. 
  /// </remarks>
  TProtobufRepeatedMessageFieldValuesBase<T: TProtobufMessage, constructor> = class(TProtobufRepeatedFieldValues<T>)
    private
      /// <summary>
      /// Backing storage for <see cref="GetStorage"/> using message values.
      /// The list manages ownership of its elements.
      /// </summary>
      FStorage: TObjectList<T>;

    // TProtobufRepeatedFieldValues<T> implementation

    public
      constructor Create; override;
      destructor Destroy; override;
      procedure SetValue(aIndex: Integer; aValue: T); override;
      function Add(const aValue: T): Integer; override;
      function ExtractAt(aIndex: Integer): T; override;

    protected
      function GetStorage: TList<T>; override;
      function ConstructElement: T; override;
      procedure AssignFieldValues(aSource: TProtobufRepeatedFieldValues<T>); override;

    // IProtobufRepeatedFieldValues<T> implementation

    public
      procedure MergeFrom(aSource: IProtobufRepeatedFieldValues<T>); override;
    end;

implementation

// TProtobufRepeatedFieldValues<T> implementation

constructor TProtobufRepeatedMessageFieldValuesBase<T>.Create;
begin
  FStorage := TObjectList<T>.Create;
end;

destructor TProtobufRepeatedMessageFieldValuesBase<T>.Destroy;
begin
  FStorage.Free;
end;

procedure TProtobufRepeatedMessageFieldValuesBase<T>.SetValue(aIndex: Integer; aValue: T);
begin
  aValue.SetOwner(Self);
  inherited SetValue(aIndex, aValue);
end;

function TProtobufRepeatedMessageFieldValuesBase<T>.Add(const aValue: T): Integer;
begin
  aValue.SetOwner(Self);
  inherited Add(aValue);
end;

function TProtobufRepeatedMessageFieldValuesBase<T>.ExtractAt(aIndex: Integer): T;
begin
  result := inherited;
  result.SetOwner(nil);
end;

function TProtobufRepeatedMessageFieldValuesBase<T>.GetStorage: TList<T>;
begin
  result := FStorage;
end;

function TProtobufRepeatedMessageFieldValuesBase<T>.ConstructElement: T;
begin
  result := T.Create;
  result.SetOwner(self);
end;

procedure  TProtobufRepeatedMessageFieldValuesBase<T>.AssignFieldValues(aSource: TProtobufRepeatedFieldValues<T>);
var
  lSource: TProtobufRepeatedMessageFieldValuesBase<T>;
  lValue: T;
begin
  lSource := aSource as TProtobufRepeatedMessageFieldValuesBase<T>;
  FStorage.Clear;
  for lValue in lSource.FStorage do lValue.SetOwner(self);
  FStorage.InsertRange(0, lSource.FStorage);
end;

// IProtobufRepeatedFieldValues<T> implementation

procedure TProtobufRepeatedMessageFieldValuesBase<T>.MergeFrom(aSource: IProtobufRepeatedFieldValues<T>);
var
  lSource: TProtobufRepeatedMessageFieldValuesBase<T>;
  lValue: T;
  lValueCopy: T;
begin
  lSource := aSource as TProtobufRepeatedMessageFieldValuesBase<T>;
  for lValue in lSource.FStorage do
  begin
    lValueCopy := EmplaceAdd;
    lValueCopy.Assign(lValue);
  end;
end;

end.
