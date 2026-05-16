<div align="center">

# Round Table

### A spec-driven, adversarial multi-agent framework for AI coding assistants.

**Because "the agent said it works" is not a quality gate.**

[![Works with Claude Code](https://img.shields.io/badge/works%20with-Claude%20Code-d97757)](https://claude.com/claude-code)
[![Works with Qwen](https://img.shields.io/badge/works%20with-Qwen%20Code-7c3aed)](https://github.com/QwenLM/qwen-code)
[![Works with OpenCode](https://img.shields.io/badge/works%20with-OpenCode-22c55e)](https://opencode.ai)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#contributing)

[Quickstart](#quickstart) · [Why](#why-round-table) · [How it works](#how-it-works) · [Commands](#commands) · [Philosophy](#philosophy) · [FAQ](#faq) · [Português](README.pt-BR.md)

</div>

---

## Quickstart

```bash
git clone https://github.com/<you>/round-table
./round-table/scaffold.sh ~/your-project
```

Then, inside your project:

```bash
/init           # analyzes your stack, proposes specialized agents
/mesa-redonda   # runs the round-table loop
```

That's it. **Markdown and bash. Zero runtime dependencies. No vendor lock-in.**

---

## Why Round Table?

Most agentic coding workflows in 2026 share three diseases:

| Disease | What happens |
|---|---|
| **One agent does everything** | It writes, tests, and approves its own code. No adversary, no brake. |
| **"Done" means nothing** | The agent declares success without an objective gate. You discover the lie in production. |
| **Decisions evaporate** | Architecture choices vanish between sessions. Everything gets re-litigated. |

Round Table is the cure:

- **Multiple agents** with non-overlapping roles (architect, implementer, analyst, researcher, reviewer + domain specialists).
- **Leader != Reviewer.** Whoever does the work never approves it.
- **Typed gates** (quantitative / qualitative / binary). Literal `PASS` / `FAIL` verdicts.
- **Spec-driven (SDD).** `CHECKLIST.md` is your executable spec. Each item has a gate.
- **Formal debate** when a gate fails or a non-trivial decision arises — recorded in `DEBATE_LOG.md` with citations and a confidence level.
- **Issue + PR traceability** for any code change.
- **Cross-session memory** via append-only `JOURNAL.md` and numbered `DEBATE_LOG.md`.

It's just **markdown and bash**. No server, no exotic dependency, no lock-in.

---

## How it compares

| | Round Table | CrewAI / AutoGen | LangGraph | Plain Claude Code |
|---|:-:|:-:|:-:|:-:|
| Multi-agent | ✅ | ✅ | ✅ | ❌ |
| Adversarial review (Leader != Reviewer) | ✅ | ❌ | ❌ | ❌ |
| Typed quality gates | ✅ | ❌ | ❌ | ❌ |
| Spec-driven (executable checklist) | ✅ | ❌ | ❌ | ❌ |
| Formal debate protocol | ✅ | ❌ | ❌ | ❌ |
| Cross-session memory (file-based) | ✅ | ❌ | partial | partial |
| Zero runtime dependencies | ✅ | ❌ | ❌ | ✅ |
| Works across CLI vendors | ✅ | n/a | n/a | ❌ |

Round Table isn't trying to replace LangGraph for production agent pipelines. It's the **discipline layer** for AI-assisted *development* — where humans still drive and agents must earn trust.

---

## How it works

### Auto-setup

```bash
/init
```

`/init` runs a **read-only** analysis of your codebase and proposes:

- Detected stack (manifests, frameworks, domain inference)
- Up to **4 domain-specialized agents** on top of the 5 generic ones
- Stage → Leader → Reviewer mapping
- An initial CHECKLIST with phases and gates

**Nothing is written without your explicit approval.** No guessing, no overwriting customizations.

### The main loop

```bash
/scan            # read-only project status
/mesa-redonda    # orchestrate: pick next item, delegate leader, run reviewer
/debate <topic>  # when a gate fails or a decision is non-trivial
/review-loop X   # adversarial review on a specific deliverable
/review-pr 123   # structured PR review via gh CLI
/handoff         # end-of-session summary
```

`/mesa-redonda` iterates with a **5-step ceiling per invocation** (periodic human supervision) and stops automatically on unresolved FAIL.

### Anatomy of one step

```
1. Orchestrator reads CHECKLIST → picks next item (deterministic rule)
2. Pre-logs to JOURNAL: [ts] orchestrator → delegating "X" to <leader>
3. Invokes <leader> with context + task + gate + expected output
4. Invokes <reviewer> with original prompt + gate + leader's result
5. APPROVED  → marks [x], creates Issue+PR (if code changed), advances
   REJECTED  → retry; second rejection → /debate
6. Post-logs leader↔reviewer dialogue in JOURNAL
```

---

## Commands

| Command | What it does |
|---|---|
| `/init` | Analyzes the codebase, proposes specialized agents, fills templates |
| `/scan` | Read-only snapshot: CHECKLIST, JOURNAL, git, open debates |
| `/mesa-redonda` | Main orchestration: delegate leader, trigger reviewer, log everything |
| `/review-loop <X>` | Cross-agent adversarial review on `<X>` |
| `/debate <topic>` | Formal debate in up to 3 rounds with explicit resolution criteria |
| `/review-pr <N>` | Structured PR review via `gh` (CRITICAL / WARNING / SUGGESTION) |
| `/handoff` | Append end-of-session summary to JOURNAL |

---

## Architecture

```
your-project/
├── .claude/                  Claude Code
│   ├── agents/               agent personas (architect, implementer, ...)
│   ├── commands/             slash commands (mesa-redonda, debate, ...)
│   └── settings.json         permissions
├── .qwen/                    Qwen Code (mirror)
│
├── AGENTS.md                 protocol + Stage→Leader→Reviewer table (also read by OpenCode)
├── CLAUDE.md  / QWEN.md      project instructions per agent
├── CHECKLIST.md              executable spec (each item has a gate)
├── JOURNAL.md                append-only timeline (cross-session)
└── DEBATE_LOG.md             formal decisions with reasoning
```

### State files

- **`CHECKLIST.md`** — your spec. Each `[ ]` is a stage with a gate type. Mark `[x]` only after reviewer APPROVAL.
- **`JOURNAL.md`** — append-only with ISO timestamps. Pre-log **before** acting, post-log with verdict.
- **`DEBATE_LOG.md`** — numbered debates. HIGH-confidence decisions migrate to `AGENTS.md → Permanent Decisions`.
- **`AGENTS.md`** — who we are, who reviews whom, what's already decided.

### Generic agents

| Agent | Role | Executes code? |
|---|---|---|
| **architect** | design, tradeoffs, decisions | no |
| **implementer** | writes code, builds, runs scripts | yes |
| **analyst** | measures, tests, validates quantitatively | yes (measurement) |
| **researcher** | SOTA, benchmarks, external evidence | no |
| **reviewer** | gates, compliance, code review | no |

`/init` adds up to 4 specialists per your domain (e.g. `frontend-engineer`, `database-specialist`, `data-curator`).

---

## Philosophy

### The 10 commandments

1. **A gate is a gate.** Failed = no advance.
2. **One variable at a time.** Never change two things at once.
3. **Log BEFORE acting.** JOURNAL pre-entry mandatory.
4. **Data beats opinions.** Metric/test decides whenever it exists.
5. **No self-review.** A leader never approves themselves.
6. **Debate caps at 3 rounds.** No convergence → escalate to human.
7. **No agent guessing.** No mapping → ask the user.
8. **Issue + PR for code changes.** Doc-only is a declared exception.
9. **Precedents are law** until new evidence is cited.
10. **5-step ceiling per invocation.** Periodic human supervision.

### Spec-driven, not vibe-coding

You write the spec once (`CHECKLIST.md` with gates). The agent loop executes against it. If it didn't pass the gate, it wasn't done — regardless of what the agent claimed.

### Multi-vendor by design

The same files run on **Claude Code**, **Qwen Code**, and **OpenCode** (which natively reads `AGENTS.md`). You're not locked to a single vendor.

---

## Minimal CHECKLIST example

```markdown
## Phase 1 — Setup
- [ ] Configure CI pipeline
  gate: binary — `gh workflow run` returns success
  leader: implementer | reviewer: reviewer

- [ ] Define coverage baseline
  gate: quantitative — measured >= 0% (record initial value)
  leader: analyst | reviewer: architect

## Phase 2 — Feature X
- [ ] !! Implement /search endpoint (depends: #1)
  gate: qualitative — passes all acceptance criteria of issue #42
  leader: implementer | reviewer: reviewer
```

The next-item selection rule is deterministic: `!!` priority > resolved dependencies > file order.

---

## FAQ

**Does it work with any language/stack?**
Yes. The framework is stack-agnostic — `/init` detects your stack and proposes agents specialized to your domain.

**Do I need GitHub?**
No. But the Issue+PR rule depends on `gh`. Without `gh`, edit `CLAUDE.md §Git` to reflect your workflow.

**What if I only want one agent?**
Use it directly without `/mesa-redonda`. `JOURNAL.md` and `CHECKLIST.md` remain useful as a discipline layer.

**Can I add more than 4 specialists?**
You can, but experience shows that >9 total agents starts blurring boundaries. Adjust the limit in `.claude/commands/init.md` if needed.

**What if the agent enters a loop?**
It can't. `/mesa-redonda` has a 5-step ceiling per invocation and explicit stop conditions (failed gate, agent error, non-converging debate).

**Why is the orchestrator command in Portuguese (`/mesa-redonda`)?**
The author is Brazilian and the metaphor lands harder in Portuguese. The command name is cosmetic — rename it if you prefer `/round-table`.

---

## Contributing

PRs welcome. Please:

1. Open an issue before large changes (scope alignment).
2. Keep the style: pure markdown, zero runtime dependencies.
3. Update `CHANGELOG.md` for any user-visible change.
4. Run `/review-pr` on your own PR before requesting human review. **Dogfooding mandatory.**

## License

MIT. Use it, fork it, adapt it. Attribution appreciated, not required.

---

<div align="center">

**Round Table — because "the agent said it works" is not a quality gate.**

⭐ Star us if Round Table saved you from a hallucinating agent.

</div>
