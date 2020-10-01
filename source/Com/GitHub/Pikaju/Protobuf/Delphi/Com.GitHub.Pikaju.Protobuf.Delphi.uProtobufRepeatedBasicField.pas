/// <summary>
/// Runtime library implementation of support code for handling protobuf repeated fields 
/// in generated Delphi code.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBasicField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // For TEnumerable implementation
  Generics.Collections,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

type
  /// <summary>
  /// TODO
  /// </summary>
  /// <typeparam name="T">TODO</typeparam>
  TProtobufRepeatedBasicField<T> = class(TProtobufRepeatedField<T>)
  private
    FStorage: TList<T>;

  protected
    function GetCount: Integer; override;
    procedure SetCount(aCount: Integer); override;
    function GetValue(aIndex: Integer): T; override;
    procedure SetValue(aIndex: Integer; aValue: T); override;
    function DoGetEnumerator: TList<T>.TEnumerator; override;

  public
    constructor Create; override;
    destructor Destroy; override;

    function Add(const aValue: T): Integer; override;
    function EmplaceAdd: T; override;

    procedure Clear; override;
    procedure Delete(aIndex: Integer); override;
    function ExtractAt(aIndex: Integer): T; override;
  end;

implementation

constructor TProtobufRepeatedBasicField<T>.Create;
begin
  FStorage := TList<T>.Create;
end;

destructor TProtobufRepeatedBasicField<T>.Destroy;
begin
  FStorage.Free;
end;

function TProtobufRepeatedBasicField<T>.GetCount;
begin
  result := FStorage.Count;
end;

procedure TProtobufRepeatedBasicField<T>.SetCount(aCount: Integer);
begin
  FStorage.Count := aCount;
end;

function TProtobufRepeatedBasicField<T>.GetValue(aIndex: Integer): T;
begin
  result := FStorage[aIndex];
end;

procedure TProtobufRepeatedBasicField<T>.SetValue(aIndex: Integer; aValue: T);
begin
  FStorage[aIndex] := aValue;
end;

function TProtobufRepeatedBasicField<T>.DoGetEnumerator: TList<T>.TEnumerator;
begin
  result := FStorage.GetEnumerator;
end;

function TProtobufRepeatedBasicField<T>.Add(const aValue: T): Integer;
begin
  FStorage.Add(aValue);
end;

function TProtobufRepeatedBasicField<T>.EmplaceAdd: T;
begin
  Count := Count + 1;
  result := GetValue(Count - 1);
end;

procedure TProtobufRepeatedBasicField<T>.Clear;
begin
  FStorage.Clear;
end;

procedure TProtobufRepeatedBasicField<T>.Delete(aIndex: Integer);
begin
  FStorage.Delete(aIndex);
end;

function TProtobufRepeatedBasicField<T>.ExtractAt(aIndex: Integer): T;
begin
  result := FStorage[aIndex];
  Delete(aIndex);
end;

end.
