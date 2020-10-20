/// <summary>
/// Runtime library support for <c>protoc-gen-delphi</c> <i>field codecs</i> that define the encoding/decoding of
/// protobuf fields from/to the protobuf binary wire format (<i>wire codecs</i>).
/// </summary>
unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // Basic definitions of <c>protoc-gen-delphi</c>, independent of the runtime library implementation
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.Internal.uProtobufEncodedField,
  Classes,
  Generics.Collections;

type
  /// <summary>
  /// <i>Field codec</i> for <c>protoc-gen-delphi</c> that defines the encoding/decoding of
  /// protobuf fields of a specific type (determined by descendant classes) from/to the protobuf binary wire format.
  /// </summary>
  /// <typeparam name="T">"Private" Delphi type representing values of the field within internal variables</typeparam>
  TProtobufWireCodec<T> = class abstract
    // TODO visibility?
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream); virtual; abstract;
    function DecodeField(aData: TList<TProtobufEncodedField>): T; virtual; abstract;

    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TProtobufRepeatedField<T>; aDest: TStream); virtual; abstract;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TProtobufRepeatedField<T>); virtual; abstract;
  end;

  // Base class for Protobuf field codecs that can create packed encoding.
  TProtobufPackableWireCodec<T> = class abstract(TProtobufWireCodec<T>)
    // TODO visibility?
    procedure EncodePackedRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TProtobufRepeatedField<T>; aDest: TStream); virtual; abstract;
  end;

implementation

end.
