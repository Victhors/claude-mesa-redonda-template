---
description: "Scan rapido do estado do projeto — CHECKLIST, JOURNAL, git"
---

Scan read-only do estado do projeto. **Nao escreve nada, nao delega, nao decide.**

## 0. Pre-condicoes

Verifique a existencia de `CHECKLIST.md`, `JOURNAL.md`, `AGENTS.md`. Para cada ausente, marque no relatorio como `FALTANDO` em vez de abortar — scan deve sempre produzir saida.

Se TODOS faltam: responda apenas "Estado nao inicializado. Rode `/init`."

## 1. Coleta (paralela quando possivel)

1. `CHECKLIST.md` — contar `[x]`, `[ ]`, identificar proximo `[ ]` por ordem (regra deterministica: prioridade `!!` > dependencias resolvidas > ordem do arquivo).
2. `JOURNAL.md` — `tail -n 100` filtrando linhas com timestamp ISO; pegar as 10 mais recentes.
3. `DEBATE_LOG.md` — debates sem secao `### Resolucao` = abertos.
4. Git: `git status --porcelain`, `git rev-parse --abbrev-ref HEAD`, `git log --oneline -5`.
5. `gh issue list --state open --limit 10` se `gh` disponivel; senao marcar `gh: indisponivel`.
6. Glob de arquivos-chave conforme stack (ler `CLAUDE.md` §Arquitetura, nao chutar pastas).

## 2. Formato de Saida (fixo)

```
## Status do Projeto — [YYYY-MM-DDTHH:MM:SSZ]

CHECKLIST: X/Y concluidos (Z bloqueados)
Proximo item: "<titulo>" (lider sugerido: <agente do AGENTS.md ou "nao mapeado">)

JOURNAL (ultimas 3):
  [ts] <agente> → <acao>
  [ts] <agente> → <acao>
  [ts] <agente> → <acao>

Git: branch=<nome> | modificados=<N> | ultimo=<hash> "<msg>"
Issues abertas: <N> (#<lista>)
Debates abertos: <N> (#<lista>)

## Proxima Acao Recomendada
<derivada do proximo item; se nao mapeado, sugerir /init para atualizar AGENTS.md>
```

## 3. Regras

- **Read-only.** Nao escrever em JOURNAL/CHECKLIST/DEBATE_LOG.
- **Sem chute.** Se algo falta ou e ambiguo, declarar `FALTANDO`/`AMBIGUO` em vez de inferir.
- **Sem delegacao.** Nao invocar Agent.
