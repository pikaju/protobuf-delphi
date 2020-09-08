unit Com.GitHub.Pikaju.Protobuf.Delphi.uCodec;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes,
  Generics.Collections,
  Com.GitHub.Pikaju.Protobuf.Delphi.uCodec,
  Com.GitHub.Pikaju.Protobuf.Delphi.uEncodedField,
  Com.GitHub.Pikaju.Protobuf.Delphi.uTag;

type
  TVarintWireCodec<T> = class(TPackedWireCodec<T>);

implementation

procedure TVarintWireCodec.EncodeField(aFieldNumber: TFieldNumber; aValue: T; aDest: TStream);
procedure TVarintWireCodec.DecodeField(aData: TList<TEncodedField>; out aResult: T);

procedure TVarintWireCodec.EncodeRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);
procedure TVarintWireCodec.DecodeRepeatedField(aData: TList<TEncodedField>; aResult: TList<T>);

procedure TVarintWireCodec.EncodePackedRepeatedField(aFieldNumber: TFieldNumber; aValues: TList<T>; aDest: TStream);

end.
