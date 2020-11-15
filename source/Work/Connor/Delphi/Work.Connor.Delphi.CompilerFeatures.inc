/// Copyright 2020 Connor Roehricht (connor.work)
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

/// Defines compiler directives that signal if specific Delphi (or similar Object Pascal dialect) language features are supported by the current compiler
/// Shall be used by code in the Work.Connor namespace

/// Added compiler directives (defined if feature is supported):
/// WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES  | The compiler supports unit scope names
/// WORK_CONNOR_DELPHI_COMPILER_CUSTOM_ATTRIBUTES | The compiler supports custom RTTI attributes

{$IFDEF DCC}
  {$IFDEF VER330}
    {$DEFINE WORK_CONNOR_DELPHI_COMPILER_SUPPORTED}
    {$DEFINE WORK_CONNOR_DELPHI_COMPILER_UNIT_SCOPE_NAMES}
    {$DEFINE WORK_CONNOR_DELPHI_COMPILER_CUSTOM_ATTRIBUTES}
  {$ENDIF}  
{$ENDIF}

{$IFDEF FPC}
  {$IFDEF VER3_2_0}
    {$DEFINE WORK_CONNOR_DELPHI_COMPILER_SUPPORTED}
  {$ENDIF}
{$ENDIF}

{$IFNDEF WORK_CONNOR_DELPHI_COMPILER_SUPPORTED}
  {$MESSAGE Fatal 'Unsupported compiler for source code in the Work.Connor namespace'}
{$ENDIF}
