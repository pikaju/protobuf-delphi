{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ProtobufDelphi;

{$warn 5023 off : no warning about unused units}
interface

uses
  uExampleData, Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufBool, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufBytes, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDelimitedWireCodec, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDouble, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEnum, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixed32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixed64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFixedWidthWireCodec, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufFloat, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufInt32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufInt64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBool, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBytes, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedDelimitedFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedDouble, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixed32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixed64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFixedWidthFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFloat, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedInt32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedInt64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedMessageFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedPrimitiveFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedSfixed32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedSfixed64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedString, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedUint32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedUint64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSfixed32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufSfixed64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufString, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint64, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufMessage, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.
  uIProtobufRepeatedFieldValues, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uProtobufMessage, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uIProtobufMessageInternal, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uIProtobufRepeatedFieldValuesInternal, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uIProtobufWireCodec, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufBool, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufBytes, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufDouble, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufEnum, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufFixed32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufFixed64, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufFloat, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufInt32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufInt64, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedBool, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedBytes, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedDouble, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedFixed32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedFixed64, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedFloat, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedInt32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedInt64, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedMessage, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedSfixed32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedSfixed64, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedString, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedUint32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedUint64, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufSfixed32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufSfixed64, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufString, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufUint32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufUint64, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ProtobufDelphi', @Register);
end.
