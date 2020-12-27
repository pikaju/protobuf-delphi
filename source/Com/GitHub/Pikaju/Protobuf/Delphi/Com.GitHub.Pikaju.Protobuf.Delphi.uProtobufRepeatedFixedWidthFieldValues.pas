/// <summary>
/// Support code for handling of fixed width scalar type values in <see cref="N:Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues"/>.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufRepeatedPrimitiveFieldValues<T>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedPrimitiveFieldValues,
  // TProtobufFixedWidthWireCodec<T> for encoding and decoding of field values
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec,
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
  /// Helper subclass of <see cref="T:TProtobufRepeatedPrimitiveFieldValues"/> for values of a specific fixed width scalar type type.
  /// </summary>
  /// <typeparam name="T">Delphi type of the field values</typeparam>
  TProtobufRepeatedFixedWidthFieldValues<T> = class abstract(TProtobufRepeatedPrimitiveFieldValues<T>)
    // Abstract members

    protected
      /// <summary>
      /// Getter for <see cref="FixedWidthWireCodec"/>.
      /// </summary>
      /// <returns>Field codec for the protobuf type</returns>
      function GetFixedWidthWireCodec: TProtobufFixedWidthWireCodec<T>; virtual; abstract;

      /// <summary>
      /// Field codec for the protobuf type.
      /// </summary>
      property FixedWidthWireCodec: TProtobufFixedWidthWireCodec<T> read GetFixedWidthWireCodec;

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
  // For encoding and decoding of field lengths
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint,
  // TObjectList for handling unparsed fields
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

// TProtobufRepeatedPrimitiveFieldValues<T> implementation

function TProtobufRepeatedFixedWidthFieldValues<T>.GetWireCodec: TProtobufWireCodec<T>;
begin
  result := FixedWidthWireCodec;
end;


// IProtobufRepeatedFieldValuesInternal<T> implementation

procedure TProtobufRepeatedFixedWidthFieldValues<T>.EncodeAsRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);
var
  lValue: T;
  lStream: TStream;
begin
  if (Count <> 0) then
  begin
    // Encode the values to a temporary stream first to determine their size.
    lStream := TMemoryStream.Create;
    try
      for lValue in self do FixedWidthWireCodec.EncodeValue(lValue, lStream);
      lStream.Seek(0, soBeginning);
      TProtobufTag.WithData(aField, FixedWidthWireCodec.GetWireType).Encode(aDest);
      EncodeVarint(lStream.Size, aDest);
      aDest.CopyFrom(lStream, lStream.Size);
    finally
      lStream.Free;
    end;
  end;
end;

procedure TProtobufRepeatedFixedWidthFieldValues<T>.DecodeAsUnknownRepeatedField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber);
var
  lContainer: TProtobufMessage;
  lFields: TObjectList<TProtobufEncodedField>;
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  lContainer := aContainer as TProtobufMessage;

  // Default value for repeated fields is empty.
  Clear;

  lFields := nil;
  lContainer.UnparsedFields.TryGetValue(aField, lFields);
  if (Assigned(lFields)) then
  begin
    // For each field, we will decide whether to decode a packed or non-packed repeated value
    for lField in lFields do
    begin
      // Convert field to a stream for simpler processing.
      lStream := TMemoryStream.Create;
      try
        lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
        lStream.Seek(0, soBeginning);

        if (lField.Tag.WireType = FixedWidthWireCodec.GetWireType) then Add(FixedWidthWireCodec.DecodeValue(lStream))
        else if (lField.Tag.WireType = wtLengthDelimited) then
        begin
          // Ignore the size of the field, as the stream already has the correct length.
          DecodeVarint(lStream);
          while (lStream.Position < lStream.Size) do
            Add(FixedWidthWireCodec.DecodeValue(lStream));
        end; // TODO: Catch invalid wire type.
      finally
        lStream.Free;
      end;
    end;
    lContainer.UnparsedFields.Remove(aField);
  end;
end;

end.
