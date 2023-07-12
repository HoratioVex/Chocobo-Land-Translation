//Adjust line length for smaller font
//Dialog no portrait: 17 -> 26

.gba
.open "input.gba","output.gba",0x08000000 


.thumb
.org 0x08037822 ;hook for extension
	.area 0x0A
	ldr r1,=NewLineLengthDNP
	mov r15,r1

	.pool
	.endarea

.org 0x8037870
	add r0,r2,0h	;don't need to add line number again here


.org 0x087ce100 ;start of free space
	.align 4
	NewLineLengthDNP:
	mov r1,1Ah ;our line length
	mul r1,r7  ;multiplied by line number
	mov r0,r1  ;copy to r0
	add r0,r6,r0 ;copy 4 original OPs that we overwrote for the hook
	add r0,r0,r2
	ldr r3,[r0]
	add r2,r1,0
	ldr r1,=0x0803782E ;back to original
	mov r15,r1
	.pool
.close

//end file