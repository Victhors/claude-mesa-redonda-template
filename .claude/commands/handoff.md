---
description: "Resumo de handoff para continuidade em proxima sessao"
---

Gere resumo de handoff para a proxima sessao.

## 0. Pre-condicoes

- `JOURNAL.md` e `CHECKLIST.md` devem existir. Faltando → "Rode `/init` primeiro."
- Repo deve ser git.

## 1. Coleta (paralela)

- `JOURNAL.md` — `tail -n 100`, filtrar entradas com timestamp ISO desta sessao (mesmo dia).
- `CHECKLIST.md` — itens `[ ]` pendentes; identificar proximo via regra deterministica (prioridade `!!` > dependencias > ordem).
- `DEBATE_LOG.md` — debates sem `### Resolucao`.
- `git status --porcelain`, `git rev-parse --abbrev-ref HEAD`, `git log --oneline -5`.
- `gh pr list --state open --author @me --limit 5` se `gh` disponivel.

## 2. Append no JOURNAL.md (formato fixo)

```
## [YYYY-MM-DDTHH:MM:SSZ] HANDOFF — fim de sessao

### Concluido nesta sessao
- <acao 1> (commit <hash> | PR #<n> | nenhum)
- <acao 2>

### Pendente
- Proximo item do CHECKLIST: "<titulo>" (lider sugerido: <agente>)
- Bloqueios: <lista ou "nenhum">

### Decisoes pendentes
- Debates abertos: <#N "titulo" ou "nenhum">

### Estado do codigo
- Branch: <nome>
- Nao commitado: <N arquivos> [<lista resumida>]
- Ultimo commit: <hash> "<msg>"
- PRs abertos: <#N ou "nenhum">

### Contexto nao-obvio para proxima sessao
- <so o que NAO esta deduzivel dos arquivos acima; senao escrever "nenhum">
```

Regra: a secao "Contexto nao-obvio" deve conter apenas informacao **nao recuperavel** lendo os outros arquivos. Sem repetir o que ja esta no CHECKLIST/JOURNAL/git.

## 3. Verificacao de Limpeza (perguntar, nao agir)

Se ha mudancas nao commitadas:
> "Ha <N> arquivos nao commitados. Quer (1) commitar com Issue+PR, (2) deixar como esta, (3) descartar?"

**Nao commitar nem descartar sem resposta.** Sem chute. Sem `git add -A` automatico.

## 4. Saida ao usuario

Exibir o bloco do JOURNAL recem-escrito + a pergunta de limpeza (se aplicavel). Nao mais que isso.
