/// <summary>
/// Support code for handling of primitive values in <see cref="N:Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues"/>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedPrimitiveFieldValues;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedFieldValues<T>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues,
  // TList for TProtobufRepeatedFieldValues<T> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

type
  /// <summary>
  /// Helper subclass of <see cref="TProtobufRepeatedFieldValues"/> for type parameters that are neither object types nor enumerated types.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  TProtobufRepeatedPrimitiveFieldValues<T> = class abstract(TProtobufRepeatedFieldValues<T>)
    private
      /// <summary>
      /// Backing storage for <see cref="GetStorage"/> using primitive values.
      /// </summary>
      FStorage: TList<T>;

    // TProtobufRepeatedFieldValues<T> implementation

    public
      constructor Create; override;
      destructor Destroy; override;

    protected
      function GetStorage: TList<T>; override;
      procedure AssignFieldValues(aSource: TProtobufRepeatedFieldValues<T>); override;

    end;

implementation

// TProtobufRepeatedFieldValues<T> implementation

constructor TProtobufRepeatedPrimitiveFieldValues<T>.Create;
begin
  FStorage := TList<T>.Create;
end;

destructor TProtobufRepeatedPrimitiveFieldValues<T>.Destroy;
begin
  FStorage.Free;
end;

function TProtobufRepeatedPrimitiveFieldValues<T>.GetStorage: TList<T>;
begin
  result := FStorage;
end;

procedure  TProtobufRepeatedPrimitiveFieldValues<T>.AssignFieldValues(aSource: TProtobufRepeatedFieldValues<T>);
var
  lSource: TProtobufRepeatedPrimitiveFieldValues<T>;
begin
  lSource := aSource as TProtobufRepeatedPrimitiveFieldValues<T>;
  FStorage.Clear;
  FStorage.InsertRange(0, lSource.FStorage);
end;

end.

