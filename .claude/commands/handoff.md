Gere um resumo de handoff para continuidade em proxima sessao.

## 1. Analisar Estado Atual

- Leia `JOURNAL.md` (ultimas 10 entradas) — o que foi feito nesta sessao
- Leia `CHECKLIST.md` — o que esta pendente
- Leia `DEBATE_LOG.md` — debates abertos sem resolucao
- Execute `git status` — mudancas nao commitadas
- Execute `git log --oneline -5` — commits recentes

## 2. Gerar Resumo de Handoff

Adicione ao JOURNAL.md:

```
## [YYYY-MM-DD HH:MM] HANDOFF — Fim de sessao

### O que foi feito
- [lista de acoes concluidas nesta sessao]

### O que falta
- [proximo item do CHECKLIST]
- [bloqueios ou dependencias]

### Decisoes pendentes
- [debates abertos, se houver]

### Estado do codigo
- Branch: [branch atual]
- Mudancas nao commitadas: [sim/nao — quais]
- Ultimo commit: [hash + mensagem]

### Contexto importante para proxima sessao
- [qualquer informacao que nao esta nos arquivos mas e relevante]
```

## 3. Verificar Limpeza

- Ha mudancas nao commitadas que deveriam ser commitadas?
- Ha arquivos temporarios que deveriam ser removidos?
- Perguntar ao usuario se quer commitar antes de encerrar.