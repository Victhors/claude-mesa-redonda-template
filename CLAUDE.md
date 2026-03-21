# [NOME DO PROJETO] — Instrucoes para o Agente

## Missao

<!-- Descreva a missao do projeto em 2-3 linhas -->

---

## Sistema Multi-Agente (Mesa Redonda)

Este repositorio opera com **5 agentes especializados** que colaboram via protocolo Mesa Redonda.

Antes de trabalhar, leia:
1. `AGENTS.md` — definicao dos agentes e protocolo de colaboracao
2. `CHECKLIST.md` — estado atual do roadmap (o que fazer a seguir)
3. `JOURNAL.md` — log de acoes recentes (contexto cross-sessao)

### Regras de Operacao Autonoma
- Registrar TODA acao no `JOURNAL.md` antes de avancar ao proximo passo
- Verificar `CHECKLIST.md` para saber o proximo passo pendente
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

<!-- Defina a stack do projeto:
- **Linguagem**:
- **Framework**:
- **Banco**:
- **Testes**:
- **CI/CD**:
-->

---

## Como Rodar

<!-- Comandos para setup e execucao:
```bash
# Setup
# ...

# Rodar
# ...

# Testes
# ...
```
-->

---

## Arquitetura

<!-- Descreva a estrutura de diretorios e modulos principais:
```
projeto/
├── src/
├── tests/
└── ...
```
-->

---

## Regras Nao-Delegaveis (Sempre Ativas)

### 1. Qualidade
- Testes obrigatorios para toda feature nova
- Code review obrigatorio antes de merge
- Zero warnings em linting/type checking

### 2. Seguranca
- Zero secrets no repositorio
- Zero PII em logs ou dados commitados
- Validar input em boundaries do sistema

### 3. Git
- Branch principal: `master`
- Feature branches: `feat/descricao`
- Commits em portugues, Conventional Commits
- NAO comitar arquivos grandes ou gerados

### 4. Codigo
- NAO usar `print()` — usar logging
- Config centralizada — nunca hardcode de paths/secrets
- Preferir simplicidade a abstracao prematura

---

## Metricas e Gates

<!-- Defina suas metricas e targets:

| Metrica | Baseline | Meta |
|---------|----------|------|
| Cobertura testes | — | >= 80% |
| Tempo de build | — | < 60s |
| ... | — | ... |
-->

---

## O que NAO Fazer

- NAO instalar dependencias novas sem pedir confirmacao
- NAO mudar arquitetura sem debate registrado
- NAO pular testes para "ir mais rapido"
- NAO fazer commit de dados processados ou gerados
- NAO ignorar warnings de seguranca

---

## Documentos de Referencia

<!-- Liste documentos importantes do projeto:
- `docs/ARCHITECTURE.md` — arquitetura detalhada
- `docs/ROADMAP.md` — visao geral do projeto
-->
