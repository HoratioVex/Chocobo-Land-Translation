// Requires:
// Atlas (https://www.romhacking.net/utilities/224/)
// Armips (https://github.com/Kingcom/armips)


// Insert Script with Atlas
.\atlas "output.gba" "choco_script_eng.txt"

// Patches with Armips
.\armips patch_line_length.asm
.\armips patches_binary.asm

// Compress and insert graphics
cd Graphics
7z x graphics_en.7z
ps_add_header
ps_insert_patch