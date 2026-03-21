# Claude Mesa Redonda Template

Template para projetos que usam o protocolo **Mesa Redonda** — um sistema multi-agente para desenvolvimento de software com Claude Code.

## O que e a Mesa Redonda?

Um protocolo onde **agentes especializados** colaboram em um projeto, cada um com um papel definido:

| Agente | Papel |
|--------|-------|
| **Arquiteto** | Design, decisoes de arquitetura, tradeoffs |
| **Implementador** | Escreve codigo, builda, executa |
| **Analista** | Testes, metricas, qualidade |
| **Pesquisador** | SOTA, benchmarks, evidencia externa |
| **Revisor** | Code review, gates, compliance |

O **Orquestrador** (voce, via `/mesa-redonda`) coordena os agentes, delegando tarefas e garantindo que gates de qualidade sejam respeitados.

## Como Usar

### 1. Copiar para seu projeto

```bash
# Copiar a estrutura para seu projeto
cp -r claude-mesa-redonda-template/.claude/ /caminho/do/seu/projeto/
cp claude-mesa-redonda-template/AGENTS.md /caminho/do/seu/projeto/
cp claude-mesa-redonda-template/JOURNAL.md /caminho/do/seu/projeto/
cp claude-mesa-redonda-template/CHECKLIST.md /caminho/do/seu/projeto/
cp claude-mesa-redonda-template/DEBATE_LOG.md /caminho/do/seu/projeto/
cp claude-mesa-redonda-template/CLAUDE.md /caminho/do/seu/projeto/

# Ou use o script de scaffolding
./scaffold.sh /caminho/do/seu/projeto
```

### 2. Inicializar (recomendado)

```bash
# No Claude Code, na raiz do seu projeto:
/init
```

O comando `/init` analisa seu codebase automaticamente e:
- Detecta linguagens, frameworks e estrutura do projeto
- Propoe agentes especializados para o dominio (alem dos 5 genericos)
- Preenche CLAUDE.md com a stack detectada
- Propoe um CHECKLIST inicial com fases e gates
- **Pede sua aprovacao antes de criar qualquer arquivo**

### 3. (Alternativa) Customizar manualmente

Se preferir nao usar `/init`:

1. **CLAUDE.md** — Preencha missao, stack, arquitetura, metricas
2. **AGENTS.md** — Customize a tabela Etapa → Agente para seu projeto
3. **CHECKLIST.md** — Defina suas etapas e gates
4. **.claude/settings.json** — Adicione permissoes para suas ferramentas (npm, pip, etc.)

### 4. Usar

```bash
# Na raiz do seu projeto, com Claude Code:
/mesa-redonda    # Orquestracao principal
/scan            # Estado do projeto
/review-loop X   # Review cross-agente
/debate X        # Debate formal
/review-pr 123   # Code review de PR
```

## Estrutura

```
.claude/
├── agents/
│   ├── arquiteto.md       # Design e decisoes
│   ├── implementador.md   # Codigo e execucao
│   ├── analista.md        # Metricas e testes
│   ├── pesquisador.md     # SOTA e evidencia
│   └── revisor.md         # Quality gates
├── commands/
│   ├── mesa-redonda.md    # Orquestracao principal
│   ├── review-loop.md     # Review cross-agente
│   ├── debate.md          # Debate formal
│   ├── scan.md            # Scan do projeto
│   ├── review-pr.md       # Code review
│   └── init.md            # Setup automatico de agentes
└── settings.json          # Permissoes

AGENTS.md      # Protocolo de colaboracao
JOURNAL.md     # Log cross-sessao
CHECKLIST.md   # Roadmap com gates
DEBATE_LOG.md  # Registro de debates
CLAUDE.md      # Instrucoes do agente
```

## Principios

1. **Gate e gate.** Se nao passou, nao avanca.
2. **Uma variavel por vez.** Nunca mudar duas coisas simultaneamente.
3. **Registrar ANTES de agir.** JOURNAL entry antes de qualquer acao.
4. **Dados vencem opinioes.** Se ha metrica, a metrica decide.
5. **Self-review proibido.** O lider nunca revisa a si mesmo.
6. **Debate obrigatorio.** Quando gate falha ou decisao e nao-trivial.
