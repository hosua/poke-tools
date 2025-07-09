Important Resources:

- [Pokemon Data Structure](<https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_structure_(Generation_III)>)
- [Pokemon Data Substructure](<https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_substructures_(Generation_III)>)

Trainer's Party Memory Address: 0x02024284
Opponent Pokemon Memory Address: 0x02024020

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

```
0x02024284: Personality Value (PV)
0x02024288: OTID (Lo: Secret ID | Hi: Trainer ID)
0x0202428C: Nickname (Characters 0-3 inclusive)
0x02024290: Nickname (Characters 4-7 inclusive)
0x02024294: Nickname (Lo: Characters 8 and 9 | Hi-Lo: Language | Hi-Hi: Misc. Flags)
0x02024298: OT Name (Characters 0-3 inclusive)
0x0202429C: OT Name (Lower 3 Bytes: Characters 4-6 inclusive | Hi-Hi: Markings)
0x020242A0: Checksum (unused in Pokemon Unbound)
0x020242A4: (Lo: Species ID | Hi: Held Item ID)
0x020242A8: Experience
0x020242AC: (Lo-Lo: PP Bonuses | Lo-Hi: Friendship | Hi: ????)
0x020242B0: (Lo: Move 2 ID | Hi: Move 1 ID)
0x020242B4: (Lo: Move 3 ID | Hi: Move 4 ID)
0x020242B8: Remaining PP (Move 4 | Move 3 | Move 2 | Move 1)
0x020242BC: EVs (Speed | Def | Atk | HP)
0x020242C0: EVs (Sp. Def | Sp. Atk)
0x020242C4: (No idea, changing this value seems to have no noticeable effects)
0x020242C8: (Lo-Lo: Pokerus status | Lo-Hi: Met Location | Hi-Lo: Level Met (0 implies a hatched pokemon) | Gigantamax flag is somewhere in here) <-- Needs further investigation
0x020242CC: (IVs, IsEgg, Ability) (IV Order: Sp. Def | Sp. Atk | Speed | Def | Atk | HP)
0x020242D0: ? (Changing this can trigger fateful encounter description)
0x020242D4: (Lower 3 bits: Status Condition | Rest is unused)
0x020242D8: (Lo: ? | Hi: Remaining HP)
0x020242DC: (Lo: HP Stat | Hi: Attack Stat)
0x020242E0: (Lo: Def Stat | Hi: Speed Stat)
0x020242E4: (Lo: Sp. Atk Stat | Hi: Sp. Def Stat)
```
