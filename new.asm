SECTION "Boilerplate",ROM0

GAME_NAME EQUS "DYLAN'S GAMEBOY" 
ROM_SIZE EQU 1 
RAM_SIZE EQU 1
;GBC_SUPPORT EQU 1
; has to go above gingerbread include

INCLUDE "gingerbread.asm"
INCLUDE "image.inc"

SECTION "Macros",ROM0 

MACRO DontOverdraw ; \1 = number repetitions \2 = number rows \3 = number columns \4 = address of start of "map data"
X = 0
REPT \1
ld bc, \2
ld hl, \3+(X*\2)
ld de, \4+(X*32)
call mCopyVRAM
X = X+1
ENDR
ENDM

MACRO dbg
ld  d, d
jr .end\@
DW $6464
DW $0000
DB \1
.end\@:
ENDM

SECTION "Game Code",ROM0    
begin:

    ; define params for func call
    ld hl, image_tile_data ;source
    ld de, TILEDATA_START  ;dest
    ld bc, image_tile_data_size

    ld a, $30
    ld [player_sprite], a
    ld a, $30
    ld [player_sprite+1], a
    ld a, 4
    ld [player_sprite+2], a


main:
    
;DRAW
    call mCopyVRAM
    DontOverdraw 18, 20, image_map_data, BACKGROUND_MAPDATA_START
    call StartLCD    

;READ INPUT

    ; START
    call ReadKeys
    and KEY_START
    jp nz, input_start

    ; SELECT
    call ReadKeys
    and KEY_SELECT
    jp nz, input_select

    ; B
    call ReadKeys
    and KEY_B
    jp nz, input_b

    ; A
    call ReadKeys
    and KEY_A
    jp nz, input_a

    ; up
    call ReadKeys
    and KEY_UP
    jp nz, input_up

    ; left
    call ReadKeys
    and KEY_LEFT
    jp nz, input_left

    ; down
    call ReadKeys
    and KEY_DOWN
    jp nz, input_down

    ; right
    call ReadKeys
    and KEY_RIGHT
    jp nz, input_right

    
    ; end of input check
    jp z, main

; INPUT RESPONSE
input_start:
    dbg "pressed Start"
    xor a
    jp main

input_select:
    dbg "pressed Select"
    xor a
    jp main

input_b:
    dbg "pressed B"
    ld a, 4
    ld [player_sprite+2], a
    xor a
    jp main

input_a:
    dbg "pressed A"
    ld a, 7
    ld [player_sprite+2], a
    xor a
    jp main

input_up:
    dbg "pressed up"
    ld a, [player_sprite]
    dec a
    ld [player_sprite], a
    xor a
    jp main

input_down:
    dbg "pressed down"
    ld a, [player_sprite]
    inc a
    ld [player_sprite], a
    xor a
    jp main

input_left:
    dbg "pressed left"
    ld a, [player_sprite+1]
    dec a
    ld [player_sprite+1], a 
    xor a
    jp main

input_right:
    dbg "pressed right"
    ld a, [player_sprite+1]
    inc a
    ld [player_sprite+1], a 
    xor a
    jp main

SECTION "OAM Vars",WRAM0[$C100]
player_sprite: DS 4