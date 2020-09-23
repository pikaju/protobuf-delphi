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
  // To classify generic type
  TypInfo,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

type
  /// <summary>
  /// TODO
  /// </summary>
  /// <typeparam name="T">TODO</typeparam>
  TProtobufRepeatedBasicField<T> = class(TProtobufRepeatedField<T>)
  protected
    function GetCount: Integer; override;
    procedure SetCount(aCount: Integer); override;
    function GetValue(aIndex: Integer): T; override;
    procedure SetValue(aIndex: Integer; aValue: T); override;

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
  // TODO not implemented
end;

destructor TProtobufRepeatedBasicField<T>.Destroy;
begin
  // TODO not implemented
end;

function TProtobufRepeatedBasicField<T>.GetCount;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedBasicField<T>.SetCount(aCount: Integer);
begin
  // TODO not implemented
end;

function TProtobufRepeatedBasicField<T>.GetValue(aIndex: Integer): T;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedBasicField<T>.SetValue(aIndex: Integer; aValue: T);
begin
  // TODO not implemented
end;

function TProtobufRepeatedBasicField<T>.Add(const aValue: T): Integer;
begin
  // TODO not implemented
end;

function TProtobufRepeatedBasicField<T>.EmplaceAdd: T;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedBasicField<T>.Clear;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedBasicField<T>.Delete(aIndex: Integer);
begin
  // TODO not implemented
end;

function TProtobufRepeatedBasicField<T>.ExtractAt(aIndex: Integer): T;
begin
  // TODO not implemented
end;

end.
