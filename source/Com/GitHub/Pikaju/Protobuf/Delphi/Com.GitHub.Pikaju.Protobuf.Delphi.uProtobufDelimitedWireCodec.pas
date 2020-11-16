/// <summary>
/// Runtime library support code for encoding/decoding of
/// protobuf non-message length-delimited type fields from/to the protobuf binary wire format.
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDelimitedWireCodec;

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
  System.Classes,
{$ELSE}
  Classes,
{$ENDIF}
  // TBytes to represent value data
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.SysUtils;
{$ELSE}
  SysUtils;
{$ENDIF}


type
  /// <summary>
  /// Runtime library implementation of <see cref="T:IProtobufWireCodec"/> for protobuf non-message length-delimited type types.
  /// </summary>
  /// <typeparam name="T">Delphi type representing this codec's protobuf type</typeparam>
  TProtobufDelimitedWireCodec<T> = class(TProtobufWireCodec<T>)
    // Abstract members

    public
      /// <summary>
      /// Casts a byte array to the Delphi type representing this codec's protobuf type.
      /// </summary>
      /// <param name="aValue">The data to cast</param>
      /// <returns>Value representing the protobuf data</returns>
      function FromBytes(aValue: TBytes): T; virtual; abstract;

      /// <summary>
      /// Casts a value of the Delphi type representing this codec's protobuf type to a byte array.
      /// </summary>
      /// <param name="aValue">The protobuf data</param>
      /// <returns>Corresponding byte array</returns>
      function ToBytes(aValue: T): TBytes; virtual; abstract;

    // IProtobufWireCodec<T> implementation

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
  // For encoding and decoding of varint type lengths
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint,
  // TObjectList for handling unparsed fields
{$IFDEF WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
  System.Generics.Collections;
{$ELSE}
  Generics.Collections;
{$ENDIF}

// IProtobufWireCodec<T> implementation

procedure TProtobufDelimitedWireCodec<T>.EncodeSingularField(aValue: T; aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber; aDest: TStream);
var
  lBytes: TBytes;
begin
  TProtobufTag.WithData(aField, wtLengthDelimited).Encode(aDest);
  lBytes := ToBytes(aValue);
  EncodeVarint(Length(lBytes), aDest);
  if (Length(lBytes) > 0) then
    aDest.WriteBuffer(lBytes[0], Length(lBytes));
end;

function TProtobufDelimitedWireCodec<T>.DecodeUnknownField(aContainer: IProtobufMessageInternal; aField: TProtobufFieldNumber): T;
var
  lContainer: TProtobufMessage;
  lFields: TObjectList<TProtobufEncodedField>;
  lField: TProtobufEncodedField;
  lStream: TMemoryStream;
  lLength: UInt32;
  lBytes: TBytes;
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

        lLength := DecodeVarint(lStream);
        SetLength(lBytes, lLength);
        if (lLength > 0) then
          lStream.ReadBuffer(lBytes[0], lLength);

        result := FromBytes(lBytes);
      finally
        lStream.Free;
      end;
    end;
  end;
end;

end.
