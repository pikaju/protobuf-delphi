{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ProtobufDelphi;

{$warn 5023 off : no warning about unused units}
interface

uses
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
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufEnum, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedBool, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedMessage, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedString, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufRepeatedUint32, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufString, 
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.
  uProtobufUint32, Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufBool, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufDelimitedWireCodec, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEncodedField, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEnum, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufMessage, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedBool, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedDelimitedFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedMessageFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedPrimitiveFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedString, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedUint32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufRepeatedVarintFieldValues, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufString, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufTag, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufUint32, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarint, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufVarintWireCodec, 
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufWireCodec, uExampleData, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ProtobufDelphi', @Register);
end.
