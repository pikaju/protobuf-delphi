unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Generics.Collections,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage;

type
  TProtobufRepeatedField<T> = class(TEnumerable<T>)
  private
    FStorage: TObjectList<T>;

    procedure InitializeElement(aIndex: Integer);

    function GetCount: Integer;
    procedure SetCount(aCount: Integer);
    function GetValue(aIndex: Integer): T;
    procedure SetValue(aIndex: Integer; const aValue: T);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function Add(const aValue: T): Integer;
    function EmplaceAdd: T;

    procedure Clear;
    procedure Delete(aIndex: Integer);

    function ExtractAt(aIndex: Integer): T;

    property Count: Integer read GetCount write SetCount;
    property Values[aIndex: Integer]: T read GetValue write SetValue; default;
  end;

implementation

constructor TProtobufRepeatedField<T>.Create; virtual;
begin
  FStorage := TObjectList<T>.Create;
  // Only repeated message fields require memory management.
  FStorage.HasOwnership := T.InheritsFrom(TProtobufMessage);
end;

destructor TProtobufRepeatedField<T>.Destroy; override;
begin
  FStorage.Free;
end;

procedure TProtobufRepeatedField<T>InitializeElement(aIndex: Integer);
begin
  if (T.InheritsFrom(TProtobufMessage)) do
    FStorage[aIndex] := T.Create;
end;

function TProtobufRepeatedField<T>.GetCount: Integer;
begin
  result := FStorage.Count;
end;

procedure TProtobufRepeatedField<T>.SetCount(aCount: Integer);
var
  lOldCount: Integer;
begin
  lOldCount := FStorage.Count;
  FStorage.Count := aCount;
  for lOldCount to FStorage.Count - 1 do
    InitializeElement(l);
end;

function TProtobufRepeatedField<T>.GetValue(aIndex: Integer): T;
begin
  result := FStorage[aIndex];
end;

procedure TProtobufRepeatedField<T>.SetValue(aIndex: Integer; const aValue: T);
begin
  FStorage[aIndex] := aValue;
end;

function TProtobufRepeatedField<T>.Add(const aValue: T): Integer;
begin
  FStorage.Add(aValue);
end;

function TProtobufRepeatedField<T>.EmplaceAdd: T;
begin
  Count := Count + 1;
end;

procedure TProtobufRepeatedField<T>.Clear;
begin
  FStorage.Clear;
end;

procedure TProtobufRepeatedField<T>.Delete(aIndex: Integer);
begin
  FStorage.Delete(aIndex);
end;

function TProtobufRepeatedField<T>.ExtractAt(aIndex: Integer): T;
begin
  // TODO
end;

end.
