/// <summary>
/// Runtime library implementation of support code for handling protobuf repeated fields 
/// in generated Delphi code.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedMessageField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // For TEnumerable implementation
  Generics.Collections,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

type
  /// <summary>
  /// TODO
  /// </summary>
  /// <typeparam name="T">TODO</typeparam>
  TProtobufRepeatedMessageField<T: TProtobufMessage> = class(TProtobufRepeatedField<T>)
  private
    FStorage: TObjectList<T>;

    procedure DefaultInitialize(aIndex: Integer);

  protected
    function GetCount: Integer; override;
    procedure SetCount(aCount: Integer); override;
    function GetValue(aIndex: Integer): T; override;
    procedure SetValue(aIndex: Integer; aValue: T); override;
    function DoGetEnumerator: TList<T>.TEnumerator; override;

  public
    constructor Create; override;
    destructor Destroy; override;

    function Add(aValue: T): Integer; override;
    function EmplaceAdd: T; override;

    procedure Clear; override;
    procedure Delete(aIndex: Integer); override;
    function ExtractAt(aIndex: Integer): T; override;
  end;

implementation

constructor TProtobufRepeatedMessageField<T>.Create;
begin
  FStorage := TObjectList<T>.Create;
end;

destructor TProtobufRepeatedMessageField<T>.Destroy;
begin
  FStorage.Free;
end;

procedure TProtobufRepeatedMessageField<T>.DefaultInitialize(aIndex: Integer);
begin
  FStorage[aIndex] := T.Create;
end;

function TProtobufRepeatedMessageField<T>.GetCount;
begin
  result := FStorage.Count;
end;

procedure TProtobufRepeatedMessageField<T>.SetCount(aCount: Integer);
var
  lOldCount: Integer;
  lIndex: Integer;
begin
  lOldCount := FStorage.Count;
  FStorage.Count := aCount;
  for lIndex := lOldCount to FStorage.Count - 1 do
    DefaultInitialize(lIndex);
end;

function TProtobufRepeatedMessageField<T>.GetValue(aIndex: Integer): T;
begin
  result := FStorage[aIndex];
end;

procedure TProtobufRepeatedMessageField<T>.SetValue(aIndex: Integer; aValue: T);
begin
  FStorage[aIndex] := aValue;
end;

function TProtobufRepeatedMessageField<T>.DoGetEnumerator: TList<T>.TEnumerator;
begin
  result := FStorage.GetEnumerator;
end;

function TProtobufRepeatedMessageField<T>.Add(aValue: T): Integer;
begin
  FStorage.Add(aValue);
end;

function TProtobufRepeatedMessageField<T>.EmplaceAdd: T;
begin
  Count := Count + 1;
  result := GetValue(Count - 1);
end;

procedure TProtobufRepeatedMessageField<T>.Clear;
begin
  FStorage.Clear;
end;

procedure TProtobufRepeatedMessageField<T>.Delete(aIndex: Integer);
begin
  FStorage.Delete(aIndex);
end;

function TProtobufRepeatedMessageField<T>.ExtractAt(aIndex: Integer): T;
begin
  result := FStorage[aIndex];
  FStorage.OwnsObjects := False;
  FStorage.Delete(aIndex);
  FStorage.OwnsObjects := True;
end;

end.
