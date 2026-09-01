#!/usr/bin/env bash
set -euo pipefail
fail=0
need(){ grep -Fq "$1" <<<"${PR_BODY:-}" || { echo "Missing PR heading: $1"; fail=1; }; }
need_any(){ for value in "$@"; do grep -Fq "$value" <<<"${PR_BODY:-}" && return 0; done; echo "Missing PR heading: $*"; fail=1; }
for x in '対象Issue' '実施内容' '変更ファイル' '検証コマンド' '懸念点' '対象外'; do need "$x"; done
need_any 'Handoff Summary' 'Handoff'
need_any '本番反映を含んでいないか' '本番反映なし'
need_any 'APIキー・秘密情報を変更していないか' 'secrets変更なし'
need_any '顧客データ・実データを投入していないか' '実データなし'
files=$(git diff --name-only "$BASE" "$HEAD")
if grep -Eiq '(^|/)(\.env($|\.)|.*\.(pem|key|mp3|wav|m4a|mp4|mov|jpg|jpeg|png|heic|csv|xlsx|xls)$|.*(credential|secret|service[-_]?account))' <<<"$files"; then echo 'Forbidden file detected'; fail=1; fi
added=$(git diff -U0 "$BASE" "$HEAD" | grep '^+' | grep -v '^+++' || true)
secret_names='API_?KEY|SECRET|TOKEN|ACCESS_?TOKEN|REFRESH_?TOKEN|PRIVATE_?KEY|SERVICE_?ACCOUNT|CLIENT_?SECRET|SUPABASE_SERVICE_ROLE_KEY|OPENAI_API_KEY|GOOGLE_CLIENT_SECRET|LINE_CHANNEL_ACCESS_TOKEN'
secret_value="[[:space:]]*[:=][[:space:]]*['\"]?[A-Za-z0-9_./+=-]{8,}"
if grep -Eiq "(sk-|xoxb-|ghp_|github_pat_|bearer[[:space:]]+[A-Za-z0-9]|($secret_names)$secret_value|password[[:space:]]*=)" <<<"$added"; then echo 'Potential secret detected'; fail=1; fi
phone_pattern='[0-9]{2,4}[- ][0-9]{2,4}[- ][0-9]{4}'
email_pattern='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
postal_pattern='[0-9]{3}-?[0-9]{4}'
prefecture_pattern='北海道|東京都|京都府|大阪府|[一-龠々]{2,3}県'
address_suffix_pattern='市|区|町|村|丁目|番地|号'
data=$(grep -Eio "($phone_pattern|$email_pattern|$postal_pattern|($prefecture_pattern).{0,40}($address_suffix_pattern))" <<<"$added" || true)
data=$(grep -Eiv '^(000-0000-0000|999-9999-9999|000-0000|999-9999|00000000000|99999999999|03-0000-0000|090-0000-0000|080-0000-0000|070-0000-0000|0120-000-000|.*@(example\.(com|jp|net)|test\.local|localhost))$' <<<"$data" || true)
if [ -n "$data" ]; then echo 'Potential personal or real data detected'; fail=1; fi
exit "$fail"
