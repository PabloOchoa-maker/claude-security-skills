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

## Installation

### Install all security skills at once

```bash
npx skills add PabloOchoa-maker/claude-security-skills@code-security -g
npx skills add PabloOchoa-maker/claude-security-skills@secrets-management -g
npx skills add PabloOchoa-maker/claude-security-skills@dependency-management-deps-audit -g
```

### Install individually

```bash
# Only code vulnerability scanning
npx skills add PabloOchoa-maker/claude-security-skills@code-security -g

# Only secrets & CI/CD security
npx skills add PabloOchoa-maker/claude-security-skills@secrets-management -g

# Only dependency auditing
npx skills add PabloOchoa-maker/claude-security-skills@dependency-management-deps-audit -g
```

> **Note:** The `-g` flag installs globally, making the skill available across all your projects.

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

## Prerequisites

- [Claude Code](https://claude.ai/code) installed and authenticated
- Node.js 18+ (for `npx skills`)

---

## Structure

```
claude-security-skills/
├── code-security/
│   ├── SKILL.md                   # Agent instructions
│   ├── AGENTS.md                  # Full security reference (Semgrep)
│   ├── README.md
│   └── rules/                     # 28 vulnerability rule files
│       ├── sql-injection.md
│       ├── xss.md
│       ├── command-injection.md
│       └── ...
├── secrets-management/
│   └── SKILL.md                   # Vault, AWS Secrets Manager, GitHub Secrets
└── dependency-management-deps-audit/
    ├── SKILL.md
    └── resources/
        └── implementation-playbook.md
```

---

## Credits

- `code-security` — [Semgrep Engineering](https://semgrep.dev) ([@DrewDennison](https://x.com/drewdennison))
- `secrets-management` — [wshobson/agents](https://github.com/wshobson)
- `dependency-management-deps-audit` — [sickn33/antigravity-awesome-skills](https://github.com/sickn33)
