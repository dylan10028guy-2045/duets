# Telegram MCP setup

Server: [overpod/mcp-telegram](https://github.com/overpod/mcp-telegram) (free, MIT). Runs as a userbot on Dylan's own Telegram account.

`.mcp.json` registers it for any Claude Code session opened in this repo. Keys come from environment variables and are never stored here.

## One-time setup (on Dylan's machine)

1. Get `api_id` and `api_hash` at https://my.telegram.org → API development tools.
2. Export them in your shell profile (not in this repo):
   ```bash
   export TELEGRAM_API_ID=...
   export TELEGRAM_API_HASH=...
   ```
3. Log in once by QR code (Telegram app → Settings → Devices → Link Desktop Device):
   ```bash
   npx @overpod/mcp-telegram login
   ```
   The session saves to `~/.mcp-telegram/session`. If 2FA is on, add `TELEGRAM_2FA_PASSWORD=...` to that one command only.
4. Open Claude Code in this repo, approve the `telegram` server, and run the `telegram-status` tool to confirm.

To enable it in every project instead: `claude mcp add telegram -s user -e TELEGRAM_API_ID=... -e TELEGRAM_API_HASH=... -- npx @overpod/mcp-telegram`

## Rules

- API keys and the session file are private. Never commit them or send them on the InterOp bus.
- Sending messages or posting to channels outside a standing workflow needs Dylan's approval first.
