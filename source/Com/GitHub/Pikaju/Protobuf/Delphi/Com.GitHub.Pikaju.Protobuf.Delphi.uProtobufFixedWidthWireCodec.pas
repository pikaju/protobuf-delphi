/// <summary>
/// Runtime library support code for encoding/decoding of
/// protobuf fixed width scalar type fields from/to the protobuf binary wire format.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufWireCodec<T>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
  // For encoding and decoding of protobuf tags
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  // IProtobufMessageInternal for IProtobufWireCodec<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufMessageInternal,
  // To throw EDecodingSchemaError
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage,
  // TProtobufFieldNumber for IProtobufWireCodec<T> implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // TStream for IProtobufWireCodec<T> implementation
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Classes;
{$ELSE}
  Classes;
{$ENDIF}

type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for protobuf fixed width scalar types.
  /// </summary>
  /// <typeparam name="T">Delphi type representing this codec's protobuf fixed width scalar type</typeparam>
  TProtobufFixedWidthWireCodec<T> = class(TProtobufWireCodec<T>)
    // Abstract members

    public
      /// <summary>
      /// Determines the protobuf wire type for values of this type.
      /// </summary>
      /// <returns>The protobuf wire type</returns>
      function GetWireType: TProtobufWireType; virtual; abstract;

      /// <summary>
      /// Decodes a value from a stream.
      /// </summary>
      /// <param name="aSource">Stream containing the encoded value</param>
      /// <returns>Value representing a fixed width scalar value</returns>
      function DecodeValue(aSource: TStream): T; virtual; abstract;

      /// <summary>
      /// Encodes a value to a stream.
      /// </summary>
      /// <param name="aValue">The fixed width scalar value to encode</param>
      /// <param name="aDest">Stream to encode the value to</param>
      procedure EncodeValue(aValue: T; aDest: TStream); virtual; abstract;

    // TProtobufWireCodec<T> implementation

    public
      procedure EncodeSingularField(aValue: T; aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream); override;
      function DecodeUnknownField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber): T; override;
  end;

implementation

uses
  // For handling protobuf encoded fields
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  // TProtobufMessage for message field encoding and decoding
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage,
  // For encoding and decoding of field lengths
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint,
  // TObjectList for handling unparsed fields
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections,
{$ELSE}
  Generics.Collections,
{$ENDIF}
  // For IntToStr
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.SysUtils;
{$ELSE}
  SysUtils;
{$ENDIF}

// TProtobufWireCodec<T> implementation

procedure TProtobufFixedWidthWireCodec<T>.EncodeSingularField(aValue: T; aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);
begin
  if (not IsDefault(aValue)) then
  begin
    TProtobufTag.WithData(aField, GetWireType).Encode(aDest);
    EncodeValue(aValue, aDest);
  end;
end;

function TProtobufFixedWidthWireCodec<T>.DecodeUnknownField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber): T;
var
  lContainer: TProtobufMessage;
  lFields: TObjectList<TProtobufEncodedField>;
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
begin
  lContainer := aContainer as TProtobufMessage;

  result := GetDefault;

  lFields := nil;
  lContainer.UnparsedFields.TryGetValue(aField, lFields);
  if (Assigned(lFields)) then
  begin
    // https://developers.google.com/protocol-buffers/docs/encoding#optional:
    // For numeric types and strings, if the same field appears multiple times, the parser accepts the last value it sees.
    for lField in lFields do
    begin
      // Convert field to a stream for simpler processing.
      lStream := TMemoryStream.Create;
      try
        lStream.WriteBuffer(lField.Data[0], Length(lField.Data));
        lStream.Seek(0, soBeginning);

        if (lField.Tag.WireType = GetWireType) then
          result := DecodeValue(lStream)
        else if (lField.Tag.WireType = wtLengthDelimited) then
        begin
          // Ignore the size of the field, as the stream already has the correct length.
          DecodeVarint(lStream);
          while (lStream.Position < lStream.Size) do
            result := DecodeValue(lStream);
        end; // TODO: Catch invalid wire type.
      finally
        lStream.Free;
      end;
    end;
  end;
end;

end.
