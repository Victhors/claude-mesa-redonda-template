---
description: "Review cross-agente sobre resultado de uma tarefa — lider vs revisor"
---

Review adversario do resultado de: **$ARGUMENTS**

## 0. Pre-condicoes

- `AGENTS.md` deve existir (tabela de afinidade lider↔revisor). Senao → "Rode `/init`."
- `$ARGUMENTS` nao pode estar vazio. Se vazio → perguntar ao usuario qual resultado/etapa revisar. **Nao chutar.**

## 1. Identificacao

1. Ler `JOURNAL.md` (ultimas 30 linhas) para localizar o agente LIDER que produziu o resultado em `$ARGUMENTS`.
   - Se nao encontrar referencia explicita → perguntar ao usuario qual foi o lider. Nao inferir.
2. Consultar `AGENTS.md` → tabela de afinidade → REVISOR (deve ser **diferente** do lider).
   - Sem mapeamento → perguntar ao usuario. Sem chute.
3. Carregar persona do revisor: `.claude/agents/<revisor>.md`.

## 2. Invocacao do Revisor (com contexto completo)

`Agent(subagent_type=<revisor>, prompt=...)` contendo OBRIGATORIAMENTE:
- **Tarefa original** (descricao do item do CHECKLIST)
- **Resultado do lider** (o que foi produzido — arquivos, metricas, decisoes)
- **Gate** a verificar (tipo: quantitativo / qualitativo / binario)
- **Checklist adversario:**
  - Resultados reprodutiveis?
  - Uma variavel por vez? Baseline registrado?
  - Testes passando? Cobertura adequada?
  - Resultado "bom demais" — possivel falso positivo?
  - Consistente com decisoes em `DEBATE_LOG.md`?
  - `JOURNAL.md` atualizado conforme protocolo?
- **Saida exigida:** veredito literal `APROVADO` ou `REJEITADO: <motivos numerados>`

## 3. Decisao

- **APROVADO** → append em `JOURNAL.md`:
  ```
  [YYYY-MM-DDTHH:MM:SSZ] <revisor> → APROVADO review de "<$ARGUMENTS>"
  ```
- **REJEITADO 1a vez** → registrar motivos no JOURNAL e devolver ao lider para correcao.
- **REJEITADO 2a vez** OU **mudanca de arquitetura** OU **gate quantitativo violado** → registrar em `DEBATE_LOG.md` e invocar `/debate`.

## 4. Regras

- **Sem self-review.** Lider nunca e revisor de si mesmo.
- **Veredito literal.** `APROVADO`/`REJEITADO` exato — nao "OK", "ok com ressalvas".
- **Registrar antes de devolver.** Append no JOURNAL antes de qualquer retorno.
