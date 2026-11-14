# Stream Kit

Four fixes for streaming from OBS to Twitch and YouTube at once:

1. **Stream to both, stop each one on its own.** A one-line installer for the free [Aitum Multistream](https://github.com/Aitum/obs-aitum-multistream) OBS plugin.
2. **One chat for Twitch and YouTube.** Setup steps for [Social Stream Ninja](https://socialstream.ninja).
3. **Daily sub goal that updates by itself.** Our own overlay. It listens to Twitch EventSub and resets every day.
4. **Blerp text-to-speech not playing.** A checklist.

**Start here: https://realworldbuilder.github.io/stream-kit/**

## Install

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/realworldbuilder/stream-kit/main/install/windows.ps1 | iex
```

Mac (Terminal):

```bash
curl -fsSL https://raw.githubusercontent.com/realworldbuilder/stream-kit/main/install/mac.sh | bash
```

## How the sub goal works

- `docs/goal-setup.html` signs in to Twitch with the implicit grant flow. The only scope it asks for is `channel:read:subscriptions`. It then builds the overlay link.
- `docs/goal.html` is the OBS browser source. It opens the EventSub WebSocket and subscribes to `channel.subscribe` (new subs and each gifted sub) and `channel.subscription.message` (resubs). Each event adds 1, or tier points in points mode.
- The daily count is stored in the browser source's own `localStorage`, so refreshing the source keeps the number. It resets at the hour the streamer picks.
- All settings, including the token, sit in the part of the link after `#`, so they never reach a server.
- Link options: `goal`, `label`, `reset` (0 to 23), `mode` (`subs` or `points`), `accent`, `text`, `track` (hex colours without `#`) and `test=1` (sends fake subs).
- To fix the number, right-click the source in OBS, choose Interact, and press `+`, `-` or `0`.

### Twitch app (one-time, for whoever hosts this)

1. Go to https://dev.twitch.tv/console/apps and click **Register Your Application**.
2. OAuth Redirect URL: `https://realworldbuilder.github.io/stream-kit/goal-setup.html`. Category: Broadcasting Suite. Client type: **Confidential**. Public clients can't use the implicit grant.
3. Put the Client ID in `docs/config.js`. A client ID is public, but the client secret is not: don't commit the secret, because nothing here needs it.
