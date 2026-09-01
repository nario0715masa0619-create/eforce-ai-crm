# 変更履歴

| 日付 | 種別 | 内容 | 承認者 |
| --- | --- | --- | --- |
| 2026-09-01 | 初期整備 | AI自律開発・品質管理基盤を追加。本体機能は未実装。 | 未承認 |
| 2026-09-01 | レビュー対応 | Claude Codeレビュー結果を受け、韓国旅行期間中の自律開発制限を明文化し、実装開始ゲート文書を追加。本体実装は未実施。 | 未承認 |
| 2026-09-01 | 実装開始ゲート | Claude Code再レビューPASSを受け、本体実装前の最初の設計Issue開始の承認ログを記録。「顧客・案件・訪問予定のデータ項目と画面構成」設計Issueを作成。業務アプリ本体は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Issue #1 設計整理 | 顧客・案件・訪問予定のデータ項目と関係性、顧客一覧・詳細、案件一覧・詳細、訪問スケジュール画面の表示項目、PC／スマホの優先度を整理。業務アプリ本体は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Phase 0.5 方針 | 本体設計より先にPhase 0.5開発環境整備を行う方針へ修正。Issue #1はPhase 0.5完了後に着手し、開発環境・CI・ブランチ運用・検証手順の整備Issueを作成。本体設計・本体実装は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Phase 0.5 レビュー対応 | Claude CodeレビューのPASS with concernsを受け、Node.js、pnpm、CI、環境分離、GitHub保護設定、ダミーデータ方針を明文化。最小アプリ雛形、CI実装、依存関係導入、本体設計・本体実装は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Phase 0.6 方針 | 人間ハブ型コピペ運用を避けるため、GitHub Issue／PR／docs／Actions／ラベルと将来のWebhook・Bot・MCP候補によるLevel 3半自動オーケストレーションを整理。ChatGPT共有を最小サマリー化。本体実装は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Memory方針 | LuviraMemoryをREAD限定の補助Contextとし、GitHub正本・直接WRITE禁止・HermesAgent将来検証候補を明文化。本体実装は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Phase 0.6-B Failover | 自律開発でAIクレジット切れ・停止・失敗が起きる前提を追加。GitHubを正本、Mem0を共有作業メモリとして別AIが引き継げるFailover／Handoff方針、Handoff Summaryテンプレート、Failover用プロンプトを追加。業務アプリ本体は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Phase 0.7 安全ゲート | Level 3最小自動化の実装範囲・安全ゲートを整理し、docs/14を追加。PR本文、禁止ファイル、secrets、実データ、Handoff、approved-for-workを初期候補とし、Mem0非接続時、exact_human未完成時、人間承認を整理。Actions、Bot、Webhook、MCP、Memory接続、HermesAgent、雛形、本体設計・実装は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Phase 0.8 安全チェック | Level 3最小自動化の第一弾としてPR本文、禁止ファイル、secrets、実データ検査をGitHub Actionsで実行する方針を追加。`.github/workflows/repository-safety-checks.yml` と `scripts/ci/repository-safety-checks.sh` を作成。自動ラベル・コメント・マージ・本番・Mem0・Bot/Webhook/MCP・本体実装は未実施。実PRでのAction実行確認は次レビュー対象。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | 運用逸脱 | Phase 0.8-BでIssue・テストPR未作成のまま一部修正をmainへ直接反映。Issue単位ブランチ・PR方針からの逸脱として記録し、残作業はIssue #5とPRで実施する。本体実装は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Process監視 | Phase 0.8-Bの運用逸脱と時間上限到達後の未コミット状態を受け、Issue／PR／承認／Handoff／docs／完了条件を監視するprocess-compliance-monitorを追加。project-governorとは別役割。本体実装・Actions・Memory接続は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Process監視レビュー対応 | PR #7レビューを受け、recovery neededと実行結果の記録場所を明確化。Issue #6／PR #7は専用スコープで、レビュー担当はproject-governor・security-reviewer・code-reviewer。approved-for-workは未付与のため人間承認または確認後にマージする。Phase 0.8-B残作業は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Issue #5 リカバリー | process-compliance-monitor確認により、Issue #5ブランチにPR #7相当の差分が残存していたためrecovery neededと判定。Issue #5をPhase 0.8-B専用状態へ戻すリカバリーを実施。Phase 0.8-B本体作業およびrepository-safety-checks修正は未再開・未実施。 | 未承認 |
| 2026-09-01 | Phase 0.8-B スコープ訂正 | Phase 0.8-Bを、業務アプリ本体ではない汎用的な開発前安全ゲートの最小調整として明確化。PR本文、禁止ファイル、secrets／token／key、一般的な個人情報・実データ混入防止のみを対象とし、業務ドメイン固有の検査は行わない。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | Phase 0.8-B 軽微修正 | PRテンプレートと必須項目チェックを整合し、必須見出しの空欄を拒否する確認、連続11桁電話番号らしき値の検出、自己検出回避の限界とcode-reviewer確認必須を追加。Git同梱Bashで構文、正常系、空欄拒否、代表パターンをローカル検証済み。業務固有検査、テストPR、GitHub Actions実行確認は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
| 2026-09-01 | PR #8 Actions修正 | PR #8のGitHub Actionsで `grep: Invalid collation character` が発生し、表面上passでも個人情報検出ブロックは実質未完了と判断。GitHub Actions互換の正規表現へ最小修正し、grepエラーを `|| true` で握りつぶさない制御へ変更。業務アプリ本体、workflow新規追加、本番反映は未実施。 | 株式会社ルヴィラ 代表 成相政和 |
