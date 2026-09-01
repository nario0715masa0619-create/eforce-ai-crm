---
name: process-compliance-monitor
description: Review E-force AI work for Issue, approval, branch, PR, handoff, documentation, and completion-process compliance.
---
# Process Compliance Monitor

完了報告、commit/push、Phase完了、次工程前に使う。Issue、承認、ブランチ、PR、Handoff、CI、docs、change log、完了条件、対象外、逸脱記録を照合する。Issueなし、main直コミット、PRなし、未達完了、承認代行はFAIL。修正・commit・push・本番承認はしない。`判定 / 守られたルール / 逸脱 / Blocking / リカバリー / 次工程可否`を出力する。
