;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _joypad
	.globl _delay
	.globl _WindowMap
	.globl _Map
	.globl _MapTiles
	.globl _sprite_palette
	.globl _background_palette
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_MapTiles::
	.ds 112
_Map::
	.ds 360
_WindowMap::
	.ds 5
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:21: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:24: NR52_REG = 0x80; //turn on sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:25: NR50_REG = 0x77; set_bkg_palette(0,1,&background_palette[0]);// set volumes for 4 channels
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
	ld	de, #_background_palette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;main.c:26: NR51_REG = 0xFF; // designate all channels for use
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:30: font_init();
	call	_font_init
;main.c:31: min_font = font_load(font_min); //36 tiles
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
;main.c:32: font_set(min_font);
	push	de
	call	_font_set
	pop	hl
;main.c:34: set_bkg_palette(0,1,&background_palette[0]);
	ld	de, #_background_palette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;main.c:36: set_bkg_data(37, 7, MapTiles); // starting at 37 because font shares first 36 slots of video memory
	ld	de, #_MapTiles
	push	de
	ld	hl, #0x725
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:37: set_bkg_tiles(0,0,20,18, Map);
	ld	de, #_Map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:38: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:39: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:41: set_sprite_palette(0,1,&sprite_palette[0]);
	ld	de, #_sprite_palette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_palette
	add	sp, #4
;main.c:45: set_sprite_data(0,2,Player);
	ld	de, #_Player
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;main.c:48: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:50: set_win_tiles(0,0,5,1,WindowMap);
	ld	de, #_WindowMap
	push	de
	ld	hl, #0x105
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;c:/gbdk/include/gb/gb.h:1468: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;main.c:52: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;main.c:54: while(1){
00108$:
;main.c:65: switch(joypad()){
	call	_joypad
	ld	c, a
	dec	a
	jr	Z, 00104$
	ld	a,c
	cp	a,#0x02
	jr	Z, 00103$
	cp	a,#0x04
	jr	Z, 00101$
	cp	a,#0x08
	jr	Z, 00102$
	sub	a, #0x40
	jr	Z, 00105$
	jr	00106$
;main.c:66: case J_UP:
00101$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0xfe
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:68: break;
	jr	00106$
;main.c:70: case J_DOWN:
00102$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0x02
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:72: break;
	jr	00106$
;main.c:74: case J_LEFT:
00103$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0xfe
	ld	(bc), a
;main.c:76: break;
	jr	00106$
;main.c:78: case J_RIGHT:
00104$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0x02
	ld	(bc), a
;main.c:80: break;
	jr	00106$
;main.c:82: case J_SELECT:
00105$:
;main.c:91: NR10_REG = 0x16; 
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;main.c:98: NR11_REG = 0x4E;
	ld	a, #0x4e
	ldh	(_NR11_REG + 0), a
;main.c:107: NR12_REG = 0x73;  
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;main.c:112: NR13_REG = 0x00;   
	xor	a, a
	ldh	(_NR13_REG + 0), a
;main.c:121: NR14_REG = 0xC5;
	ld	a, #0xc5
	ldh	(_NR14_REG + 0), a
;main.c:125: }
00106$:
;main.c:127: delay(25);
	ld	de, #0x0019
	call	_delay
;main.c:129: }
	jr	00108$
_background_palette:
	.dw #0x7c00
	.dw #0x3c00
	.dw #0x01ef
	.dw #0x0000
_sprite_palette:
	.dw #0x17bc
	.dw #0x3dff
	.dw #0x001f
	.dw #0x000f
	.area _CODE
	.area _INITIALIZER
__xinit__MapTiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x20	; 32
	.db #0xdf	; 223
	.db #0x20	; 32
	.db #0xdf	; 223
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0x08	; 8
	.db #0xf7	; 247
	.db #0x08	; 8
	.db #0xf7	; 247
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x16	; 22
	.db #0xe9	; 233
	.db #0xb3	; 179
	.db #0x4c	; 76	'L'
	.db #0x9b	; 155
	.db #0x64	; 100	'd'
	.db #0x0a	; 10
	.db #0xf5	; 245
	.db #0x61	; 97	'a'
	.db #0x9e	; 158
	.db #0xed	; 237
	.db #0x12	; 18
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0xb1	; 177
	.db #0x4e	; 78	'N'
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x2f	; 47
	.db #0xd0	; 208
	.db #0x27	; 39
	.db #0xd8	; 216
	.db #0x25	; 37
	.db #0xda	; 218
	.db #0x25	; 37
	.db #0xda	; 218
	.db #0x27	; 39
	.db #0xd8	; 216
	.db #0x2f	; 47
	.db #0xd0	; 208
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x20	; 32
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0xab	; 171
	.db #0x54	; 84	'T'
	.db #0xab	; 171
	.db #0x54	; 84	'T'
	.db #0xbb	; 187
	.db #0x44	; 68	'D'
	.db #0xc7	; 199
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x02	; 2
	.db #0xcf	; 207
	.db #0x30	; 48	'0'
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xdd	; 221
	.db #0x22	; 34
	.db #0xe3	; 227
	.db #0x1c	; 28
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x9f	; 159
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__Map:
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x2a	; 42
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
__xinit__WindowMap:
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.area _CABS (ABS)
