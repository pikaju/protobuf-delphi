/// <summary>
/// Runtime library support code for encoding/decoding of
/// protobuf varint type fields from/to the protobuf binary wire format.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec;

{$INCLUDE Work.Connor.Delphi.CompilerFeatures.inc}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // To extend TProtobufWireCodec<T>
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec,
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
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for protobuf varint types.
  /// </summary>
  /// <typeparam name="T">Delphi type representing this codec's protobuf varint type</typeparam>
  TProtobufVarintWireCodec<T> = class(TProtobufWireCodec<T>)
    protected
      /// <summary>
      /// Utility function that detects whether an integer can be represented by a varint type.
      /// </summary>
      /// <param name="aValue">The integer value to represent</param>
      /// <param name="aBitCount">Size of the varint type in bits</param>
      /// <param name="aSigned"><c>true</c> if the varint type is signed</param>
      /// <exception cref="EDecodingSchemaError">If the integer value could not be represented by the varint</exception>
      class procedure ValidateBounds(aValue: UInt64; aBitCount: Integer; aSigned: Boolean);

    // Abstract members

    public
      /// <summary>
      /// Casts an integer to the Delphi type representing this codec's protobuf varint type.
      /// </summary>
      /// <param name="aValue">The integer to cast</param>
      /// <returns>Value representing a varint</returns>
      function FromUInt64(aValue: UInt64): T; virtual; abstract;

      /// <summary>
      /// Casts a value of the Delphi type representing this codec's protobuf varint type to an integer.
      /// </summary>
      /// <param name="aValue">The varint value to cast</param>
      /// <returns>Corresponding integer value</returns>
      function ToUInt64(aValue: T): UInt64; virtual; abstract;

    // TProtobufWireCodec<T> implementation

    public
      function IsDefault(aValue: T): Boolean; override;

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
  // For encoding and decoding of protobuf tags
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag,
  // For encoding and decoding of varint type values
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

class procedure TProtobufVarintWireCodec<T>.ValidateBounds(aValue: UInt64; aBitCount: Integer; aSigned: Boolean);
var
  lMasked: UInt64;
begin
  if (aSigned) then
  begin
    // For signed types, the sign bit and all padding bits in the UInt64 must have the same value.

    lMasked := aValue and (UInt64(-1) shl (aBitCount - 1));
    // Positive numbers
    if ((lMasked <> 0) and (lMasked <> (UInt64(-1) shl (aBitCount - 1)))) then
      raise EDecodingSchemaError.Create('Decoded varint smaller or larger than is allowed by ' + IntToStr(aBitCount) + '-bit signed integer.');
  end
  else
  begin
    // For unsigned types, simply check if there is a binary 1 beyond FBitCount bits.
    if ((UInt64(-1) shl aBitCount) and aValue <> 0) then
      raise EDecodingSchemaError.Create('Decoded varint ' + IntToStr(aValue) + ' larger than is allowed by ' + IntToStr(aBitCount) + '-bit unsigned integer.');
  end;
end;

// TProtobufWireCodec<T> implementation

function TProtobufVarintWireCodec<T>.IsDefault(aValue: T): Boolean;
begin
  result := ToUInt64(aValue) = ToUInt64(GetDefault);
end;

// TProtobufWireCodec<T> implementation

procedure TProtobufVarintWireCodec<T>.EncodeSingularField(aValue: T; aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);
begin
  if (not IsDefault(aValue)) then
  begin
    TProtobufTag.WithData(aField, wtVarint).Encode(aDest);
    EncodeVarint(ToUInt64(aValue), aDest);
  end;
end;

function TProtobufVarintWireCodec<T>.DecodeUnknownField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber): T;
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

        if (lField.Tag.WireType = wtVarint) then
          result := FromUInt64(DecodeVarint(lStream))
        else if (lField.Tag.WireType = wtLengthDelimited) then
        begin
          // Ignore the size of the field, as the stream already has the correct length.
          DecodeVarint(lStream);
          while (lStream.Position < lStream.Size) do
            result := FromUInt64(DecodeVarint(lStream));
        end; // TODO: Catch invalid wire type.
      finally
        lStream.Free;
      end;
    end;
  end;
end;

end.
