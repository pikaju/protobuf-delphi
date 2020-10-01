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
  protected
    /// <summary>
    /// TODO
    /// </summary>
    function GetCount: Integer; virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    procedure SetCount(aCount: Integer); virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    function GetValue(aIndex: Integer): T; virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    procedure SetValue(aIndex: Integer; aValue: T); virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    function DoGetEnumerator: TList<T>.TEnumerator; override; abstract;

  public
    /// <summary>
    /// TODO
    /// </summary>
    constructor Create; virtual; abstract;

    /// <summary>
    /// TODO destroys transitively held resources, meaning field values of message type and their nested embedded objects
    /// </summary>
    destructor Destroy; override; abstract;

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
    function Add(const aValue: T): Integer; virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    /// <returns>TODO</return>
    function EmplaceAdd: T; virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    procedure Clear; virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="aIndex">TODO</param>
    procedure Delete(aIndex: Integer); virtual; abstract;

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="aIndex">TODO</param>
    /// <returns>TODO</returns>
    function ExtractAt(aIndex: Integer): T; virtual; abstract;
  end;

implementation

end.
