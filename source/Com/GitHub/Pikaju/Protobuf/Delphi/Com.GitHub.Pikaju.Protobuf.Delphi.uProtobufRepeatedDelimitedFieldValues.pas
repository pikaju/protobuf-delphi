/// <summary>
/// Support code for handling of non-message length-delimited type values in <see cref="N:Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues"/>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedDelimitedFieldValues;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedPrimitiveFieldValues<T>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedPrimitiveFieldValues,
  // TProtobufDelimitedWireCodec<T> for encoding and decoding of field values
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDelimitedWireCodec,
  // TProtobufWireCodec<T> TProtobufRepeatedPrimitiveFieldValues<T> implementation
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // IProtobufMessageInternal for IProtobufRepeatedFieldValuesInternal<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal,
  // TProtobufFieldNumber for IProtobufRepeatedFieldValuesInternal<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // TStream for IProtobufRepeatedFieldValuesInternal<T> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes;
{$ELSE}
  Classes;
{$ENDIF}

type
  /// <summary>
  /// Helper subclass of <see cref="T:TProtobufRepeatedPrimitiveFieldValues"/> for values of a specific non-message length-delimited type.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  TProtobufRepeatedDelimitedFieldValues<T> = class abstract(TProtobufRepeatedPrimitiveFieldValues<T>)
    // Abstract members

    protected
      /// <summary>
      /// Getter for <see cref="DelimitedWireCodec"/>.
      /// </summary>
      /// <returns>Field codec for the protobuf type</returns>
      function GetDelimitedWireCodec: TProtobufDelimitedWireCodec<T>; virtual; abstract;

      /// <summary>
      /// Field codec for the protobuf type.
      /// </summary>
      property DelimitedWireCodec: TProtobufDelimitedWireCodec<T> read GetDelimitedWireCodec;

    // TProtobufRepeatedPrimitiveFieldValues<T> implementation

    protected
      function GetWireCodec: TProtobufWireCodec<T>; override;

    // IProtobufRepeatedFieldValuesInternal<T> implementation

    public
      procedure EncodeAsRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream); override;
      procedure DecodeAsUnknownRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber); override;
  end;

implementation

uses
  // For handling protobuf encoded fields
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  // TProtobufMessage for message field encoding and decoding
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  // For encoding and decoding of protobuf tags
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  // For encoding and decoding of varint type lengths
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint,
  // TObjectList for handling unparsed fields
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections,
{$ELSE}
  Generics.Collections,
{$ENDIF}
  // TBytes to represent value data
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.SysUtils;
{$ELSE}
  SysUtils;
{$ENDIF}

// TProtobufRepeatedPrimitiveFieldValues<T> implementation

function TProtobufRepeatedDelimitedFieldValues<T>.GetWireCodec: TProtobufWireCodec<T>;
begin
  result := DelimitedWireCodec;
end;

// IProtobufRepeatedFieldValuesInternal<T> implementation

procedure TProtobufRepeatedDelimitedFieldValues<T>.EncodeAsRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);
var
  lValue: T;
  lBytes: TBytes;
begin
  for lValue in self do
  begin
    TProtobufTag.WithData(aField, wtLengthDelimited).Encode(aDest);
    lBytes := DelimitedWireCodec.ToBytes(lValue);
    EncodeVarint(Length(lBytes), aDest);
    if (Length(lBytes) > 0) then aDest.WriteBuffer(lBytes[0], Length(lBytes));
  end;
end;

procedure TProtobufRepeatedDelimitedFieldValues<T>.DecodeAsUnknownRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber);
var
  lContainer: TProtobufMessage;
  lFields: TObjectList<TProtobufEncodedField>;
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
  lLength: UInt32;
  lBytes: TBytes;
begin
  lContainer := aContainer as TProtobufMessage;

  // Default value for repeated fields is empty.
  Clear;

  lFields := nil;
  lContainer.UnparsedFields.TryGetValue(aField, lFields);
  if (Assigned(lFields)) then
  begin
    // For each field, we will decide wether to decode a packed or non-packed repeated varint.
    for lField in lFields do
    begin
      if (lField.Tag.WireType = wtLengthDelimited) then
      begin
        // Convert field to a stream for simpler processing.
        lStream := TMemoryStream.Create;
        try
          lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
          lStream.Seek(0, soBeginning);

          lLength := DecodeVarint(lStream);
          SetLength(lBytes, lLength);
          if (lLength > 0) then
            lStream.ReadBuffer(lBytes[0], lLength);

          Add(DelimitedWireCodec.FromBytes(lBytes));
        finally
          lStream.Free;
        end;
      end; // TODO: Catch invalid wire type.
    end;
    lContainer.UnparsedFields.Remove(aField);
  end;
end;

end.


