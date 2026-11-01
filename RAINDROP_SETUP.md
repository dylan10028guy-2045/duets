# Raindrop.io MCP setup

Server: Raindrop.io's official hosted MCP (https://help.raindrop.io/integrations/mcp). It uses Streamable HTTP with OAuth sign-in, so there are no keys to store.

`.mcp.json` registers it as `raindrop` for any Claude Code session opened in this repo.

## Connect

1. Open Claude Code in this repo and approve the `raindrop` server.
2. Run `/mcp`, pick `raindrop`, and sign in to Raindrop.io in the browser window.

To enable it in every project instead: `claude mcp add --transport http -s user raindrop https://api.raindrop.io/rest/v2/ai/mcp`

On claude.ai (web, desktop, mobile) add it as a custom connector with the same URL.

## Plan note

The free Raindrop plan works but has no text or semantic search through MCP. Full search needs Raindrop Pro, which is a paid upgrade and Dylan's call.
