Faca um scan rapido do estado do projeto:

1. Leia CHECKLIST.md — quantos itens pendentes vs concluidos
2. Leia JOURNAL.md (ultimas 10 entradas) — atividade recente
3. Verifique o estado do git (branch, modified files, ultimo commit)
4. Conte arquivos-chave do projeto (use glob para src/, lib/, tests/, etc.)
5. Verifique se ha issues abertas no GitHub: `gh issue list --state open` (se disponivel)
6. Leia DEBATE_LOG.md — debates abertos sem resolucao

Formato de saida:
```
## Status do Projeto
- Checklist: X/Y concluidos
- Ultimo JOURNAL: [data] [acao]
- Git: branch [nome], [N] arquivos modificados
- Debates abertos: [N]

## Proxima Acao Recomendada
[baseado no CHECKLIST, qual o proximo passo]
```
