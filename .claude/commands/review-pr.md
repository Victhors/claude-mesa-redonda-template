---
description: "Code review de um PR via gh CLI"
---

Code review do PR **$ARGUMENTS**.

## 0. Pre-condicoes

- `$ARGUMENTS` deve ser numero de PR ou URL. Vazio → perguntar ao usuario qual PR. Nao chutar "ultimo PR".
- `gh` deve estar disponivel (`gh --version`). Indisponivel → instruir o usuario e parar.
- Repo deve ser git. Senao → parar.

## 1. Coleta

Em paralelo:
- `gh pr view $ARGUMENTS --json title,author,body,baseRefName,headRefName,state,labels`
- `gh pr diff $ARGUMENTS`
- `gh pr checks $ARGUMENTS` (status de CI)
- Ler `CLAUDE.md` (padroes do projeto) e `AGENTS.md` (regras de revisao se houver)

Se PR ja foi mergeado/closed → confirmar com usuario se quer review post-merge.

## 2. Analise por arquivo

Para cada arquivo no diff, avaliar nos eixos:

| Eixo | O que olhar |
|------|-------------|
| **Qualidade** | legibilidade, naming, duplicacao, complexidade, manutencao |
| **Testes** | cobertura para codigo novo, casos de borda, mocks indevidos |
| **Seguranca** | OWASP top 10, secrets, injection, validacao em boundary |
| **Performance** | N+1, loops desnecessarios, alocacao em hot path, leaks |
| **Padroes** | aderencia ao `CLAUDE.md` (estilo, commits, regras nao-delegaveis) |
| **CI** | checks vermelhos? motivo? |

## 3. Classificacao (fixa)

Para cada achado:
- **CRITICO** — bloqueia merge (bug, vulnerabilidade, quebra contrato publico, viola regra nao-delegavel)
- **ALERTA** — deveria corrigir antes do merge (test gap relevante, perf regressao, divida nao registrada)
- **SUGESTAO** — melhoria opcional

Se nao houver achados em uma categoria, declarar `nenhum` — nao omitir.

## 4. Saida (formato fixo)

```
## Review PR #<N> — <titulo>
Autor: <login> | Branch: <head> → <base> | CI: <PASS|FAIL>

### CRITICO (<N>)
- [<arquivo>:<linha>] <descricao> — <acao sugerida>

### ALERTA (<N>)
- [<arquivo>:<linha>] <descricao> — <acao sugerida>

### SUGESTAO (<N>)
- [<arquivo>:<linha>] <descricao>

### Veredito
<APROVAR | APROVAR_COM_RESSALVAS | SOLICITAR_MUDANCAS> — <1 frase>
```

## 5. Regras

- **Sem postar comentario no GitHub** sem confirmacao explicita do usuario (`gh pr review` e acao visivel a terceiros).
- **Sem chute de linhas.** Se nao tem certeza da linha, citar so o arquivo.
- **CI vermelho = nao aprovar** sem entender o motivo.
