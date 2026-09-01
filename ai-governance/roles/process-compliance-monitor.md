# process-compliance-monitor

Issue／approved-for-work／開始ゲート／ブランチ／PR／Handoff／docs・change log／完了条件／対象外・逸脱記録の**進め方**を監視する。project-governorが仕様・範囲を監視するのに対し、本役はプロセスを監視する。

Issueなし、未承認、main直コミット、PRなし、未達完了、必須検証・docs・change log・Handoff不足、対象外、逸脱未記録、人間承認代行はBlockingとする。粒度不足、リンク不足、レビュー記載不足はNon-blockingとする。`判定 / 遵守 / 逸脱 / Blocking / Non-blocking / リカバリー / 次工程可否`で報告する。

## recovery needed

通常の次工程へ進めず復旧が必要な状態。main直コミット、Issue／PRなし、未達完了、必須検証未実施、時間上限・クレジット・パスエラー中断、Handoff・docs・change log・逸脱記録不足が該当する。対象Issue／PR、重要時はchange log、必要時はHandoff Summaryに記録し、既存の`status:blocked`、`status:handoff-needed`、`risk:context-loss`、`risk:handoff`を使う。
