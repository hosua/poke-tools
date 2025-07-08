local pv_addr = 0x0202402C
local iv_addr = 0x02024074
local name_addr = 0x02024034

local buffer = console:createBuffer("iv-peeker")

KEY_R = 1 << 8
KEY_B = 1 << 1

PARTY_FIRST_PV = 0x02024284
PARTY_FIRST_OTID = 0x02024288
PARTY_FIRST_NAME = 0x0202428C
PARTY_FIRST_IV = 0x020242CC
PKMN_DS_SIZE = 100

OFFSETS = {
    {
        description = "OPPONENT",
        pv_addr = 0x0202402C,
        otid_addr = 0x2024030,
        iv_addr = 0x02024074,
        name_addr = 0x02024034,
    },
    {
        description = "PARTY #1",
        pv_addr = PARTY_FIRST_PV,
        otid_addr = PARTY_FIRST_OTID,
        iv_addr = PARTY_FIRST_IV,
        name_addr = PARTY_FIRST_NAME,
    },
    {
        description = "PARTY #2",
        pv_addr = PARTY_FIRST_PV + PKMN_DS_SIZE * 1,
        otid_addr = PARTY_FIRST_OTID + PKMN_DS_SIZE * 1,
        iv_addr = PARTY_FIRST_IV + PKMN_DS_SIZE * 1,
        name_addr = PARTY_FIRST_NAME + PKMN_DS_SIZE * 1,
    },
    {
        description = "PARTY #3",
        pv_addr = PARTY_FIRST_PV + PKMN_DS_SIZE * 2,
        otid_addr = PARTY_FIRST_OTID + PKMN_DS_SIZE * 2,
        iv_addr = PARTY_FIRST_IV + PKMN_DS_SIZE * 2,
        name_addr = PARTY_FIRST_NAME + PKMN_DS_SIZE * 2,
    },
    {
        description = "PARTY #4",
        pv_addr = PARTY_FIRST_PV + PKMN_DS_SIZE * 3,
        otid_addr = PARTY_FIRST_OTID + PKMN_DS_SIZE * 3,
        iv_addr = PARTY_FIRST_IV + PKMN_DS_SIZE * 3,
        name_addr = PARTY_FIRST_NAME + PKMN_DS_SIZE * 3,
    },
    {
        description = "PARTY #5",
        pv_addr = PARTY_FIRST_PV + PKMN_DS_SIZE * 4,
        otid_addr = PARTY_FIRST_OTID + PKMN_DS_SIZE * 4,
        iv_addr = PARTY_FIRST_IV + PKMN_DS_SIZE * 4,
        name_addr = PARTY_FIRST_NAME + PKMN_DS_SIZE * 4,
    },
    {
        description = "PARTY #6",
        pv_addr = PARTY_FIRST_PV + PKMN_DS_SIZE * 5,
        otid_addr = PARTY_FIRST_OTID + PKMN_DS_SIZE * 5,
        iv_addr = PARTY_FIRST_IV + PKMN_DS_SIZE * 5,
        name_addr = PARTY_FIRST_NAME + PKMN_DS_SIZE * 5,
    },
}

local natureMap = {
  [0] = "Hardy",
  [1] = "Lonely",
  [2] = "Brave",
  [3] = "Adamant",
  [4] = "Naughty",
  [5] = "Bold",
  [6] = "Docile",
  [7] = "Relaxed",
  [8] = "Impish",
  [9] = "Lax",
  [10] = "Timid",
  [11] = "Hasty",
  [12] = "Serious",
  [13] = "Jolly",
  [14] = "Naive",
  [15] = "Modest",
  [16] = "Mild",
  [17] = "Quiet",
  [18] = "Bashful",
  [19] = "Rash",
  [20] = "Calm",
  [21] = "Gentle",
  [22] = "Sassy",
  [23] = "Careful",
  [24] = "Quirky",
}

local charMap = {
    [0xA0] = "ʳᵉ", [0xA1] = "0", [0xA2] = "1", [0xA3] = "2", [0xA4] = "3", [0xA5] = "4", [0xA6] = "5", [0xA7] = "6", [0xA8] = "7", [0xA9] = "8", [0xAA] = "9", [0xAB] = "!", [0xAC] = "?", [0xAD] = ".", [0xAE] = "-", [0xAF] = "･",
    [0xB0] = "‥", [0xB1] = "“", [0xB2] = "”", [0xB3] = "‘", [0xB4] = "'", [0xB5] = "♂", [0xB6] = "♀", [0xB7] = "$", [0xB8] = ",", [0xB9] = "×", [0xBA] = "/", [0xBB] = "A", [0xBC] = "B", [0xBD] = "C", [0xBE] = "D", [0xBF] = "E",
    [0xC0] = "F", [0xC1] = "G", [0xC2] = "H", [0xC3] = "I", [0xC4] = "J", [0xC5] = "K", [0xC6] = "L", [0xC7] = "M", [0xC8] = "N", [0xC9] = "O", [0xCA] = "P", [0xCB] = "Q", [0xCC] = "R", [0xCD] = "S", [0xCE] = "T", [0xCF] = "U",
    [0xD0] = "V", [0xD1]  = "W", [0xD2] = "X", [0xD3] = "Y", [0xD4] = "Z", [0xD5] = "a", [0xD6] = "b", [0xD7] = "c", [0xD8] = "d", [0xD9] = "e", [0xDA] = "f", [0xDB] = "g", [0xDC] = "h", [0xDD] = "i", [0xDE] = "j", [0xDF] = "k",
    [0xE0] = "l", [0xE1] = "m", [0xE2] = "n", [0xE3] = "o", [0xE4] = "p", [0xE5] = "q", [0xE6] = "r",  [0xE7] = "s", [0xE8] = "t", [0xE9] = "u", [0xEA] = "v", [0xEB] = "w", [0xEC] = "x", [0xED] = "y", [0xEF] = "z", [0xEF] = "►",
    [0xF0] = ":", [0xF1] = "Ä", [0xF2] = "Ö", [0xF3] = "Ü", [0xF4] = "ä", [0xF5] = "ö", [0xF6] = "ü", [0xF8] = "", [0xF9] = "", [0xFA] = "",  [0xFB] = "", [0xFC] = "", [0xFD] = "", [0xFF] = "",
}

-- converts pokemon's proprietary char set to standard ASCII
function ConvertNameToAscii(byteArr)
    local result = {}
    for _, byte in ipairs(byteArr) do
        local ch = charMap[byte]
        if (ch == nil) then
            break;
        end
        table.insert(result, ch)
    end
    return table.concat(result)
end

local frame = 0
local interval = 15
local selected = 1
local prev_key_mask = 0

function OnFrame()
    frame = frame + 1

    local keys = emu:getKeys()
    if (keys & KEY_B ~= 0 and prev_key_mask & KEY_B == 0) then
        selected = (selected % 7) + 1
    end

    prev_key_mask = keys

    local selected_pv_addr = OFFSETS[selected].pv_addr
    local selected_otid_addr = OFFSETS[selected].otid_addr
    local selected_iv_addr = OFFSETS[selected].iv_addr
    local selected_name_addr = OFFSETS[selected].name_addr

    if (frame % interval == 0) then
        local tid = emu:read16(selected_otid_addr)
        local sid = emu:read16(selected_otid_addr + 2)
        local pv_lo = emu:read16(selected_pv_addr)
        local pv_hi = emu:read16(selected_pv_addr + 2)
        
        -- this threshold is may not be 16 when:
        -- 1. shiny chaining
        -- 2. breeding with non-OT pokemon (masuda method, e.g. breeding with perfect ditto)
        -- 3. the user posseses the shiny charm
        -- Further testing needs to be done here.
        local is_shiny = (tid ~ sid ~ pv_lo ~ pv_hi) < 16
        local shiny_str = (is_shiny and "***SHINY***" or "")

        local pv = emu:read32(selected_pv_addr)
        local nature = natureMap[pv % 25]
        local iv_data = emu:read32(selected_iv_addr)
        local hp = iv_data & 0x1F
        local atk = (iv_data >> 5) & 0x1F
        local def = (iv_data >> 10) & 0x1F
        local speed = (iv_data >> 15) & 0x1F
        local spatk = (iv_data >> 20) & 0x1F
        local spdef = (iv_data >> 25) & 0x1F

        local n1 = emu:read32(selected_name_addr);
        local n2 = emu:read32(selected_name_addr + 4);
        local n3 = emu:read16(selected_name_addr + 8);
        local nameBytes = {
            n1 & 0xFF,
            (n1 >> 8) & 0xFF,
            (n1 >> 16) & 0xFF,
            (n1 >> 24) & 0xFF,
            n2 & 0xFF,
            (n2 >> 8) & 0xFF,
            (n2 >> 16) & 0xFF,
            (n2 >> 24) & 0xFF,
            n3 & 0xFF,
            (n3 >> 8) & 0xFF,
        }
        local name = ConvertNameToAscii(nameBytes);

        buffer:clear()
        buffer:moveCursor(0, 0)
        buffer:print("----------------------------------------\n")
        buffer:print(string.format("%s\n", OFFSETS[selected].description));
        buffer:print(string.format("%s %s\n", name, shiny_str));
        buffer:print(string.format("Personality Value (PV): 0x%08X\n", pv))
        buffer:print(string.format("Nature: %s\n\n", nature));
        buffer:print(string.format("HP: %i\n", hp))
        buffer:print(string.format("Attack: %i\n", atk))
        buffer:print(string.format("Defense: %i\n", def))
        buffer:print(string.format("Speed: %i\n", speed))
        buffer:print(string.format("Sp. Attack: %i\n", spatk))
        buffer:print(string.format("Sp. Defense: %i\n", spdef))

        -- buffer:print(string.format("Keys 0x%8X\n", keys))
    end
end

callbacks:add("frame", OnFrame)
