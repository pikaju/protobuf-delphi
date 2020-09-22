/// <summary>
/// Runtime library implementation of support code for handling protobuf repeated fields 
/// in generated Delphi code.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // For TEnumerable implementation
  Generics.Collections;

type
  /// <summary>
  /// TODO
  /// </summary>
  /// <typeparam name="T">TODO</typeparam>
  TProtobufRepeatedField<T> = class(TEnumerable<T>)

  private
    /// <summary>
    /// TODO
    /// </summary>
    function GetCount: Integer;

    /// <summary>
    /// TODO
    /// </summary>
    procedure SetCount(aCount: Integer);

    /// <summary>
    /// TODO
    /// </summary>
    function GetValue(aIndex: Integer): T;

    /// <summary>
    /// TODO
    /// </summary>
    procedure SetValue(aIndex: Integer; aValue: T);

  public
    /// <summary>
    /// TODO
    /// </summary>
    constructor Create; virtual;

    /// <summary>
    /// TODO destroys transitively held resources, meaning field values of message type and their nested embedded objects
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// TODO
    /// </summary>
    property Count: Integer read GetCount write SetCount;

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="aIndex">TODO</param>
    property Values[aIndex: Integer]: T read GetValue write SetValue; default;

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="aValue">TODO</param>
    /// <returns>TODO</return>
    function Add(const aValue: T): Integer;

    /// <summary>
    /// TODO
    /// </summary>
    /// <returns>TODO</return>
    function EmplaceAdd: T;

    /// <summary>
    /// TODO
    /// </summary>
    procedure Clear;

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="aIndex">TODO</param>
    procedure Delete(aIndex: Integer);

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="aIndex">TODO</param>
    /// <returns>TODO</returns>
    function ExtractAt(aIndex: Integer): T;
  end;

implementation

constructor TProtobufRepeatedField<T>.Create;
begin
  // TODO not implemented
end;

destructor TProtobufRepeatedField<T>.Destroy;
begin
  // TODO not implemented
end;

function TProtobufRepeatedField<T>.GetCount;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedField<T>.SetCount(aCount: Integer);
begin
  // TODO not implemented
end;

function TProtobufRepeatedField<T>.GetValue(aIndex: Integer): T;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedField<T>.SetValue(aIndex: Integer; aValue: T);
begin
  // TODO not implemented
end;

function TProtobufRepeatedField<T>.Add(const aValue: T): Integer;
begin
  // TODO not implemented
end;

function TProtobufRepeatedField<T>.EmplaceAdd: T;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedField<T>.Clear;
begin
  // TODO not implemented
end;

procedure TProtobufRepeatedField<T>.Delete(aIndex: Integer);
begin
  // TODO not implemented
end;

function TProtobufRepeatedField<T>.ExtractAt(aIndex: Integer): T;
begin
  // TODO not implemented
end;

end.
