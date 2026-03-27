#!/bin/bash

# Claude Code Security Agents — Installer
# 1. Copies agent definitions to ~/.claude/agents/
# 2. Installs the skill reference files via npx skills

set -e

AGENTS_DIR="$HOME/.claude/agents"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/agents"

echo ""
echo "Claude Code Security Agents Installer"
echo "======================================"

# Check that agents/ folder exists in repo
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: agents/ folder not found. Make sure you're running this from the repo root."
  exit 1
fi

# ── Step 1: Install agents ──────────────────────────────────────────────────
mkdir -p "$AGENTS_DIR"

echo ""
echo "Step 1/2 — Installing agents to $AGENTS_DIR ..."
echo ""

for file in "$SOURCE_DIR"/*.md; do
  name=$(basename "$file")
  cp "$file" "$AGENTS_DIR/$name"
  echo "  ✓ $name"
done

# ── Step 2: Install skills ──────────────────────────────────────────────────
echo ""
echo "Step 2/2 — Installing skill reference files (requires Node.js) ..."
echo ""

if ! command -v npx &> /dev/null; then
  echo "  ! Node.js / npx not found. Skipping skill installation."
  echo "    Install Node.js from https://nodejs.org and then run:"
  echo "    npx skills add PabloOchoa-maker/claude-security-skills@code-security -g"
  echo "    npx skills add PabloOchoa-maker/claude-security-skills@secrets-management -g"
  echo "    npx skills add PabloOchoa-maker/claude-security-skills@dependency-management-deps-audit -g"
else
  npx skills add PabloOchoa-maker/claude-security-skills@code-security -g -y && echo "  ✓ code-security skill"
  npx skills add PabloOchoa-maker/claude-security-skills@secrets-management -g -y && echo "  ✓ secrets-management skill"
  npx skills add PabloOchoa-maker/claude-security-skills@dependency-management-deps-audit -g -y && echo "  ✓ dependency-management-deps-audit skill"
fi

# ── Done ────────────────────────────────────────────────────────────────────
echo ""
echo "Done! Restart Claude Code to load the agents."
echo ""
echo "Agents installed:"
echo "  • code-security   — scans source code for OWASP vulnerabilities"
echo "  • config-security — detects hardcoded secrets and insecure configs"
echo "  • deps-security   — audits dependencies for CVEs"
echo "  • api-security    — reviews API endpoints for auth and input issues"
echo ""
