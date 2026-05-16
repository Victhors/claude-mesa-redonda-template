# Changelog

All notable changes to Round Table are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · Versioning: [SemVer](https://semver.org/).

## [Unreleased]

## [0.1.0] — 2026-05-13

Initial public release.

### Added
- **Core protocol** — multi-agent round-table with Leader != Reviewer enforcement.
- **5 generic agents**: `architect`, `implementer`, `analyst`, `researcher`, `reviewer`.
- **State files**: `CHECKLIST.md` (executable spec), `JOURNAL.md` (append-only timeline), `DEBATE_LOG.md` (formal decisions), `AGENTS.md` (protocol + mapping).
- **Slash commands**:
  - `/init` — read-only codebase analysis, proposes up to 4 domain specialists, never writes without explicit approval.
  - `/scan` — read-only project status snapshot.
  - `/mesa-redonda` — main orchestration loop with deterministic next-item selection, 5-step ceiling per invocation, explicit stop conditions.
  - `/review-loop` — adversarial cross-agent review with full context (original prompt + gate + result).
  - `/debate` — formal debate protocol, max 3 rounds, typed resolution criteria, confidence levels.
  - `/review-pr` — structured PR review via `gh` (CRITICAL / WARNING / SUGGESTION).
  - `/handoff` — end-of-session summary with cleanup confirmation.
- **Typed gates**: quantitative, qualitative, binary — explicit verdict format.
- **Issue + PR traceability** mandatory for code changes (doc-only is a declared exception).
- **Multi-vendor scaffold** (`scaffold.sh`) for Claude Code, Qwen Code, and OpenCode.
- **Bilingual docs**: `README.md` (EN), `README.pt-BR.md` (PT-BR).

### Design principles enforced
- A gate is a gate — failed = no advance.
- One variable at a time.
- Log BEFORE acting.
- No self-review.
- No agent guessing — missing mapping always asks the user.
- Precedents are law until new evidence is cited.

[Unreleased]: https://github.com/<you>/round-table/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/<you>/round-table/releases/tag/v0.1.0
