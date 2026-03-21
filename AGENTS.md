# Mesa Redonda — Protocolo Multi-Agente

## Agentes Disponiveis

| Agente | Papel | Executa? | Ferramentas |
|--------|-------|----------|-------------|
| `arquiteto` | Design, decisoes de arquitetura, tradeoffs | Nao — projeta e decide | Read, Write, Glob, Grep |
| `implementador` | Escreve codigo, builda, executa | Sim | Bash, Read, Write, Edit, Glob, Grep |
| `analista` | Testes, metricas, qualidade | Sim (medicao) | Bash, Read, Write, Glob, Grep |
| `pesquisador` | SOTA, benchmarks, evidencia externa | Nao — pesquisa | Read, Write, WebSearch, WebFetch, Glob, Grep |
| `revisor` | Code review, gates, compliance | Nao — valida | Bash, Read, Write, Glob, Grep |

## Mapeamento Etapa → Agente

> **Customize esta tabela para seu projeto.** Defina suas etapas e quem lidera/revisa cada uma.

| Etapa | Agente Lider | Agente Revisor |
|-------|-------------|----------------|
| Design/Arquitetura | `arquiteto` | `pesquisador` |
| Implementacao | `implementador` | `revisor` |
| Testes/Metricas | `analista` | `revisor` |
| Pesquisa/SOTA | `pesquisador` | `arquiteto` |
| Code Review | `revisor` | `arquiteto` |
| Refatoracao | `implementador` | `analista` |

## Afinidade de Review

Quem revisa quem (para `/review-loop`):

| Lider | Revisor natural | Porque |
|-------|----------------|--------|
| `arquiteto` | `pesquisador` | Pesquisador traz evidencia externa |
| `implementador` | `revisor` | Revisor valida qualidade |
| `analista` | `revisor` | Revisor confirma gates |
| `pesquisador` | `arquiteto` | Arquiteto avalia viabilidade |
| `revisor` | `arquiteto` | Arquiteto revisa decisoes do revisor |

## Protocolo de Colaboracao

### Regras Permanentes
1. **Gate e gate.** Se nao passou, nao avanca — abrir DEBATE_LOG.md
2. **Uma variavel por vez.** Nunca mudar duas coisas simultaneamente
3. **Registrar ANTES de agir.** JOURNAL entry antes de invocar agente
4. **Progresso parcial e nao-terminal.** Continuar ate gate verificado
5. **Debate obrigatorio** quando gate falha ou decisao e nao-trivial
6. **Self-review proibido.** O lider nunca revisa a si mesmo

### Fluxo Padrao
```
1. Orquestrador le CHECKLIST → identifica proxima etapa
2. Orquestrador delega ao Lider (registra no JOURNAL)
3. Lider executa (registra no JOURNAL ao concluir)
4. Orquestrador delega ao Revisor (review adversario)
5. Revisor aprova → marcar [x] no CHECKLIST
   Revisor rejeita → /debate
6. Proxima etapa
```

### Decisoes Permanentes
Registrar aqui decisoes que nao devem ser rediscutidas:

<!-- Exemplo:
- **[2026-03-15]** Framework: Next.js (Debate #1) — escolhido por SSR + ecosystem
- **[2026-03-16]** DB: PostgreSQL (Debate #2) — escolhido por maturidade + JSON support
-->

## Como Adicionar Agentes

Para adicionar um agente especializado ao seu projeto:

1. Crie `.claude/agents/[nome].md` com frontmatter (name, description, tools)
2. Adicione a entrada na tabela de agentes acima
3. Defina mapeamento de etapas e afinidade de review
4. Registre no JOURNAL a adicao do agente
