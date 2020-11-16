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
  // TProtobufWireCodec to construct new elements with default values
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // TList for TProtobufRepeatedFieldValues<T> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

type
  /// <summary>
  /// Helper subclass of <see cref="T:TProtobufRepeatedFieldValues"/> for type parameters that are neither object types nor enumerated types.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  TProtobufRepeatedPrimitiveFieldValues<T> = class abstract(TProtobufRepeatedFieldValues<T>)
    private
      /// <summary>
      /// Backing storage for <see cref="GetStorage"/> using primitive values.
      /// </summary>
      FStorage: TList<T>;

    // Abstract members

    protected
      /// <summary>
      /// Getter for <see cref="WireCodec"/>.
      /// </summary>
      /// <returns>Field codec for the protobuf type</returns>
      function GetWireCodec: TProtobufWireCodec<T>; virtual; abstract;

      /// <summary>
      /// Field codec for the protobuf type.
      /// </summary>
      property WireCodec: TProtobufWireCodec<T> read GetWireCodec;

    // TProtobufRepeatedFieldValues<T> implementation

    public
      constructor Create; override;
      destructor Destroy; override;

    protected
      function GetStorage: TList<T>; override;
      function ConstructElement: T; override;
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

function TProtobufRepeatedPrimitiveFieldValues<T>.ConstructElement: T;
begin
  result := WireCodec.GetDefault;
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
