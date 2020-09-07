unit Com.GitHub.Pikaju.Protobuf.Delphi.uFieldCodec;

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
  TFieldCodec<T> = interface
    procedure EncodeField(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream);
    procedure DecodeField(aEncodedField: TEncodedField; out aResult: T);

    procedure EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
    procedure DecodeRepeatedField(aEncodedField: TEncodedField; aResult: TList<T>);
  end;

  // Base class for Protobuf field codecs that can create packed encoding.
  TPackableFieldCodec<T> = interface(TFieldCodec<T>)
    procedure EncodePackedRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
  end;

implementation

end.
