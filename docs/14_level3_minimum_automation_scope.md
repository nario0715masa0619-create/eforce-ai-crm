# Level 3最小自動化の実装範囲・安全ゲート

GitHubを正本とし、最初はGitHub上の機械的検査だけを自動化候補にする。承認代行、仕様変更、本番、PR自動マージ、Mem0／Human Knowledge WRITE、顧客送信、契約・支払判断、Production secrets、DB破壊的変更は自動化しない。

## 初期対象と順序

1. labels定義 2. PR本文 3. 禁止ファイル 4. secrets 5. 実データ 6. Handoff Summary 7. approved-for-work 8. changelog 9. 大差分 10. lint/typecheck/test/build（雛形後）。初期ラベルは既定のtype、status、ai、risk全ラベル（handoff／context-lossを含む）とする。

PRは対象Issue、実施・変更・検証、未対応、懸念、Handoff、ChatGPT要約、本番・secrets・実データ・対象外なしを必須とし、不足はchanges-requested/blockedでマージ不可。`.env`、秘密設定、実データCSV/Excel/JSON、録音、実写真、credential/private/service-account key検出時は失敗、security review、人間判断とする。API key/token/secret/password等と一般的な個人情報・実データも同様に扱う。

Issue、範囲、対象外、完了、レビュー、approved-for-work、必要な開始ゲートがなければ開始しない。Actions失敗、Handoff不足、CI失敗、changelog漏れ、Issue不明はマージ不可。仕様・対象外・DB・本番・secrets・実データ・Memory authority疑義は人間確認とする。

Mem0未接続時はIssue、PR Handoff Summary、Issueコメント、change log、URL/commit/要約で記録し、未記録のまま作業しない。exact_human完成までモデル転記を原文完全保持とせず、契約・法的・正式方針・声明・顧客文書は原文ファイルと差分、人間確認を正としMemory要約を代替にしない。

実装開始、仕様、対象外、本番、DB破壊、secrets rotation、実データ、顧客文書、Knowledge登録、Mem0、HermesAgent、Bot/Webhook/MCP、PRマージは人間承認を必要とする。

## Phase 0.8 実装済み第一弾

GitHub ActionsによるPR本文、禁止ファイル、secrets、実データ混入の最小安全チェックを導入した。今回は検査と失敗までに限定し、自動ラベル、コメント、マージは行わない。誤検知やsecrets／実データ検出は人間判断へ戻し、security-reviewer確認を必要とする。Actionは最小権限で実行し、実際のPR上での実行確認は次レビュー対象とする。

## Phase 0.8-B 汎用安全ゲートの最小調整

Phase 0.8-Bは開発環境整備・安全ゲート整備であり、E-force様業務アプリ本体の仕様・設計・実装ではない。repository-safety-checksの対象は、PR本文、禁止ファイル、secrets／token／keyらしき値、一般的な個人情報らしき値（メールアドレス、電話番号、郵便番号、住所）および実データ混入リスクに限定する。明示的なダミーデータは許容する。

業務ドメイン固有の検査は行わない。このチェックは人間レビュー、security-reviewer、code-reviewer、process-compliance-monitorを代替しない。
