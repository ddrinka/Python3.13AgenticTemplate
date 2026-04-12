# Agents

This file is the shared memory for all agents working in this repo. When you learn something about the project's conventions, preferences, or patterns, try to find a place to update the repository documentation directly. But failing that, or for truly global conventions, update this file. Do not depend on local/session memory. Those aren't committed to the repo and aren't available for other users or agents to reference.

## Running Commands

Don't tail the output of commands you run (e.g. `| tail`), as this masks failures. Read the full output directly, or tee it to a file (`| tee output.log`) if you anticipate it being very large.

## Design Tradeoffs

When a fix or feature change conflicts with an existing design decision, **stop and ask** rather than silently degrading the system. Explain the tradeoff and let the human decide.

## Dependencies

Pin package versions to exact versions in `package.json` (e.g. `"maplibre-gl": "4.7.1"`, not `"^4.7.1"`). When adding a new dependency, install it first, check the installed version, and pin that version.

## Documentation

Project documentation:

| Document | Purpose |
|----------|---------|
| [README.md](README.md) | Project overview and quick start |
| [TODO.md](TODO.md) | Phased development plans with acceptance criteria and test specs |
| [IMPLEMENTATION.md](IMPLEMENTATION.md) | Architecture, data model, edge cases, and design decisions |

Document directory hierarchy, not individual filenames. Don't list specific counts, file-by-file breakdowns, data sizes, or row counts — these go stale when data changes. When counts are necessary, note the date they were captured.

## Git

**NEVER run `git commit`, `git push`, or any other git write operation unless the user has explicitly asked you to.** Stage files, show diffs, and describe what you would commit — but do NOT commit or push without a direct, unambiguous instruction from the user.

Commit messages: a short summary line stating the purpose, then a blank line, then a few brief bullet points — one per logical change. Keep bullets short (≤ 15 words); don't repeat details the diff already shows (file lists, counts, specifics).

When writing a commit message, always review the actual files being committed rather than relying solely on chat context. The message should reflect the changes represented in the files themselves rather than any prior description or intent.