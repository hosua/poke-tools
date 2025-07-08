local pv_addr = 0x0202402C
local iv_addr = 0x02024074

local overlay = console:createBuffer("iv-peeker")

    
-- converts pokemon's proprietary char set to standard ASCII
function convertNameToAscii(byteArr)
    local charMap = {
        [0xA0] = "ʳᵉ", [0xA1] = "0", [0xA2] = "1", [0xA3] = "2", [0xA4] = "3", [0xA5] = "4", [0xA6] = "5", [0xA7] = "6", [0xA8] = "7", [0xA9] = "8", [0xAA] = "9", [0xAB] = "!", [0xAC] = "?", [0xAD] = ".", [0xAE] = "-", [0xAF] = "･",
        [0xB0] = "‥", [0xB1] = "“", [0xB2] = "”", [0xB3] = "‘", [0xB4] = "'", [0xB5] = "♂", [0xB6] = "♀", [0xB7] = "$", [0xB8] = ",", [0xB9] = "×", [0xBA] = "/", [0xBB] = "A", [0xBC] = "B", [0xBD] = "C", [0xBE] = "D", [0xBF] = "E",
        [0xC0] = "F", [0xC1] = "G", [0xC2] = "H", [0xC3] = "I", [0xC4] = "J", [0xC5] = "K", [0xC6] = "L", [0xC7] = "M", [0xC8] = "N", [0xC9] = "O", [0xCA] = "P", [0xCB] = "Q", [0xCC] = "R", [0xCD] = "S", [0xCE] = "T", [0xCF] = "U",
        [0xD0] = "V", [0xD1]  = "W", [0xD2] = "X", [0xD3] = "Y", [0xD4] = "Z", [0xD5] = "a", [0xD6] = "b", [0xD7] = "c", [0xD8] = "d", [0xD9] = "e", [0xDA] = "f", [0xDB] = "g", [0xDC] = "h", [0xDD] = "i", [0xDE] = "j", [0xDF] = "k",
        [0xE0] = "l", [0xE1] = "m", [0xE2] = "n", [0xE3] = "o", [0xE4] = "p", [0xE5] = "q", [0xE6] = "r",  [0xE7] = "s", [0xE8] = "t", [0xE9] = "u", [0xEA] = "v", [0xEB] = "w", [0xEC] = "x", [0xED] = "y", [0xEF] = "z", [0xEF] = "►",
        [0xF0] = ":", [0xF1] = "Ä", [0xF2] = "Ö", [0xF3] = "Ü", [0xF4] = "ä", [0xF5] = "ö", [0xF6] = "ü", [0xF8] = "", [0xF9] = "", [0xFA] = "",  [0xFB] = "", [0xFC] = "", [0xFD] = "", [0xFF] = "",
    }

    local result = {}
    for _, byte in ipairs(byteArr) do
        local char = charMap[byte]
        if (char == nil) then
            break;
        end
        table.insert(result, char)
    end
    return table.concat(result)
end

function onFrame()
    local pv = emu:read32(pv_addr)
    local iv_data = emu:read32(iv_addr)
    local hp = iv_data & 0x1F
    local atk = (iv_data >> 5) & 0x1F
    local def = (iv_data >> 10) & 0x1F
    local speed = (iv_data >> 15) & 0x1F
    local spatk = (iv_data >> 20) & 0x1F
    local spdef = (iv_data >> 25) & 0x1F

    local name1 = emu:read32(0x02024034);
    local name2 = emu:read32(0x02024038);
    local name3 = emu:read16(0x0202403C);
    local nameBytes = {
        name1 & 0xFF,
        (name1 >> 8) & 0xFF,
        (name1 >> 16) & 0xFF,
        (name1 >> 24) & 0xFF,
        name2 & 0xFF,
        (name2 >> 8) & 0xFF,
        (name2 >> 16) & 0xFF,
        (name2 >> 24) & 0xFF,
        name3 & 0xFF,
        (name3 >> 8) & 0xFF,
    }
    local name = convertNameToAscii(nameBytes);

    overlay:clear()
    overlay:moveCursor(0, 0)
    overlay:print("----------------------------------------\n")
    overlay:print(string.format("%s\n", name));
    overlay:print(string.format("Personality Value (PV): 0x%8X\n", pv))
    overlay:print(string.format("HP: %i\n", hp))
    overlay:print(string.format("Attack: %i\n", atk))
    overlay:print(string.format("Defense: %i\n", def))
    overlay:print(string.format("Speed: %i\n", speed))
    overlay:print(string.format("Sp. Attack: %i\n", spatk))
    overlay:print(string.format("Sp. Defense: %i\n", spdef))
end

callbacks:add("frame", onFrame)
