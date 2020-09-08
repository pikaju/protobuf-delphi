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
  TWireCodec<T> = interface
    procedure EncodeField(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream);
    function DecodeField(aData: TList<TEncodedField>): T;

    procedure EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
    procedure DecodeRepeatedField(aData: TList<TEncodedField>; aDest: TList<T>);
  end;

  // Base class for Protobuf field codecs that can create packed encoding.
  TPackableWireCodec<T> = interface(TWireCodec<T>)
    procedure EncodePackedRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
  end;

implementation

end.
