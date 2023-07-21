$files = Get-ChildItem -Path .\* -Include *.bin

foreach ($f in $files)
{
	$bytes = [System.IO.File]::ReadAllBytes($f.Fullname)
	$header = $bytes[0..3]
	$rest = $bytes[4..($bytes.Count-5)]
	[System.IO.File]::WriteAllBytes($f.Directoryname+"\"+$f.Basename+".hdr",$header)
	[System.IO.File]::WriteAllBytes($f.Directoryname+"\"+$f.Basename+".til",$rest)
	
}
write-host "Done"