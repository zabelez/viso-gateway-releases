# Viso Gateway 0.3.1

A fix release for the three macOS menu-bar apps: Viso Gateway, Viso Gateway NDI, and Viso Gateway Screen. Same apps, same menus, same `viso://` URLs as 0.3.0.

Requires **macOS 11.0** or later for Viso Gateway and Viso Gateway NDI (Monterey 12 included). Viso Gateway Screen requires **macOS 13.0** (Ventura) or later.

## What is fixed

- **Players in other rooms and departments.** A Player on another part of the network could list the source but show no picture. With [Viso Player 0.26.1](https://github.com/zabelez/viso-player-releases/releases/tag/v0.26.1), picture and sound now reach it, including through firewalls between networks.
- **Any local network.** The apps work on whichever network the Mac is connected to.
- **Faster start after idle.** Picture comes back right away when a Player returns after a pause.
- **Logs.** **Show Logs…** in the menu opens the app logs. Attach them when you report a problem.

## Update Viso Player too

**Use this Gateway with [Viso Player 0.26.1](https://github.com/zabelez/viso-player-releases/releases/tag/v0.26.1)** so Players in other rooms and departments get the fix. Other combinations keep working as before on the same network.

## What these files are for

**`Viso-Gateway-0.3.1.dmg` — Viso Gateway**

Publishes every visible **Syphon** source on this Mac as Viso, and can publish selected **IPMX-AVC** Senders from the same menu. Syphon is video only.

**`Viso-Gateway-NDI-0.3.1.dmg` — Viso Gateway NDI**

Publishes **one NDI source per instance** as Viso. **New Instance** opens another icon for a second source. The NDI library is inside the app.

**`Viso-Gateway-Screen-0.3.1.dmg` — Viso Gateway Screen**

Publishes **one display** on this Mac as Viso, with system audio on the same stream. Allow **Screen Recording** when macOS asks.

## Install

1. Quit the running Gateway app (**Close** in its menu).
2. Download the DMG you need and its `.sha256` file.
3. Verify:

   ```bash
   shasum -a 256 -c Viso-Gateway-0.3.1.dmg.sha256
   # or
   shasum -a 256 -c Viso-Gateway-NDI-0.3.1.dmg.sha256
   # or
   shasum -a 256 -c Viso-Gateway-Screen-0.3.1.dmg.sha256
   ```

4. Open the DMG. Drag the app to **Applications** and replace the old one.
5. First launch: if macOS blocks it, **Control-click → Open** (ad-hoc signature, no Developer ID).
6. Allow **Local Network** if macOS asks. Viso Gateway Screen also asks for **Screen Recording**.

**Start at Login** and the sources you picked are kept from 0.3.0.

## What you should see

- The same menu as 0.3.0, plus **Show Logs…**.
- On a Player 0.26.1 in another room or department, the source plays with picture and, for NDI and Screen, sound.

## Downloads

| File | SHA-256 |
|------|---------|
| `Viso-Gateway-0.3.1.dmg` | `4cc98ff3e595546b90072e633093931c783f1f38e0efd3d1b281ad79ff512f40` |
| `Viso-Gateway-NDI-0.3.1.dmg` | `85bb621bef60a6cd332b2b866da3e5fa9f43fea555b065d98d6755ac48a8b683` |
| `Viso-Gateway-Screen-0.3.1.dmg` | `16ccb71447d93c78ecd9a11f1990f367f72bf387da7e67ca76b01b12efe5f58f` |
