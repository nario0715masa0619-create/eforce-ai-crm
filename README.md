# E-force AI CRM — Phase 1

出張買取業務の問い合わせ・顧客・案件・訪問を安全に管理するための、AI自律開発・品質管理基盤です。本リポジトリでは本体実装をまだ行いません。

## Phase 1 の範囲

録音音声を手動アップロードして行うAI文字起こし・情報抽出・要約、顧客／案件管理、訪問予定・訪問後報告、写真添付、Googleカレンダーへの一方向登録です。AI候補は必ず担当者が確認・修正・承認して登録します。

## Phase 0.5：開発環境整備

本体設計・本体実装の前に、開発環境、CI、ブランチ／PR運用、検証手順、secrets管理を整備します。Issue #1はPhase 0.5完了後に着手し、AI自律開発は開発環境と検証手順が整ってから開始します。

Node.jsはLTS版、package managerはpnpmを第一候補とします。CIでは lint / typecheck / test / build を確認し、local / staging / productionを分離します。開発・テストに顧客データ・実データは使用しません。mainへの直接コミットは原則禁止し、Issue単位ブランチとPRレビューを行います。GitHubブランチ保護・必須レビュー設定は人間が確認・設定します。

## Phase 0.6：Level 3オーケストレーション

人間ハブ型コピペ運用を避け、GitHub Issue／PR／docs／Actionsを正本にします。AIはIssue／PRを読んで作業・レビューし、ChatGPTには最小サマリーだけを渡します。人間は承認と重要判断に集中し、Webhook／Bot／MCPは将来候補として整理します。

LuviraMemoryはREAD限定の補助ContextでありProject Canonical Stateより優先しません。HermesAgent／Webhook／Bot／MCPは将来検証候補です。

AI停止・クレジット切れ時はGitHubを正本、Mem0を機微情報を含めない補助作業メモリとして別AIへ引継ぎます。引継ぎAIはGitHubを確認してから作業します。

## 重要前提

電話サービス・CTI・通話録音の自動取得、メール自動取込、Googleカレンダー双方向連携、既存予定取込、過去写真整理、大規模Excelクレンジング、スマホ専用アプリは対象外です。顧客情報とファイルはクラウド上で保護し、ログイン、基本権限、暗号化、アクセス制限、バックアップ、更新履歴を前提とします。

## AI自律開発・クロスレビュー

作業は1タスク単位で実施し、実装者以外が差分・セキュリティ・UI・仕様範囲を確認します。仕様にない内容は実装せず、人間に確認します。本番反映は必ず人間承認を必要とします。

## 主な資料

- [プロジェクト概要](docs/00_project_overview.md)
- [仕様確認書](docs/01_spec_confirmation.md)
- [画面構成確認書](docs/02_screen_confirmation.md)
- [重要前提](docs/04_important_assumptions.md)
- [セキュリティ方針](docs/05_security_policy.md)
- [開発方針（Phase 0.5）](docs/06_development_policy.md)
- [技術スタック候補](docs/12_technical_stack.md)
- [Level 3オーケストレーション](docs/13_ai_orchestration_level3.md)
- [韓国旅行期間中の自律開発方針](docs/08_korea_trip_dev_policy.md)
- [受入基準](docs/09_acceptance_criteria.md)
- [実装開始ゲート](docs/11_implementation_start_gate.md)
- [AIガバナンス](ai-governance/)

## 開発上の禁止事項

本体実装開始前に、実装開始ゲートで人間承認を記録します。2026年11月11日〜11月18日の韓国旅行期間中は、デバッグ、テスト、レビュー、軽微修正、文書整理に限定します。仕様外機能の追加、APIキー・秘密情報の変更、顧客／実データの投入、破壊的DB変更、本番反映を許可なく行いません。本番反映は人間承認なしに行わないことを徹底します。
