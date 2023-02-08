#include <gb/gb.h>
#include <stdio.h>
#include "spritetiles.h"
#include "bgtiles.c"
#include "bgmap.c"
#include <gbdk/font.h>
#include "windowmap.c"
#include <gb/cgb.h>
#include "hUGEDriver.h"

extern const hUGESong_t song;

const UWORD background_palette[] = {
    RGB_BLUE, RGB_DARKBLUE, RGB_TEAL, RGB_BLACK
};

const UWORD sprite_palette[] = {
    PlayerCGBPal0c0,
    PlayerCGBPal0c1,
    PlayerCGBPal0c2,
    PlayerCGBPal0c3
};

void main(){

    // set up audio registers
    NR52_REG = 0x80; //turn on sound
    NR50_REG = 0x77; // set volumes for 4 channels
    NR51_REG = 0xFF; // designate all channels for use

    // set up font for window
    font_t min_font;
    font_init();
    min_font = font_load(font_min); //36 tiles
    font_set(min_font);

    // set up background
    set_bkg_palette(0,1,&background_palette[0]);
    set_bkg_data(37, 7, bgtiles); // starting at 37 because font shares first 36 slots of video memory
    set_bkg_tiles(0,0,20,18, Map);
    SHOW_BKG;
    DISPLAY_ON;

    // set up sprites
    set_sprite_palette(0,1,&sprite_palette[0]);
    //set_sprite_prop(0,1); // (select sprite, which palette to use)
    //UINT8 current_sprite_index = 0;
    set_sprite_data(0,2,Player);
    set_sprite_tile(0,0);
    move_sprite(0,88,78);
    SHOW_SPRITES;

    set_win_tiles(0,0,5,1,windowmap);
    move_win(7,120);
    SHOW_WIN;

    __critical {
        hUGE_init(&song);
        add_VBL(hUGE_dosound);
    }

    while(1){
        
        wait_vbl_done();

        // if(current_sprite_index == 0){
        // current_sprite_index = 1;
        // }
        // else{
        //     current_sprite_index = 0;
        // }

        // set_sprite_tile(0,current_sprite_index);

        switch(joypad()){
            case J_UP:
                scroll_sprite(0,0,-2);
                break;
            
            case J_DOWN:
                scroll_sprite(0,0,2);
                break;

            case J_LEFT:
                scroll_sprite(0,-2,0);
                break;
            
            case J_RIGHT:
                scroll_sprite(0,2,0);
                break;

            case J_SELECT:

            // play sound
                NR10_REG = 0x16; 
                NR11_REG = 0x4E;
                NR12_REG = 0x73;  
                NR13_REG = 0x00;   
                NR14_REG = 0xC5;

            break;

        }

        delay(25);
    }
}