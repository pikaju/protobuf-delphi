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
/// Runtime support interface for RTTI attributes on properties representing protobuf fields.
/// </summary>
/// <remarks>
/// Client code should reference this unit indirectly through <see cref="N:Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uProtobufMessage"/>.
/// </remarks>
unit Work.Connor.Protobuf.Delphi.ProtocGenDelphi.Runtime.uIProtobufFieldAttribute;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  // Basic protobuf definitions like TProtobufFieldNumber
  Work.Connor.Protobuf.Delphi.ProtocGenDelphi.uProtobuf;

type
  /// <summary>
  /// RTTI attribute that annotates a property representing a protobuf field.
  /// </summary>
  IProtobufFieldAttribute = interface(IInterface)
    /// <summary>
    /// Getter for <see cref="Name"/>.
    /// </summary>
    /// <returns>The name of the protobuf field</returns>
    function GetName: String;

    /// <summary>
    /// Name of the protobuf field.
    /// </summary>
    /// <remarks>
    /// This matches the original name of the field in the protobuf schema definition, not the derived name of the corresponding Delphi property.
    /// </remarks>
    property Name: String read GetName;

    /// <summary>
    /// Getter for <see cref="Number"/>.
    /// </summary>
    /// <returns>The field number of the protobuf field</returns>
    function GetNumber: TProtobufFieldNumber;

    /// <summary>
    /// Field number of the protobuf field.
    /// </summary>
    property Number: TProtobufFieldNumber read GetNumber;
  end;

implementation

end.
