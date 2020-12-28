/// Copyright 2020 Connor Roehricht (connor.work)
/// Copyright 2020 Sotax AG
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

/// <summary>
/// Runtime-internal support for the protobuf enum types.
/// </summary>
/// <remarks>
/// Generated code needs to reference this unit in order to operate on protobuf field values of enum types.
/// </remarks>
unit Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uProtobufEnum;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // Runtime-internal support for the protobuf binary wire format
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.Internal.uIProtobufWireCodec,
  // Definition of TProtobufEnumFieldValue
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf,
  // To provide the wire codec instance
  Com.GitHub.Pikaju.Protobuf.Delphi.uProtobufEnum;

var
  /// <summary>
  /// <i>Field codec</i> for <c>protoc-gen-delphi</c> that defines the encoding/decoding of
  /// protobuf fields of enum types from/to the protobuf binary wire format.
  /// </summary>
  gProtobufWireCodecEnum: IProtobufWireCodec<TProtobufEnumFieldValue>;

implementation

initialization
begin
  gProtobufWireCodecEnum := TProtobufEnumWireCodec.Create;
end;

end.
