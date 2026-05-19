# Skill: job-log

Log a job application to the vault. Creates or updates `CV/jobs/empresa-puesto.md`.

## Trigger

- Called automatically by `job-write-cv` and `job-resume-matcher` (on skip)
- Invokable standalone: "loggea esta oferta", "actualizá el job log"

## Vault Path

`/home/pablo/Dropbox/Aplicaciones/remotely-save/personal-vault/CV/jobs/`

Create the `CV/jobs/` folder if it doesn't exist.

## Inputs (from caller or user)

| Field | Source |
|---|---|
| Role title | Job posting |
| Company | Job posting |
| Slug | `empresa/puesto` format |
| Branch name | git branch (or passed from job-write-cv) |
| Match score | job-resume-matcher output |
| Status | `applied` / `skipped` / `interviewing` / `rejected` / `offer` |
| Job URL | Optional |
| Notes | Optional — red flags, standout requirements, context |
| Language | EN / ES |
| Date | Today's date |

## Output — `CV/jobs/empresa-puesto.md`

```markdown
---
company: [Company]
role: [Role Title]
slug: empresa/puesto
branch: empresa/puesto
date: YYYY-MM-DD
status: applied | skipped | interviewing | rejected | offer
match_score: XX%
language: EN | ES
url: [URL or "—"]
---

# [Role] @ [Company]

## Job Summary
[3-5 bullet points: what the role is, key requirements, stack, modality]

## Match Score: XX%
Required: XX%  |  Preferred: XX%

## Key Requirements
| Skill | Status |
|---|---|
| ... | ✅ / 〜 / ❌ |

## Gaps
- [skill]: [note]

## Red Flags
[skip if none]
- ...

## CV Branch
`empresa/puesto`

## Notes
[Any context: why applied, what to prep, concerns, follow-up actions]
```

## Status update

If the file already exists (re-running job-log for status update):
- Update the `status` frontmatter field
- Append a status change note at the bottom under `## Status History`

```markdown
## Status History
- YYYY-MM-DD: applied
- YYYY-MM-DD: interviewing
```

## After writing

Confirm to the user:
> "Logged at `CV/jobs/empresa-puesto.md` — status: [status]"
