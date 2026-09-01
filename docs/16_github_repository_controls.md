# GitHubリポジトリ制御項目（Phase 0.9）

## 1. 現在確認すべきGitHub設定

- branch protection
- main direct push protection
- pull request required
- required status checks
- required review
- repository-safety-checks required化
- dismiss stale approvals
- restrict who can push
- secret scanning
- Dependabot / dependency alerts
- Actions permissions
- workflow permissions
- branch deletion policy

## 2. 現時点の扱い

AIはGitHub設定を勝手に変更しない。Phase 0.9では設定変更でなく、確認・文書化までを行う。不足はIssueまたは人間作業候補として記録する。Free/Public repositoryで利用できる機能に制約があり得るため、確認不能な設定は「未確認」として扱う。

## 3. 将来的に必須化したい保護設定

- mainへの直接push禁止
- PR必須
- repository-safety-checks通過必須
- 1件以上のレビュー必須
- 人間承認前のマージ禁止
- secrets / 実データ混入禁止
- force push禁止

これらの適用・変更には別Issueまたは人間承認を必要とする。

## 4. Actions / CI方針

現在の自動検証はrepository-safety-checksである。将来はlint / typecheck / test / buildを追加する。package.json未作成のため、現時点でアプリCIは未導入であり、アプリ雛形作成後にCI拡張Issueを作成する。CI失敗時はマージ禁止とし、CI passは安全保証ではない。

## 5. ラベル運用

現状、`status:approved-for-work`ラベルは存在せず、Human Approvalコメントを正式承認記録として扱う。

今後検討するラベルは次のとおり。

- `status:approved-for-work`、`status:in-progress`、`status:ready-for-review`
- `status:blocked`、`status:recovery-needed`、`status:handoff-needed`
- `risk:context-loss`、`risk:security`
- `scope:docs`、`scope:ci`、`scope:app`

ラベルを勝手に作らない。ラベル作成は別Issueまたは人間承認後に行う。

## 6. チェック結果の記録

GitHub設定確認結果、Actions結果、レビュー結果、Human Approval、Handoff Summary、Recovery記録、未確認項目は、次の正本へ残す。

| 記録 | 正本 |
| --- | --- |
| 作業範囲・承認・復旧状態 | Issueコメント |
| 変更、検証、Handoff、レビュー | PR本文・PRコメント |
| 永続する方針・開始ゲート | docs |
| 変更履歴 | `docs/10_change_log.md` |

必要に応じてHandoff SummaryをIssueまたはPRに追記する。チャット本文や補助メモリを唯一の記録先にしない。

## 未確認項目

Phase 0.9の確認時点で、実際のbranch protection、required checks / review、push制限、secret scanning、Dependabot、Actions / workflow permissions、branch deletion policyの有効状態は未確認として扱う。確認できない項目は人間による確認または別Issueで扱う。
