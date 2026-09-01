#!/usr/bin/env bash
set -euo pipefail
fail=0
need(){ grep -Fq "$1" <<<"${PR_BODY:-}" || { echo "Missing PR heading: $1"; fail=1; }; }
for x in '対象Issue' '実施内容' '変更内容' '変更ファイル' '検証コマンド' '検証結果' '未対応範囲' '懸念点' 'Handoff Summary' 'ChatGPT共有用サマリー' '本番反映を含んでいないか' 'APIキー・秘密情報を変更していないか' '顧客データ・実データを投入していないか' '対象外機能を追加していないこと'; do need "$x"; done
files=$(git diff --name-only "$BASE" "$HEAD")
if grep -Eiq '(^|/)(\.env($|\.)|.*\.(pem|key|mp3|wav|m4a|mp4|mov|jpg|jpeg|png|heic|csv|xlsx|xls)$|.*(credential|secret|service[-_]?account))' <<<"$files"; then echo 'Forbidden file detected'; fail=1; fi
added=$(git diff -U0 "$BASE" "$HEAD" | grep '^+' | grep -v '^+++' || true)
if grep -Eiq '(sk-|xoxb-|ghp_|github_pat_|bearer[[:space:]]+[A-Za-z0-9]|OPENAI_API_KEY[[:space:]]*=|SUPABASE_SERVICE_ROLE_KEY[[:space:]]*=|VERCEL_TOKEN[[:space:]]*=|password[[:space:]]*=)' <<<"$added"; then echo 'Potential secret detected'; fail=1; fi
data=$(grep -Eio '([0-9]{2,4}-[0-9]{2,4}-[0-9]{4}|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})' <<<"$added" || true); data=$(grep -Eiv '^(000-0000-0000|999-9999-9999|00000000000|99999999999|.*@(example\.(com|jp|net)|test\.local|localhost))$' <<<"$data" || true); if [ -n "$data" ]; then echo 'Potential real data detected'; fail=1; fi
exit "$fail"
