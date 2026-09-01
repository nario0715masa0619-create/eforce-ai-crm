# Level 3オーケストレーション方針

## 目的・正本

人間ハブ型のプロンプト・レビュー転送を避け、GitHub Issue／PR／docs／Actionsを正本とする半自動運用を定義する。Issueは作業指示、PRは差分・レビュー・検証、docsは仕様・方針・承認ログ、Actionsは自動検証の正本である。ChatGPTは最終判断・例外処理の補助であり、チャット本文を正本にしない。

Level 3ではIssue承認、ブランチ、PR本文・CI、secrets／実データ検査、レビュー依頼、ラベル更新、最小ChatGPT要約を半自動化候補とする。人間は開始・仕様変更・本番・最終マージ等の重要判断に集中する。

## LuviraMemory: Partial／READ限定

LuviraMemoryはHuman-managed KnowledgeとSupplemental MemoryのREAD基盤としては利用可能だが、exact_human最終E2E、Repository同期、陳腐化検知、大量・長期運用、Codex／Claude Code直接参照は未確認または未完成であるため判定は**Partial**とする。E-forceではLuvira Context Gateway経由で共通方針、経営・製品・運用・技術知識、AIルール、過去判断、逸脱パターン、再利用プロンプト、レビュー要約、失敗事例を補助参照する。

Authorityは `Project Canonical State > Human-managed Knowledge > Supplemental Memory`。リポジトリの仕様、Issue、PR、承認ログを最優先する。Memoryを正式事実・Canonical・GitHub docs代替として扱わず、不可逆操作の単独根拠にしない。Human Approvalを代行せず、Human Knowledge／Obsidianへ直接WRITEしない。Knowledge候補は `E-force → Knowledge Intake Proposal → Human Approval → Commit → ObsidianへCREATE` に限定する。APIキー、秘密情報、実顧客データ、個人情報、録音音声、写真を保存しない。

## HermesAgent

HermesAgentは採用前提でなく将来検証候補とする。GitHub Issue／PR読取、Context Gateway READ、Memory WRITE防止、承認ゲート、役割分担、secrets／実データ制限、実行ログ、Windows／クラウド安定性、納期影響を検証し、これらと人間作業削減を満たすまで中核にしない。

## ラベル・状態・自動化候補

種別: `type:docs type:design type:implementation type:review type:security type:ui type:infra type:ci type:bug type:orchestration`。状態: `status:draft → status:needs-human-approval → status:approved-for-work → status:in-progress → status:ready-for-review → status:ready-for-human → status:approved → status:done`。差戻しは `ready-for-review → changes-requested → in-progress`、停止は任意状態から`blocked`。AI: `ai:codex ai:claude-code ai:chatgpt ai:project-governor ai:security-reviewer ai:ui-reviewer ai:documentation-manager`。リスク: `risk:scope risk:security risk:secrets risk:data risk:db risk:external-integration risk:production risk:ui risk:ai-output risk:memory-authority`。

AIはIssue、対象・対象外、完了条件、レビュー担当、`approved-for-work`、必要な開始ゲート、Memory READ明記が揃うまで開始しない。PRはdraft→review→changes-requested/ready-for-human→approved→mergedで運用する。将来Actionsはlint/typecheck/test/build、PR本文、禁止ファイル、DB・認証・ストレージ・AI・Google・UI・本番・secrets・Memory authorityリスク検出を扱う。Webhook／Bot／MCPはラベル、CI差戻し、レビュー要求、要約、Issue/PR/CI取得を将来候補とし、今回実装しない。

## AI Failover / Credit Exhaustion Handoff

担当AIは交換可能であり、クレジット切れ、上限、エラー、応答停止、PR途中停止を前提にする。GitHubを正本、Mem0を補助共有作業メモリとし、Mem0は仕様・承認ログ・Canonical Stateにしない。引継ぎAIはMem0で状況把握後、GitHubで確認し、迷えば`blocked`または`needs-human-approval`にする。

GitHubにはIssue/PR URL、branch、commit、PR本文、CI・レビュー、Blocking/Non-blocking、未対応、承認ログを残す。Mem0にはフェーズ、URL、branch、commit、状態、完了/未完了、検証、論点、最初に読むファイル、触れない範囲、次アクションだけを残す。APIキー、認証、顧客実データ・個人情報、録音・写真、契約原文、正式承認ログ、Canonical代替は残さない。

状態は`normal → ai-paused / ai-credit-exhausted / ai-error → handoff-needed → handoff-accepted → in-progress → ready-for-review`。判断不能は`handoff-needed → blocked`、人間承認待ちは`needs-human-approval`。ラベルは`status:handoff-needed` `status:handoff-accepted` `status:ai-paused` `status:ai-credit-exhausted` `status:ai-error` `risk:handoff` `risk:context-loss`を追加する。

開始時と区切りごとに対象・対象外、検証、変更、完了/未完了、論点、次作業をMem0へ（未利用時はPR/Issueへ）記録する。停止時はIssue/PR、branch、commit、状態、変更、検証、論点、次アクション、触れない範囲をSummaryとして残す。突然停止時はIssue、PR差分、commit、CI、change log、Mem0の順に復元し、不明なら停止する。引継ぎAIは未承認作業、仕様変更、破壊的DB、本番、秘密情報変更、実データ投入、Mem0単独の不可逆操作、承認代行をしない。

## Phase 0.7 最小自動化範囲・安全ゲート

ActionsやBotの前に、自動化範囲、非自動化範囲、安全ゲート、停止条件、人間承認を固定する。正本は [最小自動化範囲](14_level3_minimum_automation_scope.md)。初期候補はラベル、PR本文、禁止ファイル、secrets、実データ、Handoff、approved-for-work、changelog、大差分、CI確認であり、Memory接続、HermesAgent、Bot／Webhook／MCP、本体設計・実装は行わない。

## process-compliance-monitor

AI作業プロセス遵守の専任監視役。Issue／PR／approved-for-work／Handoff／docs／change log／完了条件を確認し、Issueなし、PRなし、main直コミット、未達完了を検出する。project-governorは仕様逸脱・対象外機能、process-compliance-monitorは進め方を監視する。
