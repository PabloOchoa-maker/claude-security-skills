# Claude Code Security Skills

A collection of security-focused skills for [Claude Code](https://claude.ai/code) that power AI agents to analyze, review, and harden your codebase, secrets management, and dependencies.

---

## What are Skills?

In Claude Code, **skills** are Markdown instruction files that define how an AI agent should behave for a specific domain. When Claude Code invokes a security subagent, it reads the skill's `.md` files to know:

- What vulnerabilities to look for
- Which patterns are safe vs. dangerous
- How to prioritize and report findings

Think of skills as the **knowledge base** that makes a generic AI agent into a specialized security expert.

```
Claude Code
    └── invokes subagent (e.g. code-security)
            └── reads SKILL.md  ← this repo
                    └── applies security rules to your code
```

---

## Skills Included

| Skill | Source | What it does |
|-------|--------|-------------|
| [`code-security`](./code-security/) | Semgrep Engineering | Reviews code for OWASP Top 10, infrastructure misconfigs, and 28 vulnerability categories |
| [`secrets-management`](./secrets-management/) | wshobson/agents | Detects hardcoded secrets, credentials, and guides CI/CD secrets best practices |
| [`dependency-management-deps-audit`](./dependency-management-deps-audit/) | sickn33/antigravity | Audits dependencies for CVEs, license issues, and supply chain risks |

---

## Agents Included

Beyond skills, this repo ships **Claude Code subagents** — ready-to-use AI agents specialized in security tasks. Each agent knows exactly what to scan, how to report findings, and which severity levels to assign.

| Agent | What it does |
|-------|-------------|
| [`code-security`](./agents/code-security.md) | Scans source code for SQL Injection, XSS, Command Injection, Path Traversal, insecure deserialization, hardcoded secrets, and more |
| [`config-security`](./agents/config-security.md) | Detects hardcoded credentials, exposed cloud keys, DEBUG=True, weak secret keys, and .env files committed to the repo |
| [`deps-security`](./agents/deps-security.md) | Audits requirements.txt, package.json, go.mod, etc. for packages with known CVEs |
| [`api-security`](./agents/api-security.md) | Reviews API routes for missing auth, IDOR, CORS misconfiguration, missing rate limiting, and exposed sensitive data |

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and authenticated
- [Node.js 18+](https://nodejs.org) — needed to install the skill reference files

> The agents work standalone, but they get their full methodology from **skill reference files** (`~/.claude/skills/`). The installer sets up both automatically.

### Option 1 — Install everything at once (recommended)

Clone the repo and run the installer. It copies the agents to `~/.claude/agents/` **and** installs the skill reference files via `npx skills`.

**macOS / Linux:**
```bash
git clone https://github.com/PabloOchoa-maker/claude-security-skills.git
cd claude-security-skills
chmod +x install.sh
./install.sh
```

**Windows:**
```
git clone https://github.com/PabloOchoa-maker/claude-security-skills.git
cd claude-security-skills
install.bat
```

Restart Claude Code after installing. The agents will be available immediately.

### Option 2 — Manual installation

**Step 1 — Copy agents** to your Claude Code agents folder:

| OS | Path |
|----|------|
| macOS / Linux | `~/.claude/agents/` |
| Windows | `%USERPROFILE%\.claude\agents\` |

Copy all `.md` files from the `agents/` folder in this repo to that location.

**Step 2 — Install skill reference files:**

```bash
npx skills add PabloOchoa-maker/claude-security-skills@code-security -g
npx skills add PabloOchoa-maker/claude-security-skills@secrets-management -g
npx skills add PabloOchoa-maker/claude-security-skills@dependency-management-deps-audit -g
```

> The `-g` flag installs globally, making the skills available across all your projects.

---

## How to Use

Once installed, Claude Code will automatically invoke the relevant skill based on context. You can also trigger them explicitly:

```
"Review this file for security vulnerabilities"
→ triggers code-security

"Check if there are hardcoded secrets in this project"
→ triggers secrets-management

"Audit my dependencies for CVEs"
→ triggers dependency-management-deps-audit
```

### Combining Skills

Skills work independently but complement each other. For a full security audit of a project, you can ask Claude Code to run all three:

```
"Do a full security audit: check code vulnerabilities, scan for secrets, and audit dependencies"
```

---

## Extending with More Skills

These skills cover **static analysis and auditing**. Depending on your stack, you may want to combine them with additional skills:

| Need | Look for skills tagged |
|------|----------------------|
| API security testing | `api-security`, `rest-security` |
| Auth flows | `authentication`, `oauth` |
| Cloud infra | `terraform`, `kubernetes` |
| CI/CD pipelines | `github-actions`, `gitlab-ci` |

Search available skills:
```bash
npx skills find security
npx skills find [your-stack]
```

---

## Structure

```
claude-security-skills/
├── agents/                            # Claude Code subagent definitions
│   ├── code-security.md
│   ├── config-security.md
│   ├── deps-security.md
│   └── api-security.md
├── code-security/                     # Skill reference files
│   ├── SKILL.md
│   ├── AGENTS.md
│   ├── README.md
│   └── rules/                         # 28 vulnerability rule files
│       ├── sql-injection.md
│       ├── xss.md
│       ├── command-injection.md
│       └── ...
├── secrets-management/
│   └── SKILL.md
├── dependency-management-deps-audit/
│   ├── SKILL.md
│   └── resources/
│       └── implementation-playbook.md
├── install.sh                         # Installer for macOS/Linux
└── install.bat                        # Installer for Windows
```

---

## Credits

- `code-security` — [Semgrep Engineering](https://semgrep.dev) ([@DrewDennison](https://x.com/drewdennison))
- `secrets-management` — [wshobson/agents](https://github.com/wshobson)
- `dependency-management-deps-audit` — [sickn33/antigravity-awesome-skills](https://github.com/sickn33)
