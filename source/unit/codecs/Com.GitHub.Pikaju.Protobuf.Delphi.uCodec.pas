unit Com.GitHub.Pikaju.Protobuf.Delphi.uCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag;

type
  // Base class for all Protobuf field codecs.
  TWireCodec<T> = class abstract
    procedure EncodeField(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream); virtual; abstract;
    function DecodeField(aData: TList<TEncodedField>): T; virtual; abstract;

    procedure EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream); virtual; abstract;
    procedure DecodeRepeatedField(aData: TList<TEncodedField>; aDest: TList<T>); virtual; abstract;
  end;

  // Base class for Protobuf field codecs that can create packed encoding.
  TPackableWireCodec<T> = class abstract(TWireCodec<T>)
    procedure EncodePackedRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream); virtual; abstract;
  end;

implementation

end.
