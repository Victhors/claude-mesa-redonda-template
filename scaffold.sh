#!/bin/bash
# scaffold.sh — Copia o template Mesa Redonda para um projeto existente
#
# Uso: ./scaffold.sh /caminho/do/projeto

set -euo pipefail

TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="${1:?Uso: ./scaffold.sh /caminho/do/projeto}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Erro: Diretorio '$TARGET_DIR' nao existe."
    exit 1
fi

echo "Mesa Redonda — Scaffolding"
echo "========================="
echo "Template: $TEMPLATE_DIR"
echo "Destino:  $TARGET_DIR"
echo ""

# Copiar .claude/ (agentes + comandos + settings)
if [ -d "$TARGET_DIR/.claude" ]; then
    echo "AVISO: $TARGET_DIR/.claude/ ja existe."
    read -p "Sobrescrever? (s/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "Abortado."
        exit 1
    fi
fi

cp -r "$TEMPLATE_DIR/.claude" "$TARGET_DIR/"
echo "  [OK] .claude/ (agentes + comandos + settings)"

# Copiar arquivos de protocolo (apenas se nao existirem)
for file in AGENTS.md JOURNAL.md CHECKLIST.md DEBATE_LOG.md; do
    if [ -f "$TARGET_DIR/$file" ]; then
        echo "  [SKIP] $file (ja existe)"
    else
        cp "$TEMPLATE_DIR/$file" "$TARGET_DIR/"
        echo "  [OK] $file"
    fi
done

# CLAUDE.md — copiar apenas se nao existir
if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
    echo "  [SKIP] CLAUDE.md (ja existe — merge manual recomendado)"
    echo "         Template disponivel em: $TEMPLATE_DIR/CLAUDE.md"
else
    cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/"
    echo "  [OK] CLAUDE.md"
fi

echo ""
echo "Scaffolding concluido!"
echo ""
echo "Proximos passos:"
echo "  1. Edite CLAUDE.md — preencha missao, stack, arquitetura"
echo "  2. Edite AGENTS.md — customize tabela Etapa → Agente"
echo "  3. Edite CHECKLIST.md — defina suas etapas e gates"
echo "  4. Edite .claude/settings.json — adicione permissoes do seu projeto"
echo "  5. Use /mesa-redonda no Claude Code para comecar"
