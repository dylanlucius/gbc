image_tile_map_size EQU 320
image_tile_map_width EQU 20
image_tile_map_height EQU 18

image_tile_data_size EQU $90
image_tile_count EQU 9

image_tile_data:

; blank 0
DB %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000

; top left pixel 1
DB %1111_1111,\
   %1111_1111,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000

; bottom right pixel 2
DB %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0000,\
   %0000_0000,\
   \
   %0000_0001,\
   %0000_0001

DB $11,$11,$39,$39,$7D,$7D,$B2,$B2,$B0,$B0,$18,$18,$24,$24,$44,$44 ; 8x8 person 3
DB $18,$18,$18,$18,$3C,$3C,$7E,$7E,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD ; 8x16 person 4, 5
DB $BD,$BD,$7E,$7E,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
DB $00,$00,$18,$18,$5A,$5A,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD,$BD ; jumping 8x16 person 6,7
DB $3C,$3C,$24,$24,$42,$42,$42,$42,$24,$24,$24,$24,$00,$00,$00,$00
DB $00,$FF,$7F,$80,$67,$80,$43,$80,$43,$80,$67,$80,$7F,$80,$7F,$80 ; med-crate 8

image_map_data:
   DB 08,08,08,08,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 08,08,08,08,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 08,08,08,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00
   DB 00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00,  00,00,00,00

GBCPaletteMap :
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 2 ,2 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
   DB 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0

GBCBackgroundPalettes:
   ; green
   DB %11111111 ; Color 0 , palette 0 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 0 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 0 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 0 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 0 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 0 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 0 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 0 , %0 bbbbbgg

   ; red
   DB %11111111 ; Color 0 , palette 1 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 1 , %0 bbbbbgg
   DB %00011111 ; Color 1 , palette 1 , % gggrrrrr
   DB %00000000 ; Color 1 , palette 1 , %0 bbbbbgg
   DB %00011111 ; Color 2 , palette 1 , % gggrrrrr
   DB %00100000 ; Color 2 , palette 1 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 1 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 1 , %0 bbbbbgg

   ; blue
   DB %11111111 ; Color 0 , palette 2 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 2 , %0 bbbbbgg
   DB %00000000 ; Color 1 , palette 2 , % gggrrrrr
   DB %01111100 ; Color 1 , palette 2 , %0 bbbbbgg
   DB %00001000 ; Color 2 , palette 2 , % gggrrrrr
   DB %01111111 ; Color 2 , palette 2 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 2 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 2 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 3 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 3 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 3 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 3 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 3 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 3 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 3 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 3 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 4 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 4 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 4 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 4 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 4 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 4 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 4 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 4 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 5 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 5 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 5 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 5 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 5 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 5 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 5 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 5 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 6 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 6 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 6 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 6 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 6 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 6 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 6 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 6 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 7 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 7 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 7 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 7 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 7 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 7 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 7 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 7 , %0 bbbbbgg

GBCSpritePalettes:
   DB %11111111 ; Color 0 , palette 0 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 0 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 0 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 0 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 0 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 0 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 0 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 0 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 1 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 1 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 1 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 1 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 1 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 1 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 1 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 1 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 2 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 2 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 2 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 2 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 2 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 2 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 2 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 2 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 3 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 3 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 3 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 3 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 3 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 3 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 3 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 3 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 4 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 4 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 4 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 4 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 4 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 4 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 4 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 4 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 5 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 5 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 5 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 5 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 5 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 5 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 5 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 5 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 6 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 6 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 6 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 6 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 6 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 6 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 6 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 6 , %0 bbbbbgg

   DB %11111111 ; Color 0 , palette 7 , % gggrrrrr
   DB %01111111 ; Color 0 , palette 7 , %0 bbbbbgg
   DB %11100011 ; Color 1 , palette 7 , % gggrrrrr
   DB %00011111 ; Color 1 , palette 7 , %0 bbbbbgg
   DB %11100001 ; Color 2 , palette 7 , % gggrrrrr
   DB %00001001 ; Color 2 , palette 7 , %0 bbbbbgg
   DB %00000000 ; Color 3 , palette 7 , % gggrrrrr
   DB %00000000 ; Color 3 , palette 7 , %0 bbbbbgg