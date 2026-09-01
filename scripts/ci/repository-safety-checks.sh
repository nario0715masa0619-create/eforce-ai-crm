#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C
fail=0
require_answer(){
  local heading="$1" content meaningful
  if ! grep -Fqx "## $heading" <<<"${PR_BODY:-}"; then
    echo "Missing PR heading: $heading"
    fail=1
    return
  fi
  content=$(awk -v heading="## $heading" '$0 == heading {found=1; next} found && /^##[[:space:]]/ {exit} found {print}' <<<"${PR_BODY:-}")
  meaningful=$(sed -E '/^[[:space:]]*$/d; /^[[:space:]]*[-*][[:space:]]*$/d; /^[[:space:]]*[-*]?[[:space:]]*\[[ xX]\][[:space:]]*$/d' <<<"$content")
  if ! grep -q '[^[:space:]]' <<<"$meaningful"; then
    echo "Empty PR section: $heading"
    fail=1
  fi
}
for x in '対象Issue' '実施内容' '変更ファイル' '検証コマンド' '懸念点' 'Handoff Summary' '対象外' '本番反映' 'secrets変更' '実データ使用'; do require_answer "$x"; done
files=$(git diff --name-only "$BASE" "$HEAD")
if grep -Eiq '(^|/)(\.env($|\.)|.*\.(pem|key|mp3|wav|m4a|mp4|mov|jpg|jpeg|png|heic|csv|xlsx|xls)$|.*(credential|secret|service[-_]?account))' <<<"$files"; then echo 'Forbidden file detected'; fail=1; fi
# This script's detection patterns are reviewed as code; exclude them from content scanning to avoid self-matches.
added=$(git diff -U0 "$BASE" "$HEAD" -- . ':(exclude)scripts/ci/repository-safety-checks.sh' | grep '^+' | grep -v '^+++' || true)
secret_names='API_?KEY|SECRET|TOKEN|ACCESS_?TOKEN|REFRESH_?TOKEN|PRIVATE_?KEY|SERVICE_?ACCOUNT|CLIENT_?SECRET|SUPABASE_SERVICE_ROLE_KEY|OPENAI_API_KEY|GOOGLE_CLIENT_SECRET|LINE_CHANNEL_ACCESS_TOKEN'
secret_value="[[:space:]]*[:=][[:space:]]*['\"]?[A-Za-z0-9_./+=-]{8,}"
if grep -Eiq "(sk-|xoxb-|ghp_|github_pat_|bearer[[:space:]]+[A-Za-z0-9]|($secret_names)$secret_value|password[[:space:]]*=)" <<<"$added"; then echo 'Potential secret detected'; fail=1; fi
phone_pattern='([0-9]{2,4}[- ][0-9]{2,4}[- ][0-9]{4}|0(50|70|80|90)[0-9]{8})'
email_pattern='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
postal_pattern='[0-9]{3}-?[0-9]{4}'
prefecture_pattern='北海道|東京都|京都府|大阪府'
address_suffix_pattern='市|区|町|村|丁目|番地|号'
if data=$(grep -Eio "($phone_pattern|$email_pattern|$postal_pattern|($prefecture_pattern).{0,40}($address_suffix_pattern))" <<<"$added"); then
  :
else
  status=$?
  if [ "$status" -eq 1 ]; then data=''; else echo "Personal-data pattern check failed (grep exit $status)" >&2; exit 1; fi
fi
if [ -n "$data" ]; then
  if data=$(grep -Eiv '^(000-0000-0000|999-9999-9999|000-0000|999-9999|0000000|9999999|00000000000|99999999999|03-0000-0000|090-0000-0000|080-0000-0000|070-0000-0000|0120-000-000|.*@(example\.(com|jp|net)|test\.local|localhost))$' <<<"$data"); then
    :
  else
    status=$?
    if [ "$status" -eq 1 ]; then data=''; else echo "Dummy-data filter failed (grep exit $status)" >&2; exit 1; fi
  fi
fi
if [ -n "$data" ]; then echo 'Potential personal or real data detected'; fail=1; fi
exit "$fail"
