local pv_addr = 0x0202402C
local iv_addr = 0x02024074

local overlay = console:createBuffer("iv-peeker")

function onFrame()
    local pv = emu:read32(pv_addr)
    local iv_data = emu:read32(iv_addr)
    local hp = iv_data & 0x1F
    local atk = (iv_data >> 5) & 0x1F
    local def = (iv_data >> 10) & 0x1F
    local speed = (iv_data >> 15) & 0x1F
    local spatk = (iv_data >> 20) & 0x1F
    local spdef = (iv_data >> 25) & 0x1F
    overlay:clear()
    overlay:moveCursor(0, 0)
    overlay:print("----------------------------------------\n")
    overlay:print(string.format("Personality Value (PV): 0x%8X\n", pv))
    overlay:print(string.format("HP: %i\n", hp))
    overlay:print(string.format("Attack: %i\n", atk))
    overlay:print(string.format("Defense: %i\n", def))
    overlay:print(string.format("Speed: %i\n", speed))
    overlay:print(string.format("Sp. Attack: %i\n", spatk))
    overlay:print(string.format("Sp. Defense: %i\n", spdef))
end

callbacks:add("frame", onFrame)
