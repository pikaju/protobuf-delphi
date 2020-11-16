# Copyright 2020 Connor Roehricht (connor.work)
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Checks that all git-tracked files in the working directory have the expected end-of-line type
# The optional end-of-line type ("lf", "crlf" or "mixed") can be specified using the git attribute "expected-eol"
# Requires Powershell 7+ and Git

# Index of the working copy's <eolinfo> value in the output of git ls-files --eol
$lsFilesEolinfoWorkingIndex = 1
# Index of the file path in the output of git ls-files --eol
$lsFilesFileIndex = -1
# Pattern for working copy's <eolinfo> value in the output of git ls-files --eol
[regex] $eolinfoWorkingRegex = "w/(.+)"
# <eolinfo> values that need to be checked against expectations 
$checkedEols = "lf", "crlf", "mixed"
# Custom git-attribute specifying the expected end-of-line type
$expectedEolAttr = "expected-eol"
# Track if all files have valid end-of-line types
$allFilesValid = $true

# Determine git's <eolinfo> for all tracked files in the working directory
foreach ($line in $(git ls-files --eol) -split "\r?\n|\r")
{
    $entries = $line -split "\s+"
    # Determine file path
    $file = $entries[$lsFilesFileIndex]
    # Determine <eolinfo> for the working copy
    $workingCopyEol = $eolinfoWorkingRegex.Matches($entries[$lsFilesEolinfoWorkingIndex]).Groups[1]
    # Only some end-of-line types need to be checked
    if ($checkedEols -contains $workingCopyEol)
    {
        # Check if there is a specified expectation
        $expectedEol = ($(git check-attr $expectedEolAttr $file) -split "\s+")[-1]
        if ($expectedEol -ne "unspecified")
        {
            # If expectation is not met, detect error
            if ($expectedEol -ne $workingCopyEol)
            {
                Write-Error "${file}: Expected end-of-line type ${expectedEol}, working copy is ${workingCopyEol}"
                $allFilesValid = $false
            }
        }
    }
}

if (!$allFilesValid)
{
    throw "Some files have unexpected end-of-line types in the working copy"
}
