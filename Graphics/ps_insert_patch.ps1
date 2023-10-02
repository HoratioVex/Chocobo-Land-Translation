$rompath = "..\output.gba"
$patfiles = Get-ChildItem -Path .\* -Include *.pat

$romfile = Get-Item $rompath
$filestream = $romfile.OpenWrite()

foreach ($f in $patfiles)
{
	$bytes = [System.IO.File]::ReadAllBytes($f.FullName)
	$numbytes = $bytes.Length
	$patname = $f.Basename
	$offsetstr = "0x"+$patname.Substring($patname.IndexOf('_')+1,8)
	$offset = [Int32]$offsetstr
	$limitstr = $patname.Substring($patname.IndexOf('(')+1,($patname.IndexOf(')')-1)-$patname.IndexOf('('))
	$limit = [Int32]$limitstr
	if ($numbytes -gt $limit) {
		read-host "ERROR $patname too large for reinsertion"
		continue
	}
	$filestream.Seek($offset, [System.IO.SeekOrigin]::Begin)
	$filestream.Write($bytes,0,$numbytes)
	write-host "Wrote $numbytes bytes at offset $offsetstr"
}
$filestream.Dispose()
write-host "Done"