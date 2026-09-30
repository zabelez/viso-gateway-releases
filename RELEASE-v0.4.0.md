# Viso Gateway 0.4.0

**Viso Gateway is now on Windows too.** Three macOS menu-bar apps and two Windows notification-area apps, all from one version. There is no window: the icon is the whole UI. No license key.

This project is **in active development**. If it does not work on your Mac or PC, [open an issue](https://github.com/zabelez/viso-gateway-releases/issues) with which app you used, the source, and what you saw.

- **macOS:** Viso Gateway and Viso Gateway NDI need **macOS 11.0** or later (Monterey 12 included). Viso Gateway Screen needs **macOS 13.0** (Ventura) or later.
- **Windows:** **Windows 10 or 11, 64-bit.** Viso Gateway and Viso Gateway NDI. Viso Gateway Screen is macOS-only.

## What is new

- **Windows: Viso Gateway (IPMX-AVC).** Click an IPMX-AVC Sender in the tray menu to publish it as Viso, with the same stable Sender UUID as on the Mac. The NMOS Query API is found with the Windows DNS client (mDNS and unicast DNS-SD), with no Bonjour install; **NMOS Query URL...** in the menu covers networks where discovery is blocked. There is no Syphon on Windows. Same lab-proven subset as 0.3.0: **not** an IPMX Certified Receiver and not an AIMS logo claim.
- **Windows: Viso Gateway NDI.** One NDI source per instance, **New Instance** for more, same menu as the Mac. The NDI runtime DLL is in the zip; you do not install NDI Tools or the NDI Runtime.
- **Windows encoders.** NVIDIA NVENC, Intel Quick Sync, AMD AMF, then Microsoft Media Foundation, which every Windows 10/11 PC has. Each one must pass the Player contract (H.264 High, IPPP, no B-frames, SPS/PPS on every keyframe) before it is used.
- **Keyframes always carry SPS/PPS** on every platform. If an encoder leaves them out of a keyframe, the Gateway puts them back, so a Player that joins late still starts on the next keyframe.
- **Flip Horizontal and Flip Vertical.** For sources that arrive mirrored or upside down. In Viso Gateway they are in each source's submenu and saved per source; in Viso Gateway NDI and Viso Gateway Screen they sit next to **High Quality**. Both on turns the picture 180 degrees. Toggling one keeps the same `viso://` URL, and Players get the corrected picture in High and Low Quality.
- **Everything from 0.3.1** on Mac and Windows: Players in other rooms and departments get picture and sound (with Viso Player 0.26.1), the apps work on whichever network the computer is on, picture comes back right away after idle, and **Show Logs…** opens the app logs.
- **One version everywhere.** The DMGs, the Windows zips and the apps' About/Properties all report 0.4.0.

## Update Viso Player too

**Use this Gateway with [Viso Player 0.26.1](https://github.com/zabelez/viso-player-releases/releases/tag/v0.26.1) or later** so Players in other rooms and departments get picture and sound. Mac and Windows Gateways publish the same `viso://` wire; Players do not need to know which one they are talking to.

## What these files are for

**`Viso-Gateway-0.4.0.dmg` — Viso Gateway for macOS**

Publishes every visible **Syphon** source on this Mac as Viso, and can publish selected **IPMX-AVC** Senders from the same menu. Syphon is video only.

**`Viso-Gateway-NDI-0.4.0.dmg` — Viso Gateway NDI for macOS**

Publishes **one NDI source per instance** as Viso. **New Instance** opens another icon for a second source. The NDI library is inside the app.

**`Viso-Gateway-Screen-0.4.0.dmg` — Viso Gateway Screen for macOS**

Publishes **one display** on this Mac as Viso, with system audio on the same stream. Allow **Screen Recording** when macOS asks.

**`Viso-Gateway-0.4.0-windows-x64.zip` — Viso Gateway for Windows**

Publishes selected **IPMX-AVC** Senders as Viso. Click a Sender in the tray menu (checkmark); click again to stop.

**`Viso-Gateway-NDI-0.4.0-windows-x64.zip` — Viso Gateway NDI for Windows**

Publishes **one NDI source per instance** as Viso. **New Instance** opens another tray icon for a second source.

## Install on macOS

1. Download the DMG you need and its `.sha256` file.
2. Verify: `shasum -a 256 -c Viso-Gateway-0.4.0.dmg.sha256` (same for the NDI and Screen DMGs).
3. Open the DMG. Drag the app to **Applications**.
4. First launch: if macOS blocks it, **Control-click → Open** (ad-hoc signature, no Developer ID).
5. Allow **Local Network** if macOS asks. Viso Gateway Screen also asks for **Screen Recording**.

## Install on Windows

1. Download the zip you need and its `.sha256` file.
2. Verify in PowerShell: `(Get-FileHash .\Viso-Gateway-0.4.0-windows-x64.zip).Hash` must match the `.sha256` file (case does not matter).
3. Right-click the zip → **Properties** → **Unblock** (if shown) → **OK**. Extract it anywhere, for example `C:\Viso`, and keep the folder together.
4. Open **`Viso Gateway.exe`** or **`Viso Gateway NDI.exe`**. If SmartScreen says "Windows protected your PC", click **More info → Run anyway** (the app is not code-signed yet).
5. When Windows Defender Firewall asks, allow **Private networks**. Players reach the Gateway over UDP and discovery uses mDNS. The network must be **Private**; on Public, Windows blocks both.
6. The icon is in the notification area (click **^** next to the clock if it is hidden).

On both systems, **Start at Login** keeps the app running after reboot and **Close** stops that instance. On a Viso Player, open **Displays** and select the source.

## What you should see

- **Viso Gateway (Mac):** Syphon (and IPMX when discovery is configured), **High Quality**, **Start at Login**, **Close**. A source already published from this Mac is marked **this Mac**.
- **Viso Gateway (Windows):** IPMX-AVC Senders, **High Quality** per source, **NMOS Query URL...**, **Start at Login**, **Close**. If no Query API is found, the menu says so and **NMOS Query URL...** is the fix.
- **Viso Gateway NDI (Mac and Windows):** **New Instance** at the top, the NDI list in the middle, **High Quality**, **Start at Login** and **Close** at the bottom. The active source has a checkmark.
- **Viso Gateway Screen (Mac):** the same menu shape, listing displays.

Every app also has **Flip Horizontal** / **Flip Vertical** (per source in Viso Gateway) and **Show Logs…**. Changing High Quality or a flip keeps the same `viso://` URL on every app.

## Downloads

### macOS

| File | SHA-256 |
|------|---------|
| `Viso-Gateway-0.4.0.dmg` | `4524851385a63b8aa91fbb97dfc00ec569b317fafa1d67af36a94c80fff1ff1a` |
| `Viso-Gateway-NDI-0.4.0.dmg` | `25d12627f2dd693b4a5a8f74276c50cb5d3c40fa2814ee394c071a0e63ef8bcf` |
| `Viso-Gateway-Screen-0.4.0.dmg` | `a27d279b832ccc1101fe896b7d8ce4d5fa1660ebdc983ec5b77c198b480021ad` |

### Windows

| File | SHA-256 |
|------|---------|
| `Viso-Gateway-0.4.0-windows-x64.zip` | `56f88c15ef453fc1759a247fffab28bc0b3057c6702174e690546feb0ef32558` |
| `Viso-Gateway-NDI-0.4.0-windows-x64.zip` | `defbb1d4e28d2c0b450c6610d1c894601d35950ccd188b8bc1cb3cb34c8a7e56` |

FFmpeg in the Windows zips is LGPL, dynamically linked (DLLs next to the exe); licenses and the FFmpeg build configuration are in each zip's `LICENSES` folder. NDI® is a registered trademark of Vizrt NDI AB.
