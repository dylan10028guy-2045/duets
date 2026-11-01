# Pipedream Connect MCP setup

Server: Pipedream's remote MCP (`https://remote.mcp.pipedream.net/v3`), using Connect project `proj_qzsEPKG` in the **production** environment. It gives Claude tools for one of Pipedream's 3,000+ apps at a time, using accounts connected to that project.

`.mcp.json` registers it as `pipedream`. Claude Code runs `scripts/pipedream-mcp-headers.sh` on each connection to get a fresh access token (tokens last about an hour), so nothing private lives in this repo.

## One-time setup (on Dylan's machine)

1. In Pipedream, open project `proj_qzsEPKG` and create an OAuth client (Settings → API → OAuth clients). Copy the client ID and secret.
2. Add these to your shell profile (not this repo):
   ```bash
   export PIPEDREAM_CLIENT_ID=...
   export PIPEDREAM_CLIENT_SECRET=...
   export PIPEDREAM_APP_SLUG=notion        # the app to expose; change any time
   export PIPEDREAM_EXTERNAL_USER_ID=dylan2045   # optional
   ```
3. Open Claude Code in this repo, approve `pipedream`, and run `/mcp` to check it connected.
4. The first time a tool needs an account, the server returns a Pipedream connect link. Open it and sign in to that app.

To switch apps, change `PIPEDREAM_APP_SLUG` and reconnect with `/mcp`. Find slugs at https://mcp.pipedream.com.

## Notes

- Production Connect may count toward Pipedream plan limits or billing. Check the project's plan before connecting many accounts; any upgrade is Dylan's call. (Unverified: free-tier production limits.)
- The OAuth client ID and secret are private. Never commit them or send them on the InterOp bus.
