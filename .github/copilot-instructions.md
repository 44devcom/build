# Copilot instructions for this repository

Purpose
- Help AI coding agents become productive quickly in this repository by documenting the small but important patterns that are discoverable from files present in the workspace.

Quick facts (repo state)
- Key files discovered: `_config.yml` and `t.sh`.
- There are no existing agent docs, workflows, or tests in the repo root.

Big picture (what to look for)
- Inspect `_config.yml` first — it contains global configuration (commonly Jekyll or static-site settings). Confirm the generator/tool by reading keys in the file before making changes.
- Open `t.sh` — this repository includes a top-level shell script. Treat it as an authoritative entrypoint for repo-specific tasks (build, deploy, or helper commands). Run `bash t.sh` locally or in CI to observe behavior before modifying it.

Developer workflows (how to verify changes)
- No CI/workflows were found. To validate changes locally:
  - Inspect and run `t.sh` with `bash t.sh` (run in a dev container if present).
  - If `_config.yml` contains keys like `theme`, `plugins`, `source` or `destination`, try invoking the expected tool (for example, Jekyll) only after confirming the dependency is actually used.

Project conventions & patterns
- This repo is minimal — prefer minimal, conservative edits. Conform to existing naming and structure (single `t.sh`, site config in `_config.yml`).
- Keep scripts POSIX/bash-friendly. `t.sh` appears to be a single script entrypoint — avoid duplicating its responsibilities without first checking its contents.

Integration points & dependencies
- No external services, packages, or manifests (package.json, pyproject.toml, Dockerfile, workflows) were found. If you add integrations, document them in README and update this file.

How Copilot/agents should operate here
- Start by reading `_config.yml` and `t.sh` to understand intent; do not assume frameworks until confirmed by file contents.
- When changing `t.sh`, run it locally to verify behavior; prefer small, reversible commits.
- If you add new build tools or dependencies, add a short usage note here and a simple verification command (one-liner) so future agents can run it non-interactively.

Examples (concrete)
- To inspect site config: `cat _config.yml` and search for `theme`, `plugins`, or `source` keys.
- To run the repository script: `bash t.sh` (observe stdout/stderr to understand side effects).

If something is unclear
- This repository is sparse — if the purpose of `_config.yml` or `t.sh` is not explicit, open an issue or ask the repo owner for the preferred local verification steps before making broad changes.

Next steps for maintainers
- If this repo is a website/site-template, add a README with build/test steps and a CI workflow; include those additions here so agents can run automated checks.

Please review this draft — tell me which parts are incomplete or where you'd like more specific examples.
