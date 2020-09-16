unit Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag;

type
  // Base class for all Protobuf field codecs.
  TProtobufWireCodec<T> = class abstract
    procedure EncodeField(aFieldNumber: TProtobufFieldNumber; aValue: T; aDest: TStream); virtual; abstract;
    function DecodeField(aData: TList<TProtobufEncodedField>): T; virtual; abstract;

    procedure EncodeRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream); virtual; abstract;
    procedure DecodeRepeatedField(aData: TList<TProtobufEncodedField>; aDest: TList<T>); virtual; abstract;
  end;

  // Base class for Protobuf field codecs that can create packed encoding.
  TProtobufPackableWireCodec<T> = class abstract(TProtobufWireCodec<T>)
    procedure EncodePackedRepeatedField(aFieldNumber: TProtobufFieldNumber; aValues: TList<T>; aDest: TStream); virtual; abstract;
  end;

implementation

end.
