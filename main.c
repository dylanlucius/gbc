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
    NR50_REG = 0x77; set_bkg_palette(0,1,&background_palette[0]);// set volumes for 4 channels
    NR51_REG = 0xFF; // designate all channels for use

    // set up font for window
    font_t min_font;
    font_init();
    min_font = font_load(font_min); //36 tiles
    font_set(min_font);

    set_bkg_palette(0,1,&background_palette[0]);
    // set up background
    set_bkg_data(37, 7, MapTiles); // starting at 37 because font shares first 36 slots of video memory
    set_bkg_tiles(0,0,20,18, Map);
    SHOW_BKG;
    DISPLAY_ON;

    set_sprite_palette(0,1,&sprite_palette[0]);
    //set_sprite_prop(0,1); // (select sprite, which palette to use)
    // set up sprites
    UINT8 current_sprite_index = 0;
    set_sprite_data(0,2,Player);
    set_sprite_tile(0,0);
    move_sprite(0,88,78);
    SHOW_SPRITES;

    set_win_tiles(0,0,5,1,WindowMap);
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


        // chanel 1 register 0, Frequency sweep settings
            // 7	Unused
            // 6-4	Sweep time(update rate) (if 0, sweeping is off)
            // 3	Sweep Direction (1: decrease, 0: increase)
            // 2-0	Sweep RtShift amount (if 0, sweeping is off)
            // 0001 0110 is 0x16, sweet time 1, sweep direction increase, shift ammount per step 110 (6 decimal)
            NR10_REG = 0x16; 

            // chanel 1 register 1: Wave pattern duty and sound length
            // Channels 1 2 and 4
            // 7-6	Wave pattern duty cycle 0-3 (12.5%, 25%, 50%, 75%), duty cycle is how long a quadrangular  wave is "on" vs "of" so 50% (2) is both equal.
            // 5-0 sound length (higher the number shorter the sound)
            // 01000000 is 0x40, duty cycle 1 (25%), wave length 0 (long)
            NR11_REG = 0x4E;

            // chanel 1 register 2: Volume Envelope (Makes the volume get louder or quieter each "tick")
            // On Channels 1 2 and 4
            // 7-4	(Initial) Channel Volume
            // 3	Volume sweep direction (0: down; 1: up)
            // 2-0	Length of each step in sweep (if 0, sweeping is off)
            // NOTE: each step is n/64 seconds long, where n is 1-7	
            // 0111 0011 is 0x73, volume 7, sweep down, step length 3
            NR12_REG = 0x73;  

            // chanel 1 register 3: Frequency LSbs (Least Significant bits) and noise options
            // for Channels 1 2 and 3
            // 7-0	8 Least Significant bits of frequency (3 Most Significant Bits are set in register 4)
            NR13_REG = 0x00;   

            // chanel 1 register 4: Playback and frequency MSbs
            // Channels 1 2 3 and 4
            // 7	Initialize (trigger channel start, AKA channel INIT) (Write only)
            // 6	Consecutive select/length counter enable (Read/Write). When "0", regardless of the length of data on the NR11 register, sound can be produced consecutively.  When "1", sound is generated during the time period set by the length data contained in register NR11.  After the sound is ouput, the Sound 1 ON flag, at bit 0 of register NR52 is reset.
            // 5-3	Unused
            // 2-0	3 Most Significant bits of frequency
            // 1100 0011 is 0xC3, initialize, no consecutive, frequency = MSB + LSB = 011 0000 0000 = 0x300
            NR14_REG = 0xC5;

            break;

        }

        delay(25);
    }
}