# Phase 0.6: AIオーケストレーション Level 3

## 目的・現状課題

人間がCodex、Claude Code、ChatGPT間で長文プロンプトやレビュー結果を運ぶ人間ハブ型を避け、GitHub中心の半自動運用を定義する。現在はレビューがチャットに散在し、次工程判断・状態管理・プロンプト再利用がチャット依存であり、自律開発ではない。

## Level 3の目標と正本

Issue作成・承認・ブランチ・PR・CI・secrets／実データ検査・レビュー依頼・状態ラベル・ChatGPT共有要約をGitHub中心に半自動化する。Issueは作業指示、PRは差分・レビュー・検証結果、docsは仕様・方針・承認ログ、Actionsは自動検証の正本とする。ChatGPTは最終判断・例外処理の補助、チャット本文は正本にしない。

人間は重要判断、開始・仕様変更・本番反映・差し戻し・最終マージ判断に集中し、プロンプト再配達、レビュー全文転記、細かい状態管理、完了条件の反復確認を減らす。

## ラベル設計

- 種別: `type:docs` `type:design` `type:implementation` `type:review` `type:security` `type:ui` `type:infra` `type:ci` `type:bug`
- 状態: `status:draft` `status:needs-human-approval` `status:approved-for-work` `status:in-progress` `status:ready-for-review` `status:changes-requested` `status:ready-for-human` `status:approved` `status:blocked` `status:done`
- AI担当: `ai:codex` `ai:claude-code` `ai:chatgpt` `ai:project-governor` `ai:security-reviewer` `ai:ui-reviewer` `ai:documentation-manager`
- リスク: `risk:scope` `risk:security` `risk:secrets` `risk:data` `risk:db` `risk:external-integration` `risk:production` `risk:ui` `risk:ai-output`

## 状態遷移と開始条件

Issue: `draft → needs-human-approval → approved-for-work → in-progress → ready-for-review → ready-for-human → approved → done`。差し戻しは `ready-for-review → changes-requested → in-progress`、停止は任意状態から `blocked`。PR: `draft → ready-for-review → changes-requested / ready-for-human → approved → merged`。

AIはIssue、対象／対象外範囲、完了条件、レビュー担当、`status:approved-for-work` が揃い、必要時は実装開始ゲートの承認ログがあるまで開始しない。PRなしにレビューしない。

## Actions自動化候補（将来）

CIはlint、typecheck、test、build。PR本文はIssue、実施内容、変更ファイル、検証、未対応、懸念、ChatGPT要約を確認する。.env、秘密情報、顧客／実データ、録音音声、実写真、本番設定を禁止ファイルとして検査する。DB、認証、ストレージ、AI、Google連携、UI、本番、secrets差分は対応リスクラベルまたはレビュー要否を付与する。

## Webhook / Bot / MCP候補（将来）

Webhook／BotはIssueラベル付与、未承認作業停止、PRのIssue・担当表示、CI失敗時の差し戻し、security／UIレビュー要求、PR要約、changelog漏れ検査を候補とする。MCPはIssue・PR差分・コメント・CI取得、ChatGPT要約入力、次Issue・承認ログ候補生成を候補とする。今回これらを実装しない。
