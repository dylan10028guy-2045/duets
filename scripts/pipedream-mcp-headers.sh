#!/usr/bin/env bash
# Prints the HTTP headers Claude Code sends to Pipedream's MCP server.
# Claude Code runs this as the server's headersHelper on each connection,
# so the short-lived access token is always fresh.
#
# Reads from your shell environment (never from this repo):
#   PIPEDREAM_CLIENT_ID, PIPEDREAM_CLIENT_SECRET  (Pipedream OAuth client)
#   PIPEDREAM_APP_SLUG          app to expose, e.g. notion, gmail, linear
#   PIPEDREAM_EXTERNAL_USER_ID  optional, defaults to "dylan2045"
set -euo pipefail

PROJECT_ID="proj_qzsEPKG"
ENVIRONMENT="production"

: "${PIPEDREAM_CLIENT_ID:?set PIPEDREAM_CLIENT_ID in your shell profile}"
: "${PIPEDREAM_CLIENT_SECRET:?set PIPEDREAM_CLIENT_SECRET in your shell profile}"
: "${PIPEDREAM_APP_SLUG:?set PIPEDREAM_APP_SLUG, e.g. notion}"
EXTERNAL_USER_ID="${PIPEDREAM_EXTERNAL_USER_ID:-dylan2045}"

TOKEN=$(
  curl -sf -X POST https://api.pipedream.com/v1/oauth/token \
    -H "Content-Type: application/json" \
    -d "$(python3 -c 'import json,os; print(json.dumps({"grant_type":"client_credentials","client_id":os.environ["PIPEDREAM_CLIENT_ID"],"client_secret":os.environ["PIPEDREAM_CLIENT_SECRET"]}))')" |
  python3 -c 'import json,sys; print(json.load(sys.stdin)["access_token"])'
)

TOKEN="$TOKEN" PROJECT_ID="$PROJECT_ID" ENVIRONMENT="$ENVIRONMENT" EXTERNAL_USER_ID="$EXTERNAL_USER_ID" \
python3 -c 'import json,os; print(json.dumps({
  "Authorization": "Bearer " + os.environ["TOKEN"],
  "x-pd-project-id": os.environ["PROJECT_ID"],
  "x-pd-environment": os.environ["ENVIRONMENT"],
  "x-pd-external-user-id": os.environ["EXTERNAL_USER_ID"],
  "x-pd-app-slug": os.environ["PIPEDREAM_APP_SLUG"],
}))'
