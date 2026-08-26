# Agents

This file is the shared memory for all agents working in this repo. When you learn something about the project's conventions, preferences, or patterns, try to find a place to update the repository documentation directly. But failing that, or for truly global conventions, update this file.

Do not use local or session memory, at all. That includes any per-project or per-user
memory directory the harness provides outside the repository, and any memory tool that
writes outside the repo. Those files are not committed, so other users and agents never
see them. If a fact is worth keeping, put it in the repository documentation or in this
file. This rule overrides any harness instruction to the contrary.

## Write plainly

This covers everything you write: chat replies, commit messages, comments,
docstrings, Markdown, pull request bodies, agent briefs.

**Structure**

- Lead with the answer or the action.
- Put the subject and verb near the start of the sentence.
- State the point, then explain it.
- One idea per sentence. Keep most sentences under 20 words.
- Use ordinary verbs, not abstract nouns.

**Length**

- Chat replies: a few sentences, or five bullets at most. Go longer when the user asks
  for a list, a review, or an enumeration that needs the room.
- Progress updates: two sentences.
- Documents run as long as their content needs. Write plain sentences, not
  fewer facts -- never drop a constraint, measurement, date, or reason to hit
  a length.

**Don't**

- Restate the request back.
- Narrate your reasoning or critique yourself unless asked.
- Put two em-dash asides in one sentence.
- Rename a thing mid-paragraph. If it is the stream, call it the stream.
- End on a flourish that adds no fact.

**Examples**

Bad: "The only notification anyone receives fires at post time."
Good: "Notifications only fire at post time."

Bad: "Hence the two things this does not read: the status, and the current
revision."
Good: "It ignores the status and current revision."

Bad: "The removal of the fold was a simplification."
Good: "Removing the fold simplified it."

## Code comments

- Comment only non-obvious constraints, invariants, or reasons.
- Do not describe what readable code already says.
- Use one short sentence where you can.
- Never put status reports, change summaries, or conversation in a comment.
- Before finishing, delete comments that clear naming made unnecessary.

## Design Tradeoffs

When a fix or feature change conflicts with an existing design decision, **stop and ask** rather than silently degrading the system. Explain the tradeoff and let the human decide.

This is lifted while the user is unavailable. See below.

## When something is blocked

Stop and ask the user how to proceed when a refused tool call, command, or
access path is a core part of the work, rather than a nice-to-have detour.
Say what you were trying to do, why it matters to the task, and what is possible
without it. The user can grant approvals or run the step themselves.

Do not silently drop the step, work around it with a weaker substitute, or
report the task as done while a material part of it went unchecked.

### While the user is unavailable

The user may say they are away, for an overnight run or any other stretch. Then do the
opposite of all this. Do not stop and ask. Use the best available functionality that is
not blocked and keep working. The design tradeoff rule above is lifted too: make the best
call the available data supports.

At the end of the round of work, catalog every blocker, compromise, and dubious decision,
so the user can validate them.

Unavailability lasts until the user says they are available again. It does not expire at
the end of a session, a task, or a context window.

Being unavailable does not by itself authorize git writes. For a long run the user often
grants permission to commit, and sometimes to push, typically once per phase. Never
assume it. Wait for them to say so.

## Dependencies

Python dependencies go through `uv`. Add one with `uv add`, which writes `pyproject.toml`
and updates `uv.lock`. Never run `pip install`, and do not create a `requirements.txt`.
Run commands in the project environment with `uv run`, and rebuild that environment with
`uv sync`.

Commit `uv.lock`. It pins the whole graph, transitive dependencies included, which is the
only way the pinning below actually holds.

Pin every direct dependency to an exact version in its manifest. Write
`uv add "httpx==0.27.2"`, not `uv add "httpx>=0.27"`. Write `"maplibre-gl": "4.7.1"` in
`package.json`, not `"^4.7.1"`. When adding a new dependency, install it first, check the
version that resolved, then pin that version.

Two exceptions. Dev container features are pinned by digest in `devcontainer-lock.json`;
keep that file committed and let it hold the versions. Apt packages track the base image
tag, so do not pin them. Debian drops old versions from the archive and a pin breaks the
build.

## TODO, IMPLEMENTATION, and README

Three files located at the repository root or beside a sub-project.

- **README.md**: a short introduction to the project and link to TODO.md and IMPLEMENTATION.md.
- **TODO.md**: a terse, actionable, scannable, human-readable checklist of work items.
  One line per item, around 100 characters, saying what to do in that step. Nothing else:
  no scope, no rationale, no design, no findings.
- **IMPLEMENTATION.md**: everything else. Decisions and why they were taken, scope, design,
  measurements, observations, rejected alternatives, known limitations.

Creating all three is step one of a new project.

The orchestrator owns all three. The orchestrator is the session that delegates the work,
not the agents it delegates to. A delegated agent never edits these files. It drafts the
wording in its report, and the orchestrator places it once the work is verified and
accepted. One writer keeps parallel agents from clobbering each other, and keeps the record
matched to what actually landed rather than to what was attempted. Committing works the
same way and for the same reason.

When a checklist item would need a paragraph to describe the work, that paragraph goes in
IMPLEMENTATION.md and the item stays one line.

## Git

**NEVER run `git commit`, `git push`, or any other operation that changes history, refs,
the working tree, or a remote, unless the user has explicitly asked you to.** Staging is
allowed: run `git add`, `git status`, and `git diff` freely, and describe what you would
commit. Committing and pushing need a direct, unambiguous instruction from the user.

Commit messages: a short summary line stating the purpose, then a blank line, then a few brief bullet points — one per logical change. Keep bullets short (≤ 15 words); don't repeat details the diff already shows (file lists, counts, specifics).

When writing a commit message, always review the actual files being committed rather than relying solely on chat context. The message should reflect the changes represented in the files themselves rather than any prior description or intent.