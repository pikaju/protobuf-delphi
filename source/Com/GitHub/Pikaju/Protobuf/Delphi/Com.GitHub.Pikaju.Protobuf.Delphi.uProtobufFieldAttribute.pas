/// <summary>
/// Runtime library support code for RTTI attributes on properties representing protobuf fields.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFieldAttribute;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To implement IProtobufFieldAttribute
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufFieldAttribute,
  // TProtobufFieldNumber for IProtobufFieldAttribute implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufFieldAttribute"/>.
  /// </summary>
  TProtobufFieldAttribute = class(TCustomAttribute, IProtobufFieldAttribute, IInterface)
    private
      /// <summary>
      /// Name of the protobuf field.
      /// </summary>
      FName: String;

      /// <summary>
      /// Field number of the protobuf field.
      /// </summary>
      FNumber: TProtobufFieldNumber;

    public
      /// <summary>
      /// Constructs an RTII attribute for a property representing a protobuf field.
      /// </summary>
      /// <param name="aName">The name of the protobuf field</param>
      /// <param name="aNumber">The field number of the protobuf field</param>
      constructor Create(aName: String; aNumber: TProtobufFieldNumber);

    // IProtobufFieldAttribute implementation

    public
      /// <summary>
      /// Getter for <see cref="Name"/>.
      /// </summary>
      /// <returns>The name of the protobuf field</returns>
      function GetName: String;

      /// <summary>
      /// Name of the protobuf field.
      /// </summary>
      /// <remarks>
      /// This matches the original name of the field in the protobuf schema definition, not the derived name of the corresponding Delphi property.
      /// </remarks>
      property Name: String read GetName;

      /// <summary>
      /// Getter for <see cref="Number"/>.
      /// </summary>
      /// <returns>The field number of the protobuf field</returns>
      function GetNumber: TProtobufFieldNumber;

      /// <summary>
      /// Field number of the protobuf field.
      /// </summary>
      property Number: TProtobufFieldNumber read GetNumber;

    // IInterface implementation

    public
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
  end;

implementation

constructor TProtobufFieldAttribute.Create(aName: String; aNumber: TProtobufFieldNumber);
begin
  FName := aName;
  FNumber := aNumber;
end;

// IProtobufFieldAttribute implementation

function TProtobufFieldAttribute.GetName: String;
begin
  result := FName;
end;

function TProtobufFieldAttribute.GetNumber: TProtobufFieldNumber;
begin
  result := FNumber;
end;

// IInterface implementation (no reference counting)

function TProtobufFieldAttribute.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result:= S_OK
  else
    Result:= E_NOINTERFACE;
end;
 
function TProtobufFieldAttribute._AddRef: Integer;
begin
  Result:= -1;
end;
 
function TProtobufFieldAttribute._Release: Integer;
begin
  Result:= -1;
end;

end.
