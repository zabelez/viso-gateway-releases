# Viso Gateway 0.2.0

Three macOS menu-bar apps. Drag the one you need onto **Applications**. There is no window: a menu-bar icon is the whole UI. No license key.

This project is **in active development**. If it does not work on your Mac, [open an issue](https://github.com/zabelez/viso-gateway-releases/issues) with which app you used, the source, and what you saw.

Requires **macOS 11.0** or later for Viso Gateway and Viso Gateway NDI (Monterey 12 included). Viso Gateway Screen requires **macOS 13.0** (Ventura) or later.

## What is new

- **Viso Gateway Screen** — publish one Mac display as Viso, with system audio on the same stream (macOS 13+).
- **High Quality controls** on every app — Resolution, Frame Rate, and Bitrate for the single high stream. **Auto** and **Native** follow the source; you can also pick a fixed size, frame rate, or bitrate cap. The low stream stays a 640-wide proxy.
- **Same fit as Viso Player 0.25.0** — encode size is **min(JOIN request, source, encoder)**. There is no 1080p60 product ceiling when the source and the player allow more.

## Update Viso Player too

**Use this Gateway with [Viso Player 0.25.0](https://github.com/zabelez/viso-player-releases/releases/tag/v0.25.0).** Player and Gateway share the same size / frame-rate / bitrate fit. Keeping Gateway on 0.1.0 while the players are on 0.25.0 will not negotiate correctly — update both sides of the room.

## What these files are for

**`Viso-Gateway-0.2.0.dmg` — Viso Gateway**

Publishes every visible **Syphon** source on this Mac as Viso. One instance handles the whole list. Syphon is video only.

**`Viso-Gateway-NDI-0.2.0.dmg` — Viso Gateway NDI**

Publishes **one NDI source per instance** as Viso. Click the source in the menu (checkmark). **New Instance** opens another icon for a second source. The NDI library is inside the app; you do not install an NDI SDK or Runtime on this Mac.

**`Viso-Gateway-Screen-0.2.0.dmg` — Viso Gateway Screen**

Publishes **one display** on this Mac as Viso, with system audio on the same stream. Allow **Screen Recording** when macOS asks. One display per instance; **New Instance** for a second display.

All three apps encode on the Mac (VideoToolbox, with a software fallback).

## Install

1. Download the DMG you need and its `.sha256` file.
2. Verify:

   ```bash
   shasum -a 256 -c Viso-Gateway-0.2.0.dmg.sha256
   # or
   shasum -a 256 -c Viso-Gateway-NDI-0.2.0.dmg.sha256
   # or
   shasum -a 256 -c Viso-Gateway-Screen-0.2.0.dmg.sha256
   ```

3. Open the DMG. Drag the app to **Applications**.
4. First launch: if macOS blocks it, **Control-click → Open** (ad-hoc signature, no Developer ID).
5. Allow **Local Network** if macOS asks. Viso Gateway Screen also asks for **Screen Recording**.
6. Click the menu-bar icon. For Gateway NDI, pick a source. For Gateway Screen, pick a display. For Gateway, Syphon sources publish on their own.
7. On a Viso Player **0.25.0**, open **Displays** and select the source.

**Start at Login** keeps the app running after reboot. **Close** stops that instance.

## What you should see

- **Viso Gateway:** the menu lists Syphon sources, **High Quality**, **Start at Login**, and **Close**. A source already published from this Mac is marked **this Mac**.
- **Viso Gateway NDI:** **New Instance** at the top, the NDI list in the middle, **High Quality**, **Start at Login** and **Close** at the bottom. The active source has a checkmark.
- **Viso Gateway Screen:** the same menu shape, listing displays instead of NDI sources. The active display has a checkmark.

## Downloads

| File | SHA-256 |
|------|---------|
| `Viso-Gateway-0.2.0.dmg` | `cb84f01f0c1b32cf346b48fdc021b22e710a4f45716a4575b4ea586d3d4213d7` |
| `Viso-Gateway-NDI-0.2.0.dmg` | `5a02724ba9e21d3db80a96256dae83c23a01948cc1033d0c6a59d8680876a112` |
| `Viso-Gateway-Screen-0.2.0.dmg` | `83d23754aa8fe713bf811313c746a59bce55acd4e6d689ba461aa2834903648c` |
