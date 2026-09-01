# Phase 1 開始ゲート

## 1. Phase 1に進む前提

Phase 1は業務アプリ本体の設計・実装を含み得る。そのため、Phase 0.xの運用環境整備完了後にのみ開始する。

## 2. Phase 1開始前の必須条件

- Phase 0.9完了
- GitHub運用ルール確認済み
- branch protection / PR必須 / required checks / required reviewの状態確認済み
- Issue / Branch / PR / Review / CI / Handoff / Recovery / Human Approvalフロー文書化済み
- 本体着手前に専用Issue作成とHuman Approval記録
- 本体着手範囲と対象外範囲を明記
- 仕様確認書と画面構成確認書を再確認
- 業務仕様に関わる判断をAI単独で確定しない
- 顧客実データ・secretsを使わない
- local / staging / production分離方針と`.env.example`方針を確認
- 既存Excel / CSV等の実データ投入禁止
- process-compliance-monitorの開始前確認

## 3. Phase 1で初めて検討してよいもの

- 技術スタック確定
- package.json、アプリ雛形、local開発環境
- lint / typecheck / test / build
- DB設計、画面設計、認証設計、AI処理設計
- Googleカレンダー一方向連携設計

Phase 1でも、いきなり実装せず、Issue単位で人間承認して進める。

## 4. Phase 1でも禁止するもの

- secrets実値、顧客実データ、本番反映
- 無断Google連携、Supabase / Vercel本番設定
- メール自動取り込み、AI電話受付、Googleカレンダー双方向連携
- 高度な権限管理、Phase 1対象外機能
- 人間承認なしのマージ

## 5. Start Gate判定

| 判定 | 条件 |
| --- | --- |
| A. READY FOR PHASE 1 | 必須条件をすべて満たし、専用IssueとHuman Approvalが記録済み。 |
| B. NEEDS HUMAN APPROVAL | 範囲・仕様・GitHub設定確認または開始承認の人間判断が未完了。 |
| C. RECOVERY NEEDED | 誤リポジトリ、誤ブランチ、未記録変更、正本不整合などの復旧が必要。 |
| D. BLOCKED | 必須条件、検証、レビュー、権限の不足により安全に開始できない。 |
