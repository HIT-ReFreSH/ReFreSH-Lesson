$contents = Get-ChildItem .\CSharp
if (-Not (Test-Path tex/csharp)) {
    New-Item tex/csharp -ItemType "directory"
}
else {
    Remove-Item tex -Recurse
    New-Item tex/csharp -ItemType "directory"
}
foreach ($content in $contents) {
    pandoc $content -o "tex/csharp/$($content.Name.Replace(".md", ".tex"))"
}