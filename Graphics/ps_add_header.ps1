# re-add header and footer, compress
#
# .bin = uncompressed tiles
# .hdr = header separated from BIN
# .til = tiles without header and footer
# .tle = tiles without header and footer, translated
# .bne = uncompressed tiles, translated and re-headered
# .pat = compressed, ready for patch

$files = Get-ChildItem -Path .\* -Include *.tle

foreach ($f in $files)
{
	$tilesraw = [System.IO.File]::ReadAllBytes($f.FullName)
	$header = [System.IO.File]::ReadAllBytes($f.DirectoryName+"\"+$f.Basename+".hdr")
	$footer = @(0xFF,0xFF,0xFF,0xFF)
	$tiles = $f.DirectoryName+"\"+$f.Basename+".bne"
	[System.IO.File]::WriteAllBytes($tiles, $header+$tilesraw+$footer)
	$output = $f.DirectoryName+"\"+$f.BaseName+".pat"
	.\GBACrusherCL -LV $tiles -O $output
	
}
write-host "Done"