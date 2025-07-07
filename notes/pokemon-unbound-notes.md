Important Resources:

- [Pokemon Data Structure](<https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_structure_(Generation_III)>)
- [Pokemon Data Substructure](<https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_substructures_(Generation_III)>)

Trainer's Party Memory Address: 0x2024284

Some important distinctions to note about Pokemon Unbound vs. Official Pokemon

- Pokemon data substructure is not encrypted in Pokemon Unbound
- Consequently, data substructure order is also the same for every pokemon which makes memory hacking a lot easier!

#### Definitions

- Lo: Lower 2 bytes
- Lo-Lo: Lower byte of lower 2 bytes
- Lo-Hi: Upper byte of lower 2 bytes
- Hi: Upper 2 bytes
- Hi-Lo: Lower byte of upper 2 bytes
- Hi-Hi: Upper byte of upper 2 bytes

---

#### TODO: Add memory address offsets to make this more general.

### Heracross (Megacross):

```
E1011E57: Personality Value (PV)
5F77790D: OTID (Lo: Secret ID | Hi: Trainer ID)
D5DBD9C7: Nickname (Characters 0-3 inclusive)
E7E3E6D7: Nickname (Characters 4-7 inclusive)
0202FFE7: Nickname (Lo: Characters 8 and 9 | Hi-Lo: Language | Hi-Hi: Misc. Flags)
FFFFFFBB: OT Name (Characters 0-3 inclusive)
00FFFFFF: OT Name (Lower 3 Bytes: Characters 4-6 inclusive | Hi-Hi: Markings)
00000000: Checksum (unused in Pokemon Unbound)
01D000D6: (Lo: Species ID | Hi: Held Item ID)
001312D0: Experience
0001FF00: (Lo-Lo: PP Bonuses | Lo-Hi: Friendship | Hi: ????)
015E002A: (Lo: Move 2 ID | Hi: Move 1 ID)
000E016D: (Lo: Move 3 ID | Hi: Move 4 ID)
11050A0E: Remaining PP (Move 4 | Move 3 | Move 2 | Move 1)
FC00FC00: EVs (Speed | Def | Atk | HP)
00000600: EVs (Sp. Def | Sp. Atk)
00000000: (No idea, changing this value seems to have no noticeable effects)
02006910: (Lo-Lo: Pokerus status | Lo-Hi: Met Location | Hi-Lo: Level Met (0 implies a hatched pokemon) | Gigantamax flag is somewhere in here) <-- Needs further investigation
In official pokemon
3FEFFFFF: (IVs, IsEgg, Ability) (IV Order: Sp. Def | Sp. Atk | Speed | Def | Atk | HP)
00000000: ? (Changing this can trigger fateful encounter description)
00000000: (Lower 3 bits: Status Condition | Rest is unused)
0084FF64: (Lo: ? | Hi: Remaining HP)
017F012D: (Lo: HP Stat | Hi: Attack Stat)
010D00BA: (Lo: Def Stat | Hi: Speed Stat)
00E30067: (Lo: Sp. Atk Stat | Hi: Sp. Def Stat)
```

Opponent Pokemon Memory Address: 0x02024020

Is this data encrypted? Yes, wild pokemon data IS encrypted.

Randomly Encountered Furfrou:

```python
# IVs: 16/18/26/16/2/30

>>> bin(16), bin(18), bin(26), bin(30), bin(16), bin(2)
('0b10000', '0b10010', '0b11010', '0b11110', '0b10000', '0b10')
>>> hex(16), hex(18), hex(26), hex(30), hex(16), hex(2)
('0x10', '0x12', '0x1a', '0x1e', '0x10', '0x2')


>>> bin(key ^ 0x050f6a50)
'0b11110011111101101010101101000010'

>>> bin(key ^ 0x0234B600)
'0b11110100110011010111011100010010'
```

```
A98EB81F: PV
5F77790D: OTID
DAE6E9C0: Name (Char 0-3)
FFE9E3E6: Name (Char 4-7)
0202F604: (Lo: ? | Hi-Lo: Region | Hi-Hi: ?)
FFFFFFBB:
00FFFFFF:
00000000:
00000310: Pokemon Sprite ID
00022540: XP of Pokemon when caught
00033200: No clue what this is, but it changes when battle ends
002401CA: (Lo: Move 1 ID | Hi: Move 2 ID)
01B700CC: (Lo: Move 3 ID | Hi: Move 4 ID)
0A141405: Remaining PP
00000000:
00000000:
00000000:
0234B600: (Lo-Lo: ? | Lo-Hi: ? | Hi-Lo: Met Level | Hi-Hi: ?) Gigantamax flag is somewhere here
050F6A50: (IVs, IsEgg, Ability) (IV Order: Sp. Def | Sp. Atk | Speed | Def | Atk | HP)
00000000:
00000000:
0094FF34: (Lo: ? | Hi: Remaining HP)
006A0094:
007E0048:
00630050:


```
