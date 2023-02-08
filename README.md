GBC v0.2.33 ©2023 Software Toy

**Directory Structure:**
### **1. git:**
    .git
    .gitignore

### **2. actual ROM file**
    gbc.gb

### **3. build script**
    build.bat

### **4. main source code file**
    main.c

### **5. background image and map data**
    MapTiles.c          | background image data
    MapTiles.h          |       (additional defs)
    Map.c               | map applies data to background
    Map.h               |       (additional defs)

### **6. sprite image data**
    Player.c            | sprite image data
    Player.h            | sprite color palette data

### **7. window map data**
    WindowMap.c         | maps tiles to window

### **8. (hUGEDriver dependencies)**
    include/            | binary files for hUGEDriver
    obj/                | contains lib for hUGEDriver
    song/               | contains song file inside of
                        | another directory 'C/'
    tools/              | rgbasm and rgb2sdas (for hUGEDriver)

    hUGEDriver.asm      | the actual hUGEDriver code
    hUGEDriver.h        | definitions for .asm file

    ** all of these are part of the hUGEDriver 'directory structure' that this project uses. it's this way until further notice
