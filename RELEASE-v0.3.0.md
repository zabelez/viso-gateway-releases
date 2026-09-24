# Viso Gateway 0.3.0

Three macOS menu-bar apps. Drag the one you need onto **Applications**. There is no window: a menu-bar icon is the whole UI. No license key.

This project is **in active development**. If it does not work on your Mac, [open an issue](https://github.com/zabelez/viso-gateway-releases/issues) with which app you used, the source, and what you saw.

Requires **macOS 11.0** or later for Viso Gateway and Viso Gateway NDI (Monterey 12 included). Viso Gateway Screen requires **macOS 13.0** (Ventura) or later.

## What is new

- **High Quality restart keeps the same URL.** Changing Resolution / Frame Rate / Bitrate still respawns the publisher, but **reuses the same RTP block**, so `viso://` stays stable and Players keep JOINing without remapping Displays.
- **IPMX-AVC ingest in Viso Gateway** (same app as Syphon — not a separate DMG). Click an IPMX Sender to publish it as Viso with a stable Sender UUID. Syphon sources still auto-publish. This is a lab-proven ingest of the tested active IPMX-AVC subset — **not** an IPMX Certified Receiver and not an AIMS logo claim.
- **True A/V timing on the wire.** Video and audio share one start clock. The Gateway sends periodic RTCP Sender Reports (including a dedicated audio RTCP port) so Players can keep picture and sound together. Replaces the old fixed audio hold.
- **Smoother Screen and NDI audio.** Only real captured PCM goes on the wire — no silence fillers on empty polls. Audio timestamps advance continuously so the sound does not jump or chop. Screen capture can drain audio in bounded chunks so it does not race ahead when High Quality encode is heavy.
- **Syphon stays video-only.** Does not invent silence for Syphon (that was stuttering Players with audio enabled).
- **First picture after JOIN is more reliable.** The idle “still have a viewer” window is longer (about 10 s), so encode does not pause mid-JOIN while the Player is still waiting for the first frame.
- **Pair with Viso Player 0.26.0.** Player routes bind by `source_id` and rediscover when a cold-start still has to move the control port. That build also consumes the new A/V timing.

## Update Viso Player too

**Use this Gateway with [Viso Player 0.26.0](https://github.com/zabelez/viso-player-releases/releases/tag/v0.26.0).** Keeping players on 0.25.0 still works for many rooms, but 0.26.0 is the build that recovers automatically when a Gateway cold-start changes the control port, and that pairs with the A/V timing and audio smoothness in this Gateway.

## What these files are for

**`Viso-Gateway-0.3.0.dmg` — Viso Gateway**

Publishes every visible **Syphon** source on this Mac as Viso, and can publish selected **IPMX-AVC** Senders from the same menu. One instance handles the list. Syphon is video only.

**`Viso-Gateway-NDI-0.3.0.dmg` — Viso Gateway NDI**

Publishes **one NDI source per instance** as Viso. Click the source in the menu (checkmark). **New Instance** opens another icon for a second source. The NDI library is inside the app; you do not install an NDI SDK or Runtime on this Mac.

**`Viso-Gateway-Screen-0.3.0.dmg` — Viso Gateway Screen**

Publishes **one display** on this Mac as Viso, with system audio on the same stream. Allow **Screen Recording** when macOS asks. One display per instance; **New Instance** for a second display.

All three apps encode on the Mac (VideoToolbox, with a software fallback).

## Install

1. Download the DMG you need and its `.sha256` file.
2. Verify:

   ```bash
   shasum -a 256 -c Viso-Gateway-0.3.0.dmg.sha256
   # or
   shasum -a 256 -c Viso-Gateway-NDI-0.3.0.dmg.sha256
   # or
   shasum -a 256 -c Viso-Gateway-Screen-0.3.0.dmg.sha256
   ```

3. Open the DMG. Drag the app to **Applications**.
4. First launch: if macOS blocks it, **Control-click → Open** (ad-hoc signature, no Developer ID).
5. Allow **Local Network** if macOS asks. Viso Gateway Screen also asks for **Screen Recording**.
6. Click the menu-bar icon. For Gateway NDI, pick a source. For Gateway Screen, pick a display. For Gateway, Syphon sources publish on their own; click an IPMX Sender when you want that path.
7. On a Viso Player **0.26.0**, open **Displays** and select the source.

**Start at Login** keeps the app running after reboot. **Close** stops that instance.

## What you should see

- **Viso Gateway:** the menu lists Syphon (and IPMX when discovery is configured), **High Quality**, **Start at Login**, and **Close**. A source already published from this Mac is marked **this Mac**. Changing High Quality keeps the same `viso://` URL.
- **Viso Gateway NDI:** **New Instance** at the top, the NDI list in the middle, **High Quality**, **Start at Login** and **Close** at the bottom. The active source has a checkmark. Picture and sound stay together on a 0.26.0 Player.
- **Viso Gateway Screen:** the same menu shape, listing displays instead of NDI sources. The active display has a checkmark. System audio on the same stream should stay smooth and in sync with the picture on a 0.26.0 Player.

## Downloads

| File | SHA-256 |
|------|---------|
| `Viso-Gateway-0.3.0.dmg` | `8c02df2261a9666e3091f88ac49e38ec2ce35ea3b53cb90c82a261a1b742d29f` |
| `Viso-Gateway-NDI-0.3.0.dmg` | `9cba5b8547307a3a985bf9b4f374032731b2a1b6ac9379a14ad0c671d3d19233` |
| `Viso-Gateway-Screen-0.3.0.dmg` | `94be4a3d1eaa2e51a2c8af131910e394db66145e2fd8749ac53ace22c377df1e` |

