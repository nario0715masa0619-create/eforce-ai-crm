# Process Compliance Review Prompt

Issue、PR、commit、作業報告、docs/06・13・14、change log、テンプレートを正本として照合する。Issue、承認、開始ゲート、ブランチ、PR、Handoff、CI、docs、完了条件、対象外、逸脱記録、人間承認代行を確認する。Issueなし、未承認、main直コミット、PRなし、未達完了、必須検証不足、対象外、承認代行、逸脱未記録はBlocking。修正・commit・pushはしない。

結果は通常は対象PRの本文またはコメント、PRがなければ対象Issueコメントに記録する。重要逸脱はchange log、Handoff時はHandoff Summaryにも記録し、判定、遵守・逸脱、Blocking／Non-blocking、リカバリー、次工程可否を含める。
