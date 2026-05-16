#!/bin/bash
# scaffold.sh — Copia o template Mesa Redonda para um ou mais projetos
#
# Uso:
#   ./scaffold.sh [--agent claude|qwen|opencode|all] [--force] PATH [PATH...]
#
# Exemplos:
#   ./scaffold.sh ~/projeto                       # instala tudo (claude+qwen+opencode)
#   ./scaffold.sh --agent claude ~/projeto        # so Claude Code
#   ./scaffold.sh --agent qwen ~/p1 ~/p2          # so Qwen, multiplos alvos
#   ./scaffold.sh --force ~/projeto               # sobrescreve sem perguntar

set -euo pipefail

TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENT="all"
FORCE=0
TARGETS=()

while [ $# -gt 0 ]; do
    case "$1" in
        --agent)
            AGENT="${2:?--agent requer valor: claude|qwen|opencode|all}"
            shift 2
            ;;
        --agent=*)
            AGENT="${1#*=}"
            shift
            ;;
        --force|-f)
            FORCE=1
            shift
            ;;
        -h|--help)
            sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        -*)
            echo "Erro: flag desconhecida '$1'" >&2
            exit 2
            ;;
        *)
            TARGETS+=("$1")
            shift
            ;;
    esac
done

case "$AGENT" in
    claude|qwen|opencode|all) ;;
    *) echo "Erro: --agent invalido '$AGENT' (use claude|qwen|opencode|all)" >&2; exit 2 ;;
esac

if [ "${#TARGETS[@]}" -eq 0 ]; then
    echo "Mesa Redonda — Scaffold Interativo"
    echo "==================================="
    echo ""
    read -r -p "Caminho do projeto alvo: " input_path
    if [ -z "$input_path" ]; then
        echo "Erro: nenhum caminho informado." >&2
        exit 2
    fi
    TARGETS+=("$input_path")
fi

confirm_overwrite() {
    local path="$1"
    [ "$FORCE" -eq 1 ] && return 0
    echo "AVISO: $path ja existe."
    read -r -p "Sobrescrever? (s/N) " reply
    [[ "$reply" =~ ^[Ss]$ ]]
}

copy_dir() {
    local src="$1" dst="$2" label="$3"
    if [ -d "$dst" ]; then
        if confirm_overwrite "$dst"; then
            rm -rf "$dst"
        else
            echo "  [SKIP] $label (mantido)"
            return 0
        fi
    fi
    cp -r "$src" "$dst"
    echo "  [OK] $label"
}

copy_file_if_absent() {
    local src="$1" dst="$2" label="$3"
    if [ -e "$dst" ]; then
        echo "  [SKIP] $label (ja existe)"
    else
        cp "$src" "$dst"
        echo "  [OK] $label"
    fi
}

scaffold_one() {
    local target="$1"
    local abs
    abs="$(cd "$target" 2>/dev/null && pwd || true)"

    if [ -z "$abs" ] || [ ! -d "$abs" ]; then
        echo "Erro: diretorio '$target' nao existe." >&2
        return 1
    fi

    echo ""
    echo "Mesa Redonda — Scaffolding"
    echo "=========================="
    echo "Template: $TEMPLATE_DIR"
    echo "Destino:  $abs"
    echo "Agent(s): $AGENT"
    if [ ! -d "$abs/.git" ]; then
        echo "Aviso:    destino nao e repositorio git (rastreabilidade Issue/PR fica por sua conta)"
    fi
    echo ""

    local want_claude=0 want_qwen=0 want_opencode=0
    case "$AGENT" in
        claude)   want_claude=1 ;;
        qwen)     want_qwen=1 ;;
        opencode) want_opencode=1 ;;
        all)      want_claude=1; want_qwen=1; want_opencode=1 ;;
    esac

    if [ "$want_claude" -eq 1 ]; then
        copy_dir "$TEMPLATE_DIR/.claude" "$abs/.claude" ".claude/ (Claude Code)"
        copy_file_if_absent "$TEMPLATE_DIR/CLAUDE.md" "$abs/CLAUDE.md" "CLAUDE.md"
    fi

    if [ "$want_qwen" -eq 1 ]; then
        if [ -d "$TEMPLATE_DIR/.qwen" ]; then
            copy_dir "$TEMPLATE_DIR/.qwen" "$abs/.qwen" ".qwen/ (Qwen Code)"
        else
            echo "  [WARN] template nao tem .qwen/ — pulando"
        fi
        if [ ! -e "$abs/QWEN.md" ]; then
            if [ -f "$TEMPLATE_DIR/QWEN.md" ]; then
                cp "$TEMPLATE_DIR/QWEN.md" "$abs/QWEN.md"
            else
                cp "$TEMPLATE_DIR/CLAUDE.md" "$abs/QWEN.md"
            fi
            echo "  [OK] QWEN.md"
        else
            echo "  [SKIP] QWEN.md (ja existe)"
        fi
    fi

    copy_file_if_absent "$TEMPLATE_DIR/AGENTS.md" "$abs/AGENTS.md" "AGENTS.md (opencode + protocolo)"

    for file in JOURNAL.md CHECKLIST.md DEBATE_LOG.md; do
        copy_file_if_absent "$TEMPLATE_DIR/$file" "$abs/$file" "$file"
    done

    local gi="$abs/.gitignore"
    if [ ! -f "$gi" ]; then
        touch "$gi"
        echo "  [OK] .gitignore criado"
    fi
    local ignore_entries=(".claude/settings.local.json" ".qwen/settings.local.json" "DEBATE_LOG.md")
    local added=0
    for entry in "${ignore_entries[@]}"; do
        if ! grep -qxF "$entry" "$gi"; then
            echo "$entry" >> "$gi"
            added=1
        fi
    done
    [ "$added" -eq 1 ] && echo "  [OK] .gitignore: locais/efêmeros ignorados"

    echo ""
    echo "Scaffolding concluido em: $abs"
}

for t in "${TARGETS[@]}"; do
    scaffold_one "$t" || exit $?
done

echo ""
echo "Proximos passos:"
echo "  1. Abra o projeto no Claude Code (ou Qwen / OpenCode)"
echo "  2. Rode /init — analisa o codebase e propoe agentes especializados para seu dominio"
echo "  3. Rode /scan — tira um snapshot do estado (CHECKLIST, JOURNAL, git, debates)"
echo "  4. Edite CLAUDE.md / QWEN.md — preencha missao, stack, arquitetura (se /init nao preencheu)"
echo "  5. Edite AGENTS.md — customize tabela Etapa → Agente (se /init nao preencheu)"
echo "  6. Edite CHECKLIST.md — defina suas etapas e gates (se /init nao preencheu)"
echo "  7. Revise .claude/settings.json e .qwen/settings.json — permissoes"
echo "  8. Rode /mesa-redonda — comeca o loop multi-agente"
