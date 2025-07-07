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

### Heracross (Megacross):

```
E1011E57: PV
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
015E002A: ?
000E016D: ?
11050A0E: ?
FC00FC00: EVs (Speed | Def | Atk | HP)
00000600: EVs (Sp. Def | Sp. Atk)
00000000: ?
02006910: (Lo-Lo: Pokerus status | Lo-Hi: Met Location | Hi-Lo: Level Met (0 implies a hatched pokemon) | Gigantamax flag is somewhere in here) <-- Needs further investigation
In official pokemon
3FEFFFFF: Data Substructure (IVs, IsEgg, Ability)
00000000: ?
00000000: ?
0084FF64: ?
017F012D: ?
010D00BA: ?
00E30067: ?
```
