<div align="center">

# Mesa Redonda

**Um framework de desenvolvimento agentico spec-driven para Claude Code, Qwen Code e OpenCode.**

Multi-agente. Gates de qualidade. Debate formal. Rastreabilidade Issue/PR. Zero magica.

[Instalacao](#instalacao) · [Como funciona](#como-funciona) · [Comandos](#comandos) · [Arquitetura](#arquitetura) · [Filosofia](#filosofia) · [FAQ](#faq)

</div>

---

## Por que Mesa Redonda?

A maioria dos workflows agenticos hoje sofre de tres problemas:

1. **Um agente faz tudo** — escreve, testa e revisa o proprio codigo. Sem advesario, sem freio.
2. **"Pronto" nao significa nada** — o agente declara sucesso sem gate objetivo.
3. **Decisoes evaporam** — escolhas de arquitetura somem entre sessoes; tudo e re-litigado.

A **Mesa Redonda** resolve isso com um protocolo simples:

- **Multiplos agentes** com papeis nao-sobrepostos (arquiteto, implementador, analista, pesquisador, revisor + especializados).
- **Lider != Revisor.** Quem faz nunca aprova.
- **Gates tipados** (quantitativo / qualitativo / binario). Veredito literal `PASS`/`FAIL`.
- **Spec-driven (SDD):** `CHECKLIST.md` e a especificacao executavel; cada item tem gate.
- **Debate formal** quando o gate falha ou ha decisao nao-trivial — registrado em `DEBATE_LOG.md`.
- **Rastreabilidade Issue + PR** para qualquer mudanca em codigo.
- **Memoria cross-sessao** via `JOURNAL.md` (linha do tempo) e `DEBATE_LOG.md` (decisoes).

E **so markdown e bash**. Sem servidor, sem dependencia exotica, sem lock-in.

---

## Instalacao

### Via scaffold (recomendado)

```bash
git clone https://github.com/<voce>/claude-mesa-redonda-template
cd claude-mesa-redonda-template
./scaffold.sh /caminho/do/seu/projeto
```

Opcoes:

```bash
./scaffold.sh --agent claude  /seu/projeto    # so Claude Code
./scaffold.sh --agent qwen    /seu/projeto    # so Qwen Code
./scaffold.sh --agent opencode /seu/projeto   # so OpenCode (AGENTS.md)
./scaffold.sh --agent all     /seu/projeto    # tudo (default)
./scaffold.sh --force         /seu/projeto    # sobrescreve sem perguntar
./scaffold.sh /p1 /p2 /p3                     # multiplos alvos
```

### Manual

Copie `.claude/`, `.qwen/`, `AGENTS.md`, `CLAUDE.md`, `JOURNAL.md`, `CHECKLIST.md`, `DEBATE_LOG.md` para o seu repo.

---

## Como funciona

### Setup automatico

```bash
# Dentro do seu projeto, no Claude Code:
/init
```

`/init` faz uma analise read-only do seu codebase e propoe:

- Stack detectada (manifests, frameworks, dominio)
- Ate **4 agentes especializados** alem dos 5 genericos
- Mapeamento Etapa → Lider → Revisor
- CHECKLIST inicial com fases e gates

**Nada e escrito sem sua aprovacao explicita.** Sem chute, sem sobrescrever customizacoes.

### Loop principal

```bash
/scan            # estado read-only do projeto
/mesa-redonda    # orquestracao: pega proximo item, delega lider, aciona revisor
/debate <topico> # quando gate falha ou decisao e nao-trivial
/review-loop X   # review adversario sobre uma entrega especifica
/review-pr 123   # code review de PR via gh CLI
/handoff         # resumo de fim de sessao
```

O `/mesa-redonda` itera com **limite de 5 etapas por invocacao** (supervisao humana periodica) e para automaticamente em FAIL nao-resolvido.

### Anatomia de uma etapa

```
1. Orquestrador le CHECKLIST → seleciona proximo item (regra deterministica)
2. Pre-registra no JOURNAL: [ts] orquestrador → delegando "X" para <lider>
3. Invoca <lider> com contexto + tarefa + gate + saida esperada
4. Invoca <revisor> com prompt original + gate + resultado do lider
5. APROVADO  → marca [x], cria Issue+PR (se mudou codigo), avanca
   REJEITADO → re-tenta; 2a rejeicao → /debate
6. Pos-registra dialogo lider↔revisor no JOURNAL
```

---

## Comandos

| Comando | O que faz |
|---------|-----------|
| `/init` | Analisa o codebase, propoe agentes especializados, preenche templates |
| `/scan` | Snapshot read-only: CHECKLIST, JOURNAL, git, debates abertos |
| `/mesa-redonda` | Orquestracao principal: delega lider, aciona revisor, registra tudo |
| `/review-loop <X>` | Review adversario cross-agente sobre `<X>` |
| `/debate <topico>` | Debate formal em ate 3 rodadas com criterio de resolucao explicito |
| `/review-pr <N>` | Code review estruturado de PR via `gh` (CRITICO/ALERTA/SUGESTAO) |
| `/handoff` | Append de resumo de fim de sessao no JOURNAL |

---

## Arquitetura

```
seu-projeto/
├── .claude/                  Claude Code
│   ├── agents/               personas dos agentes (arquiteto, implementador, ...)
│   ├── commands/             slash commands (mesa-redonda, debate, ...)
│   └── settings.json         permissoes
├── .qwen/                    Qwen Code (espelho)
│
├── AGENTS.md                 protocolo + tabela Etapa→Lider→Revisor (lido tambem por OpenCode)
├── CLAUDE.md  / QWEN.md      instrucoes de projeto por agente
├── CHECKLIST.md              especificacao executavel (cada item tem gate)
├── JOURNAL.md                linha do tempo append-only (cross-sessao)
└── DEBATE_LOG.md             decisoes formais com fundamentacao
```

### Os arquivos de estado

- **`CHECKLIST.md`** — sua spec. Cada `[ ]` e uma etapa com tipo de gate. Marcar `[x]` so apos APROVADO pelo revisor.
- **`JOURNAL.md`** — append-only com timestamp ISO. Pre-registro **antes** de agir, pos-registro com veredito.
- **`DEBATE_LOG.md`** — debates numerados. Decisoes ALTA confianca migram para `AGENTS.md → Decisoes Permanentes`.
- **`AGENTS.md`** — quem somos, quem revisa quem, o que ja foi decidido.

### Os agentes genericos

| Agente | Papel | Executa codigo? |
|--------|-------|-----------------|
| **arquiteto** | design, tradeoffs, decisoes | nao |
| **implementador** | escreve codigo, builda, roda scripts | sim |
| **analista** | mede, testa, valida quantitativamente | sim (medicao) |
| **pesquisador** | SOTA, benchmarks, evidencia externa | nao |
| **revisor** | gates, compliance, code review | nao |

`/init` adiciona ate 4 especializados conforme o dominio (ex.: `engenheiro-frontend`, `especialista-banco`, `curador-dados`).

---

## Filosofia

### Os 10 mandamentos

1. **Gate e gate.** Falhou nao avanca.
2. **Uma variavel por vez.** Nunca mudar duas coisas simultaneamente.
3. **Registrar ANTES de agir.** JOURNAL pre-entry obrigatorio.
4. **Dados vencem opinioes.** Metrica/teste decide quando existe.
5. **Self-review proibido.** Lider nunca aprova a si mesmo.
6. **Debate maximo 3 rodadas.** Nao convergiu → escala ao humano.
7. **Sem chute de agente.** Sem mapeamento → pergunta.
8. **Issue+PR para mudanca em codigo.** Doc-only e excecao declarada.
9. **Precedentes sao lei** ate evidencia nova citada.
10. **Limite de 5 etapas por invocacao.** Supervisao humana periodica.

### Spec-driven, nao vibe-coding

Voce escreve a spec uma vez (`CHECKLIST.md` com gates). O loop agentico executa contra ela. Se nao passou no gate, nao foi feito — independente do que o agente disse.

### Compativel com multiplos agents

Os mesmos arquivos rodam em **Claude Code**, **Qwen Code** e **OpenCode** (que le `AGENTS.md` nativo). Voce nao fica preso a um vendor.

---

## Exemplo minimo de CHECKLIST

```markdown
## Fase 1 — Setup
- [ ] Configurar pipeline de CI
  gate: binario — `gh workflow run` retorna sucesso
  lider: implementador | revisor: revisor

- [ ] Definir baseline de cobertura
  gate: quantitativo — medido >= 0% (registrar valor inicial)
  lider: analista | revisor: arquiteto

## Fase 2 — Feature X
- [ ] !! Implementar endpoint /search (depende: #1)
  gate: qualitativo — passa em todos os criterios da issue #42
  lider: implementador | revisor: revisor
```

A regra de selecao do proximo item e deterministica: prioridade `!!` > dependencias resolvidas > ordem do arquivo.

---

## FAQ

**Funciona com qualquer linguagem/stack?**
Sim. O framework e agnostico — `/init` detecta a stack e propoe agentes especializados ao seu dominio.

**Preciso de GitHub?**
Nao. Mas a regra de Issue+PR depende de `gh`. Sem `gh`, mude `CLAUDE.md §Git` para refletir seu workflow.

**E se eu so quiser um agente?**
Use direto sem `/mesa-redonda`. Os arquivos `JOURNAL.md` e `CHECKLIST.md` continuam uteis.

**Por que portugues nos prompts?**
O autor e brasileiro e calibra melhor em portugues. Traduzir para EN e um find/replace; PRs sao bem-vindos.

**Posso adicionar mais que 4 especializados?**
Pode, mas a experiencia mostra que >9 agentes no total comeca a borrar fronteiras. Ajuste o limite em `.claude/commands/init.md` se quiser.

**E se o agente entrar em loop?**
Nao entra. `/mesa-redonda` tem limite de 5 etapas por invocacao e condicoes de parada explicitas (gate falho, erro de agente, debate nao-convergente).

---

## Contribuindo

PRs bem-vindos. Por favor:

1. Abra uma issue antes de mudancas grandes (alinhar escopo).
2. Mantenha o estilo: markdown puro, zero dependencia em tempo de execucao.
3. Atualize `CHANGELOG.md` se houver mudanca observavel.
4. Rode `/review-pr` no proprio PR antes de pedir review humano. Dogfooding obrigatorio.

## Licenca

MIT. Use, forke, adapte. Atribuicao apreciada mas nao exigida.

---

<div align="center">

**Mesa Redonda — porque "o agente disse que funciona" nao e gate.**

</div>
