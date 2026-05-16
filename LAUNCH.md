# Launch Kit — Round Table v0.1.0

Drafts for the public launch. **Not committed to the framework's behavior — edit freely.**

---

## 1. Show HN

**Title** (80 char max — HN truncates):
```
Show HN: Round Table – adversarial multi-agent framework for AI coding agents
```

**Body** (HN prefers short, no fluff, link in URL field):

```
Hi HN — I built Round Table because I got tired of agents approving their
own code.

It's a spec-driven, multi-agent protocol for Claude Code, Qwen Code, and
OpenCode. Three rules make it different from CrewAI/AutoGen-style stacks:

  1. Leader != Reviewer. Whoever does the work never approves it.
  2. Every checklist item has a typed gate (quantitative / qualitative /
     binary) with a literal PASS/FAIL verdict.
  3. Failed gate or non-trivial decision triggers a formal debate (max 3
     rounds, explicit resolution criteria, recorded with confidence level).

It's just markdown and bash — zero runtime dependencies, no server, no
lock-in. The same files run across Claude Code, Qwen, and OpenCode.

State lives in four append-only files: CHECKLIST.md (your spec),
JOURNAL.md (timeline), DEBATE_LOG.md (decisions), AGENTS.md (protocol).
Cross-session memory comes for free.

Quickstart:
    ./scaffold.sh ~/your-project
    /init
    /mesa-redonda

Repo: https://github.com/<you>/round-table

Honest scope: this is a discipline layer for AI-assisted development, not
a replacement for LangGraph in production agent pipelines. Feedback wanted
— especially from people who've shipped real code with multi-agent loops.
```

---

## 2. Twitter / X thread

**Tweet 1 (hook):**
```
I shipped Round Table — an open-source framework that stops AI coding
agents from approving their own code.

Multi-agent, spec-driven, gates with literal PASS/FAIL verdicts.
Markdown + bash. Zero dependencies.

Works with Claude Code, Qwen, and OpenCode.

🧵
```

**Tweet 2 (problem):**
```
The dirty secret of agentic coding in 2026:

→ One agent writes, tests, AND reviews its own work.
→ "Done" means whatever the agent decides it means.
→ Architecture decisions vanish between sessions.

You discover the lies in production.
```

**Tweet 3 (solution):**
```
Round Table fixes this with three rules:

1. Leader ≠ Reviewer (whoever does the work never approves it)
2. Every spec item has a typed gate (quant / qual / binary)
3. Failed gate triggers a formal debate, max 3 rounds, recorded
   with confidence level

It's a discipline layer, not magic.
```

**Tweet 4 (visual — attach GIF here):**
```
Here's what one round-table loop looks like:

[GIF: /mesa-redonda running — orchestrator picks next item, delegates
to leader, reviewer rejects, debate fires, decision recorded]
```

**Tweet 5 (quickstart):**
```
Two commands:

  ./scaffold.sh ~/your-project
  /init

That's it. /init analyzes your stack and proposes up to 4 domain
specialists on top of the 5 generic agents (architect, implementer,
analyst, researcher, reviewer).

Nothing is written without your approval.
```

**Tweet 6 (differentiation):**
```
Why not CrewAI / AutoGen / LangGraph?

Those are great for production agent pipelines.
Round Table is for AI-assisted *development* — where humans drive
and agents must earn trust.

Different tool, different problem.
```

**Tweet 7 (CTA):**
```
MIT licensed. PRs welcome. Brazilian-built (the orchestrator command
is /mesa-redonda — round table in Portuguese).

⭐ Star if "the agent said it works" has burned you before:
https://github.com/<you>/round-table
```

---

## 3. Reddit posts

### r/ClaudeAI

**Title:**
```
[Tool] Round Table — multi-agent framework for Claude Code that won't let agents approve their own code
```

**Body:**
```
Hey r/ClaudeAI — I've been building Round Table for the past few weeks
and just open-sourced it.

It's a slash-command-based protocol that adds discipline to multi-agent
workflows in Claude Code:

- Leader ≠ Reviewer enforced (no self-approval)
- Every checklist item has a typed gate with PASS/FAIL verdict
- Formal debate (max 3 rounds) when a gate fails
- Issue + PR traceability for any code change
- Cross-session memory via append-only JOURNAL.md and DEBATE_LOG.md

Same files also work in Qwen Code and OpenCode (vendor-neutral via
AGENTS.md).

Quickstart:
    ./scaffold.sh ~/your-project
    /init
    /mesa-redonda

Repo: https://github.com/<you>/round-table

Genuinely curious what you'd break in this. The framework is markdown +
bash, no runtime — easy to fork and modify.
```

### r/LocalLLaMA

Same body, change opener:
```
Built this for Claude Code originally but it works with any CLI agent
that reads AGENTS.md (Qwen, OpenCode). Sharing here because the
discipline-layer approach should generalize to local models too.
```

---

## 4. dev.to / Hashnode article (long form)

**Title:**
```
Why your AI coding agent keeps lying to you (and how to build a round
table that won't)
```

**Outline:**
1. The opening anecdote — agent says "done", PR breaks prod
2. The three diseases of single-agent loops (self-approval, vague "done", decision amnesia)
3. The round-table metaphor — Arthur, peers, deliberation
4. The three rules (Leader != Reviewer, typed gates, formal debate)
5. Walkthrough of one `/mesa-redonda` cycle (with screenshots)
6. Why markdown + bash beats yet-another-Python-framework
7. Comparison with CrewAI / AutoGen / LangGraph (positioning, not bashing)
8. What's next on the roadmap
9. Call to action: try it, fork it, break it, file issues

Target length: 1500-2000 words. Include the comparison table from README.

---

## 5. Communities to seed (in order)

| Where | Why | Effort |
|---|---|---|
| Show HN | Highest-leverage technical audience | post + babysit comments for 6h |
| r/ClaudeAI | Hot, hungry for tools | 1 post |
| r/LocalLLaMA | Crossover — multi-vendor angle resonates | 1 post |
| r/ChatGPTCoding | Broader dev audience | 1 post |
| Twitter/X | Reach + screenshots/GIFs | thread above |
| Anthropic Discord | Direct line to power users | share in #show-and-tell |
| Awesome Claude Code (PR) | Long-tail discoverability | 1 PR |
| dev.to | SEO + long-form | article above |

---

## 6. Day-of checklist

- [ ] Repo renamed to `round-table` on GitHub
- [ ] LICENSE present (MIT)
- [ ] CHANGELOG.md updated, v0.1.0 tagged
- [ ] README.md links work (no `<you>` placeholders left)
- [ ] GIF recorded and embedded under hero
- [ ] At least one full demo run committed to JOURNAL.md as a real example
- [ ] First issue opened by you ("v0.1 launch tracking") to seed the issue tracker
- [ ] Twitter thread scheduled
- [ ] Show HN posted between 8-10am PT on a weekday (best slot historically)
- [ ] Discord/Reddit posts staggered 30 min apart
- [ ] Browser tabs ready: HN, all subreddits, Twitter, GitHub notifications

---

## 7. Pre-emptive answers to expected criticism

> "Why not just use LangGraph?"
LangGraph is for production agent pipelines. Round Table is for AI-assisted
development where humans drive. Different problem.

> "Why bash and markdown? Looks primitive."
That's the point. Zero install, zero deps, forkable in one read. Try
finding a CrewAI workflow you can read end-to-end in 10 minutes.

> "How is this different from a CLAUDE.md with rules?"
CLAUDE.md is a static instruction file. Round Table is an active
protocol with state files (JOURNAL, CHECKLIST, DEBATE_LOG), explicit
stop conditions, and enforced multi-agent separation.

> "Won't multi-agent just multiply the hallucinations?"
That's the core hypothesis being tested: an adversarial reviewer
catches what a self-approving leader rubber-stamps. Early dogfooding
suggests yes, but I want third-party data — that's why I'm shipping
v0.1 publicly.

> "5-step ceiling seems arbitrary."
It is. Tunable in `.claude/commands/mesa-redonda.md`. The default
exists to force periodic human supervision in v0.1; ship-it-and-walk-away
mode is explicitly out of scope.
