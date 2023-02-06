;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;                BOILERPLATE
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION "Boilerplate",ROM0
GAME_NAME EQUS "DYLAN'S GAMEBOY" 
ROM_SIZE EQU 1 
RAM_SIZE EQU 1
GBC_SUPPORT EQU 1
; has to go above gingerbread include
INCLUDE "gingerbread.asm"
INCLUDE "image.inc"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;                  MACROS
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION "Macros",ROM0
MACRO CopyRegionToVRAM   
X = 0
    REPT \1 ; \1 = number repetitions
    ld bc, \2 ; \2 = number rows
    ld hl, \3+(X*\2) ; \3 = number columns
    ld de, \4+(X*32) ; \4 = address of start of "map data"
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;      OBJECT ATTRIBUTE MEMORY VARIABLES
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION "OAM Vars",WRAM0[$C100]
    player_sprite: DS 4 ; assign 4 bytes with <-- name in OAM




SECTION "Text definitions",ROM0 
; Charmap definition (based on the hello_world.png image, and looking in the VRAM viewer after loading it in BGB helps finding the values for each character)
CHARMAP "0",$09
CHARMAP "1",$0A
CHARMAP "2",$0B
CHARMAP "3",$0C
CHARMAP "4",$0D
CHARMAP "5",$0E
CHARMAP "6",$0F
CHARMAP "7",$10
CHARMAP "8",$11
CHARMAP "9",$12

CHARMAP "A",$13
CHARMAP "B",$14
CHARMAP "C",$15
CHARMAP "D",$16
CHARMAP "E",$17
CHARMAP "F",$18
CHARMAP "G",$19
CHARMAP "H",$1A
CHARMAP "I",$1B
CHARMAP "J",$1C
CHARMAP "K",$1D
CHARMAP "L",$1E
CHARMAP "M",$1F
CHARMAP "N",$20
CHARMAP "P",$21
CHARMAP "Q",$22
CHARMAP "R",$23
CHARMAP "S",$24
CHARMAP "T",$25
CHARMAP "U",$26
CHARMAP "V",$27
CHARMAP "W",$28
CHARMAP "X",$29
CHARMAP "Y",$2A
CHARMAP "Z",$2B

CHARMAP "!",$2C
CHARMAP "?",$2D
CHARMAP "\"",$2E
CHARMAP ".",$2F
CHARMAP ",",$30
CHARMAP "(",$31
CHARMAP ")",$32
CHARMAP ":",$33
CHARMAP ";",$34
CHARMAP "=",$35
CHARMAP "+",$36
CHARMAP "-",$37
CHARMAP "/",$38
CHARMAP "%",$39

CHARMAP "<end>",$00 ; Choose some non-character tile that's easy to remember 
    
SomeText:
DB "0123<end>"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;                  SETUP
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION "Game Code",ROM0 
begin: ; needed for gingerbread
SetupGBC: ;needed for gbc in gingerbread
    GBCEarlyExit ; exit if not on GBC

    ; sprite (object) 1 : player
    ld a, $30               ; load value
    ld [player_sprite], a   ; write x
    ld a, $30               ; load value
    ld [player_sprite+1], a ; write y
    ld a, 4                 ; load value
    ld [player_sprite+2], a ; write tile number

    ; set gbc background palettes
    ld hl , GBCBackgroundPalettes
    xor a ; Start at color 0 , palette 0
    ld b , 64 ; We have 16 bytes to write
    call GBCApplyBackgroundPalettes

    ; set gbc sprite palettes
    ld hl , GBCSpritePalettes
    xor a ; Start at color 0 , palette 0
    ld b , 64 ; We have 16 bytes to write
    call GBCApplySpritePalettes

    ; set registers for display routines
    ld hl, image_tile_data ;source
    ld de, TILEDATA_START  ;dest
    ld bc, image_tile_data_size

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;                   MAIN
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main:
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;              DISPLAY
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    

    ; all display code needs to happen between here (start)...
    call mCopyVRAM

    ; "when you switch the vram bank" you can write to the correct area for palette map
    ld a , 1
    ld [ GBC_VRAM_BANK_SWITCH ] , a
    CopyRegionToVRAM 18,20,GBCPaletteMap,BACKGROUND_MAPDATA_START
    ; "... then switch back"
    xor a
    ld [ GBC_VRAM_BANK_SWITCH ] , a

    ; "... and write the regular tile data to vram"
    CopyRegionToVRAM 18 , 20 , image_map_data ,BACKGROUND_MAPDATA_START

    ld b, $00 ; end character 
    ld c, 0 ; draw to background
    ld d, 4 ; X start position (0-19)
    ld e, 8 ; Y start position (0-17)
    ld hl, SomeText ; text to write 
    call RenderTextToEnd

    ; ... and here (end) -- for some reason
    call StartLCD
  
    
  

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;           INPUT CHECK
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    ; UP
    call ReadKeys
    and KEY_UP
    jp nz, input_up
    ; LEFT
    call ReadKeys
    and KEY_LEFT
    jp nz, input_left
    ; DOWN
    call ReadKeys
    and KEY_DOWN
    jp nz, input_down
    ; RIGHT
    call ReadKeys
    and KEY_RIGHT
    jp nz, input_right

    ; end of input check (LOOP)
    jp z, main


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;             INPUT RESPONSE
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; input response
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