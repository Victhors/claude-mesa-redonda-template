# [Nome do Projeto] — Instrucoes para o Qwen Code

## Missao

[Descricao do projeto em 1-2 linhas: o que e, qual o objetivo e o que o agente deve manter/preservar.]

---

## Sistema Multi-Agente (Mesa Redonda)

Este repositorio opera com **[N] agentes** ([X] genericos + [Y] especializados) que colaboram via protocolo Mesa Redonda.

Antes de trabalhar, leia:
1. `AGENTS.md` — definicao dos agentes e protocolo de colaboracao
2. [CHECKLIST.md](CHECKLIST.md) — estado atual do roadmap (o que fazer a seguir)
3. [JOURNAL.md](JOURNAL.md) — log de acoes recentes (contexto cross-sessao)

### Regras de Operacao Autonoma
- Registrar TODA acao no [JOURNAL.md] antes de avancar ao proximo passo
- Verificar [CHECKLIST.md] para saber o proximo passo pendente
- Nunca pular gate de qualidade — se falhou, registrar e debater (`/debate`)
- Tratar progresso parcial como nao-terminal (nunca parar para reportar status)
- Ao completar item do checklist, marcar `[x]` e registrar no JOURNAL
- Self-review obrigatorio: agente revisor (diferente do lider) verifica cada resultado

### Workflows Disponiveis
- `/init` — setup automatico: analisa o projeto e cria agentes especializados
- `/mesa-redonda` — orquestracao principal do roadmap
- `/review-loop [resultado]` — review cross-agente
- `/debate [topico]` — debate formal entre agentes
- `/scan` — scan rapido do estado do projeto
- `/review-pr [numero]` — code review de pull request

---

## Stack

- **Plataforma**: [plataforma principal do projeto]
- **Scripts**: [linguagens e ferramentas de automacao]
- **Plugins/Libs-chave**: [dependencias principais]
- **Sincronizacao/Deploy**: [ferramenta de CI/CD ou sync]

---

## Como Rodar

```bash
# [Instrucao de instalacao/configuracao inicial]
# [Comando para rodar em desenvolvimento]
```

---

## Arquitetura

```
project-root/
├── [pasta-1]/   — [descricao]
├── [pasta-2]/   — [descricao]
├── [pasta-3]/   — [descricao]
└── [pasta-N]/   — [descricao]
```

---

## Regras Nao-Delegaveis (Sempre Ativas)

### 1. Qualidade
- Testes obrigatorios para todo script/modulo novo
- Code review obrigatorio antes de merge
- Zero warnings em linting/type checking

### 2. Seguranca
- Zero secrets no repositorio
- Zero PII em logs ou dados commitados
- Validar input em boundaries do sistema

### 3. Git
- Branch principal: `main`
- Feature branches: `feat/descricao`
- Commits em portugues, Conventional Commits
- NAO comitar arquivos grandes ou gerados
- **OBRIGATORIO:** Nunca fazer commits sem antes criar Issue + PR (rastreabilidade)
  - Workflow: Issue → Branch feature → PR → Merge
  - [Excecao especifica do projeto, se houver]

### 4. Codigo
- NAO usar `print()` — usar logging
- Config centralizada — nunca hardcode de paths/secrets
- Preferir simplicidade a abstracao prematura

### 5. [Regra especifica do dominio do projeto]
- [Ex: notas devem ser atomicas / dados devem ser normalizados / etc.]
- [Regra adicional]
- [Regra adicional]

---

## Metricas e Gates

| Metrica | Baseline | Meta |
|---------|----------|------|
| [Metrica 1] | — | [valor] |
| [Metrica 2] | — | [valor] |
| [Metrica 3] | — | [valor] |
| [Metrica 4] | — | [valor] |

---

## Interatividade (Pergunte ao Usuario)

Coloque o usuario no loop. Nao faca nada relevante sem consultar antes.

### Quando perguntar
- Antes de executar acao nao-trivial: apresente o plano e peca confirmacao
- Multiplas abordagens viaveis: apresente opcoes com tradeoffs, pergunte qual seguir
- Acao irreversivel (deletar, migrar, refatorar): PECA CONFIRMACAO EXPLICITA
- Resultado ambiguo ou inesperado: mostre o ocorrido e pergunte como proceder
- Duas ou mais opcoes igualmente validas: enumere e pergunte

### Como perguntar
- Seja direto: "Quer que eu [acao]? (s/N)"
- Para opcoes: "Opcoes: 1) [A], 2) [B]. Qual prefere?"
- Acoes destrutivas: "ISSO E IRREVERSIVEL. Confirma? (s/N)"
- Nao chute preferencia do usuario — pergunte.

### Excecoes (pode agir sem perguntar)
- Ler arquivos (read-only)
- Rodar scan/status (collect-only)
- Responder perguntas factuais do usuario
- Acoes explicitamente delegadas com "faca X"

## O que NAO Fazer

- NAO instalar dependencias novas sem pedir confirmacao
- NAO mudar arquitetura do projeto sem debate registrado
- NAO pular testes para "ir mais rapido"
- NAO fazer commit de dados processados ou gerados
- NAO ignorar warnings de seguranca
- NAO [acao critica especifica do projeto] sem [salvaguarda]

---

## Documentos de Referencia

- `AGENTS.md` — agentes e protocolo de colaboracao
- [CHECKLIST.md] — roadmap e estado atual
- [JOURNAL.md] — log de acoes cross-sessao
- `CLAUDE.md` — instrucoes para Claude Code (estrutura similar)
