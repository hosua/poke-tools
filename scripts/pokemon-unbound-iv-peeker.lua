-- to be used with mgba

local tables = require("pokemon-unbound-tables")

local buffer = console:createBuffer("iv-peeker")

KEY_L = 1 << 9
KEY_R = 1 << 8
KEY_B = 1 << 1
KEY_SELECT = 1 << 2

PKMN_DS_SIZE = 100

PARTY_ADDR = 0x02024284
OPPONENT_PARTY_ADDR = 0x0202402C

OFFSET_PV = 0
OFFSET_OTID = 4
OFFSET_NAME = 8
OFFSET_ITEM = 34
OFFSET_MOVES = 44
OFFSET_EV = 56
OFFSET_IV = 72

OFFSETS = {
    {
        description = "PARTY #1",
        pv_addr = PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 0,
        otid_addr = PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 0,
        iv_addr = PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 0,
        ev_addr = PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 0,
        name_addr = PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 0,
        item_addr = PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 0,
        moves_addr = PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 0,
    },
    {
        description = "PARTY #2",
        pv_addr = PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 1,
        otid_addr = PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 1,
        iv_addr = PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 1,
        ev_addr = PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 1,
        name_addr = PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 1,
        item_addr = PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 1,
        moves_addr = PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 1,
    },
    {
        description = "PARTY #3",
        pv_addr = PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 2,
        otid_addr = PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 2,
        iv_addr = PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 2,
        ev_addr = PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 2,
        name_addr = PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 2,
        item_addr = PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 2,
        moves_addr = PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 2,
    },
    {
        description = "PARTY #4",
        pv_addr = PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 3,
        otid_addr = PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 3,
        iv_addr = PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 3,
        ev_addr = PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 3,
        name_addr = PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 3,
        item_addr = PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 3,
        moves_addr = PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 3,
    },
    {
        description = "PARTY #5",
        pv_addr = PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 4,
        otid_addr = PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 4,
        iv_addr = PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 4,
        ev_addr = PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 4,
        name_addr = PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 4,
        item_addr = PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 4,
        moves_addr = PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 4,
    },
    {
        description = "PARTY #6",
        pv_addr = PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 5,
        otid_addr = PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 5,
        iv_addr = PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 5,
        ev_addr = PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 5,
        name_addr = PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 5,
        item_addr = PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 5,
        moves_addr = PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 5,
    },
    {
        description = "OPPONENT #1",
        pv_addr = OPPONENT_PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 0,
        otid_addr = OPPONENT_PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 0,
        iv_addr = OPPONENT_PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 0,
        ev_addr = OPPONENT_PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 0,
        name_addr = OPPONENT_PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 0,
        item_addr = OPPONENT_PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 0,
        moves_addr = OPPONENT_PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 0,
    },
    {
        description = "OPPONENT #2",
        pv_addr = OPPONENT_PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 1,
        otid_addr = OPPONENT_PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 1,
        iv_addr = OPPONENT_PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 1,
        ev_addr = OPPONENT_PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 1,
        name_addr = OPPONENT_PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 1,
        item_addr = OPPONENT_PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 1,
        moves_addr = OPPONENT_PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 1,
    },
    {
        description = "OPPONENT #3",
        pv_addr = OPPONENT_PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 2,
        otid_addr = OPPONENT_PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 2,
        iv_addr = OPPONENT_PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 2,
        ev_addr = OPPONENT_PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 2,
        name_addr = OPPONENT_PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 2,
        item_addr = OPPONENT_PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 2,
        moves_addr = OPPONENT_PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 2,
    },
    {
        description = "OPPONENT #4",
        pv_addr = OPPONENT_PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 3,
        otid_addr = OPPONENT_PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 3,
        iv_addr = OPPONENT_PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 3,
        ev_addr = OPPONENT_PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 3,
        name_addr = OPPONENT_PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 3,
        item_addr = OPPONENT_PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 3,
        moves_addr = OPPONENT_PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 3,
    },
    {
        description = "OPPONENT #5",
        pv_addr = OPPONENT_PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 4,
        otid_addr = OPPONENT_PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 4,
        iv_addr = OPPONENT_PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 4,
        ev_addr = OPPONENT_PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 4,
        name_addr = OPPONENT_PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 4,
        item_addr = OPPONENT_PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 4,
        moves_addr = OPPONENT_PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 4,
    },
    {
        description = "OPPONENT #6",
        pv_addr = OPPONENT_PARTY_ADDR + OFFSET_PV + PKMN_DS_SIZE * 5,
        otid_addr = OPPONENT_PARTY_ADDR + OFFSET_OTID + PKMN_DS_SIZE * 5,
        iv_addr = OPPONENT_PARTY_ADDR + OFFSET_IV + PKMN_DS_SIZE * 5,
        ev_addr = OPPONENT_PARTY_ADDR + OFFSET_EV + PKMN_DS_SIZE * 5,
        name_addr = OPPONENT_PARTY_ADDR + OFFSET_NAME + PKMN_DS_SIZE * 5,
        item_addr = OPPONENT_PARTY_ADDR + OFFSET_ITEM + PKMN_DS_SIZE * 5,
        moves_addr = OPPONENT_PARTY_ADDR + OFFSET_MOVES + PKMN_DS_SIZE * 5,
    },
}

-- converts pokemon's proprietary char set to standard ASCII
function ConvertNameToAscii(byteArr)
    local result = {}
    for _, byte in ipairs(byteArr) do
        local ch = tables.chars[byte]
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
local selection_locked = false

function OnFrame()
    frame = frame + 1

    local keys = emu:getKeys()

    if (selection_locked == false and keys & KEY_L ~= 0 and prev_key_mask & KEY_L == 0) then
        selected = ((selected-2) % 12) + 1
    end

    if (selection_locked == false and keys & KEY_R ~= 0 and prev_key_mask & KEY_R == 0) then
        selected = (selected % 12) + 1
    end

    if (keys & KEY_SELECT ~= 0 and prev_key_mask & KEY_SELECT == 0) then
        selection_locked = not selection_locked
    end

    prev_key_mask = keys

    local selected_pv_addr = OFFSETS[selected].pv_addr
    local selected_otid_addr = OFFSETS[selected].otid_addr
    local selected_iv_addr = OFFSETS[selected].iv_addr
    local selected_ev_addr = OFFSETS[selected].ev_addr
    local selected_name_addr = OFFSETS[selected].name_addr
    local selected_item_addr = OFFSETS[selected].item_addr
    local selected_moves_addr = OFFSETS[selected].moves_addr

    if (frame % interval == 0) then
        local tid = emu:read16(selected_otid_addr)
        local sid = emu:read16(selected_otid_addr + 2)
        local pv_lo = emu:read16(selected_pv_addr)
        local pv_hi = emu:read16(selected_pv_addr + 2)

        -- This threshold may not be 16 when, need to test further:
        -- 1. shiny chaining
        -- 2. breeding with non-OT pokemon (masuda method, e.g. breeding with perfect ditto)
        -- 3. the user posseses the shiny charm

        local is_shiny = (tid ~ sid ~ pv_lo ~ pv_hi) < 16
        local shiny_str = (is_shiny and "***SHINY***" or "")
        local selection_locked_str  = (selection_locked and "LOCKED" or "UNLOCKED")

        local pv = emu:read32(selected_pv_addr)
        local nature = tables.natures[pv % 25]

        local item_data = emu:read16(selected_item_addr)
        local item = tables.items[item_data]

        local move1_val = emu:read16(selected_moves_addr)
        local move2_val = emu:read16(selected_moves_addr + 2)
        local move3_val = emu:read16(selected_moves_addr + 4)
        local move4_val = emu:read16(selected_moves_addr + 6)

        local move1 = tables.moves[move1_val]
        local move2 = tables.moves[move2_val]
        local move3 = tables.moves[move3_val]
        local move4 = tables.moves[move4_val]

        local iv_data = emu:read32(selected_iv_addr)
        local iv_hp = iv_data & 0x1F
        local iv_atk = (iv_data >> 5) & 0x1F
        local iv_def = (iv_data >> 10) & 0x1F
        local iv_speed = (iv_data >> 15) & 0x1F
        local iv_spatk = (iv_data >> 20) & 0x1F
        local iv_spdef = (iv_data >> 25) & 0x1F

        local ev_data1 = emu:read32(selected_ev_addr)
        local ev_data2 = emu:read16(selected_ev_addr + 4)

        local ev_hp = ev_data1 & 0xFF
        local ev_atk = (ev_data1 >> 8) & 0xFF
        local ev_def = (ev_data1 >> 16) & 0xFF
        local ev_speed = (ev_data1 >> 24) & 0xFF
        local ev_spatk = ev_data2 & 0xFF
        local ev_spdef = (ev_data2 >> 8) & 0xFF

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
        buffer:print(string.format("%s: %s %s\n", OFFSETS[selected].description, name, shiny_str));
        buffer:print(string.format("Personality Value (PV): 0x%08X\n", pv))
        buffer:print(string.format("Nature: %s\n", nature));
        buffer:print(string.format("Item: %s\n", item));
        buffer:print(string.format("Stat: HP | ATK | DEF | SP.A | SP.D | SPEED\n"))
        buffer:print(string.format("IVs: %3i |%4i |%4i |%5i |%5i |%5i\n", iv_hp, iv_atk, iv_def, iv_spatk, iv_spdef, iv_speed))
        buffer:print(string.format("EVs: %3i |%4i |%4i |%5i |%5i |%5i\n", ev_hp, ev_atk, ev_def, ev_spatk, ev_spdef, ev_speed))
        buffer:print(string.format("Moves: %s | %s | %s | %s\n", move1, move2, move3, move4))
        buffer:print(string.format("---- Keybinds -----\n"));
        buffer:print(string.format("L/R = view prev/next pokemon\nSelect = Toggle pokemon selection lock\n"))
        buffer:print(string.format("Selection is currently: %s\n", selection_locked_str))
        -- buffer:print(string.format("\nKeys 0x%08X\n", keys))
    end
end

callbacks:add("frame", OnFrame)
