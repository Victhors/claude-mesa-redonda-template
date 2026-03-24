# [Nome do Projeto] — Instrucoes para o Agente

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
- Verificar [CHECKLIST.md]) para saber o proximo passo pendente
- Nunca pular gate de qualidade — se falhou, registrar e debater (`/debate`)
- Tratar progresso parcial como nao-terminal (nunca parar para reportar status)
- Ao completar item do checklist, marcar `[x]` e registrar no JOURNAL
- Self-review obrigatorio: agente revisor (diferente do lider) verifica cada resultado

### Workflows Disponiveis
- `/init` — setup automatico: analisa o projeto e cria agentes especializados
- `/mesa-redonda` — orquestracao principal do roadmap
- `/review-loop [resultado]` — review cross-agente
- `/debate [topico]` — debate formal entre agentes (Primeiro que Mesa Redonda)
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
# [Comando para rodar scripts de manutencao]
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

## O que NAO Fazer

- NAO instalar dependencias novas sem pedir confirmacao
- NAO mudar arquitetura do projeto sem debate registrado
- NAO pular testes para "ir mais rapido"
- NAO fazer commit de dados processados ou gerados
- NAO ignorar warnings de seguranca
- NAO [acao critica especifica do projeto] sem [salvaguarda]

## Regras de Execução no Terminal (Bash)

Para evitar bloqueios de segurança e alertas de "newlines" durante a automação:
1. NUNCA use comentários (iniciados com `#`) dentro do comando Bash.

---

## Documentos de Referencia

- `AGENTS.md` — agentes e protocolo de colaboracao
- [CHECKLIST.md] — roadmap e estado atual
- [JOURNAL.md] — log de acoes cross-sessao
- `[pasta-docs]/` — documentacao do sistema
