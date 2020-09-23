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
  // To classify generic type
  TypInfo,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

type
  /// <summary>
  /// TODO
  /// </summary>
  /// <typeparam name="T">TODO</typeparam>
  TProtobufRepeatedMessageField<T: TProtobufMessage> = class(TProtobufRepeatedField<T>)
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

constructor TProtobufRepeatedMessageField<T>.Create;
begin
  // TODO not implemented
end;

destructor TProtobufRepeatedMessageField<T>.Destroy;
begin
  // TODO not implemented
end;

function TProtobufRepeatedMessageField<T>.GetCount;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedMessageField<T>.SetCount(aCount: Integer);
begin
  // TODO not implemented
end;

function TProtobufRepeatedMessageField<T>.GetValue(aIndex: Integer): T;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedMessageField<T>.SetValue(aIndex: Integer; aValue: T);
begin
  // TODO not implemented
end;

function TProtobufRepeatedMessageField<T>.Add(const aValue: T): Integer;
begin
  // TODO not implemented
end;

function TProtobufRepeatedMessageField<T>.EmplaceAdd: T;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedMessageField<T>.Clear;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedMessageField<T>.Delete(aIndex: Integer);
begin
  // TODO not implemented
end;

function TProtobufRepeatedMessageField<T>.ExtractAt(aIndex: Integer): T;
begin
  // TODO not implemented
end;

end.
