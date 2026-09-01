# 自律開発運用環境（Phase 0.9）

## 1. 位置づけ

Phase 0.9は業務アプリ本体開発ではなく、自律開発を開始する前の運用環境整備である。`repository-safety-checks`だけで自律開発環境とは言えず、process-compliance-monitorだけでも自動監視環境とは言えない。

GitHub Issue、PR、docs、Actionsを正本として、Issue、Branch、PR、CI、Review、Handoff、Recovery、Human Approvalを一体で運用する。

## 2. 自律開発の標準フロー

1. Issue作成
2. Human Approval記録
3. 正規ブランチ作成
4. 実装または文書作業
5. ローカル検証
6. commit / push
7. PR作成
8. GitHub Actions実行
9. code-reviewer確認
10. security-reviewer確認
11. process-compliance-monitor確認
12. 必要時project-governor確認
13. 人間承認
14. merge
15. Issue close
16. change log更新
17. 次Issue選定

各工程はIssueの対象範囲・対象外範囲・完了条件を満たすことを前提とする。人間承認、merge、本番反映はAIが代行しない。

## 3. AI作業状態

| 状態 | 意味・入る条件 | 次に進む条件 | 人間承認 |
| --- | --- | --- | --- |
| proposed | 作業候補。Issueはあるが開始承認前。 | 範囲・対象外・完了条件を確認し、承認記録を残す。 | 必要 |
| approved-for-work | 人間承認済みで開始可能。ラベルがない場合はIssueコメントを正本とする。 | 正規ブランチを作成して作業を開始する。 | 開始時に必要 |
| in-progress | 承認済み範囲で正規ブランチ上の作業中。 | 検証・記録を完了しPRを作成する。 | 不要 |
| ready-for-review | PRと検証結果がそろいレビュー待ち。 | 必要なレビューがPASSとなる。 | 不要 |
| changes-requested | レビューで修正または説明が求められた。 | 承認範囲内で対応し再検証する。 | 範囲変更時に必要 |
| blocked | 正本、範囲、検証、判断のいずれかが不足して停止中。 | 不足を解消するか人間判断を得る。 | 原則必要 |
| recovery-needed | 誤リポジトリ、誤ブランチ、未記録中断等の状態復旧が必要。 | 実装修正より先にCanonical Stateを復元する。 | 状況により必要 |
| handoff-needed | 担当AIが継続できず引継ぎが必要。 | Handoff Summaryを残し、次AIがGitHub正本を確認する。 | 不要。ただし範囲判断は必要 |
| ready-for-human-approval | レビュー・CI・完了条件を満たし、マージ判断待ち。 | 人間がマージ可否を記録する。 | 必要 |
| approved-for-merge | 人間が対象PRのマージを承認済み。 | 承認範囲のPRだけをマージする。 | 必要 |
| merged | PRがmainへマージ済み。 | Issueの完了記録とchange logを確認する。 | 不要 |
| closed | Issueの完了条件と記録が確認済み。 | 次Issueを選定する。 | Issue close時に必要 |

## 4. AIが自律的に進めてよい範囲

- 承認済みIssueの範囲内
- 正規ブランチ上の作業
- 明示された変更許可ファイル
- ローカル検証
- commit / push
- PR作成
- レビュー依頼用コメント、Handoff Summaryの作成

ただし、Human Approval、merge、本番反映はAIが代行不可である。

## 5. AIが止まるべき条件

次はBlockingとして作業を停止し、`blocked`または`recovery-needed`を記録する。

- 正しいリポジトリでない、正規ブランチでない、working treeが不明
- main / origin/mainが不一致
- IssueまたはHuman Approvalがない
- 許可範囲外ファイル変更、secrets・実データへの接触が必要
- 業務アプリ本体へ進む可能性がある、GitHub設定変更が必要
- Actions失敗、レビューFAIL、Handoff不足、recovery-needed
- path解決エラー、AIクレジット切れ、時間上限

## 6. クロスレビュー運用

- code-reviewerは実装品質と保守性を確認する。
- security-reviewerはsecrets、実データ、個人情報、権限、外部連携リスクを確認する。
- process-compliance-monitorはIssue、承認、ブランチ、PR、検証、完了条件など進め方を監視する。
- project-governorはスコープと仕様逸脱を確認する。

AI単独の完了判定は禁止し、マージ前は必ず人間承認を必要とする。

## 7. Handoff / Recovery

AI停止時はHandoff Summaryを必須とし、Issue / PR URL、branch、commit、完了・未完了、検証、懸念点、次作業、触れてはいけない範囲を残す。別AIはGitHub正本を確認してから復元する。

`recovery-needed`では実装修正より状態復旧を先に行う。誤リポジトリ、誤ブランチ、main直コミット、未承認作業は直ちに停止する。

## 8. 現在の自律開発レベル判定

現在は **Level 2.5** と判定する。repository-safety-checks、PRテンプレート、manual reviewer運用、process-compliance-monitorは整備済みだが、Bot / Webhook / MCP / HermesAgentによる自動実行は未実装であり、GitHub branch protection、PR必須、required checks / reviewの実適用も未確認である。

Level 3に近づくためには、branch protection、PR必須、required checks、required reviewの確認、process-compliance-monitorの運用組込み、Handoff / Recoveryテンプレート運用、状態遷移ルールの定着が必要である。
