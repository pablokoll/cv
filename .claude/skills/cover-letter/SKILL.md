# Skill: cover-letter

Generate a tailored cover letter for a specific job application.

## Trigger

User asks for a cover letter, or mentions it's required by the application.

## Inputs

- Job posting (paste or URL — or reuse from existing `job-resume-matcher` analysis)
- Optional: tone preference (formal / direct / concise)
- Optional: specific angle to emphasize (e.g., "highlight the Abbott LATAM project")

## Vault — Read First

Path: `/home/pablo/Dropbox/Aplicaciones/remotely-save/personal-vault/Projects/Personal/My Data/`

1. `Brand Core.md` — brand statement, values, target
2. `Achievements.md` — quantified results to pull from
3. `Experience Log.md` — real scope and contributions

If a `CV/jobs/empresa-puesto.md` exists for this role, read it — use the job summary and match data already parsed.

## Pablo's Contact Info

- Name: Pablo Koll
- Email: pablokollm@gmail.com
- Location: Madrid, Spain
- LinkedIn: linkedin.com/in/pablo-koll
- Portfolio: pablokoll.com

## Format

- Length: **200–350 words** — no filler, no generic openers
- Structure: 3 paragraphs
  1. **Hook** — why this role, why this company. Specific, not "I am excited to apply"
  2. **Body** — one concrete story or result that maps directly to the top requirement. Use a real achievement with metrics if possible.
  3. **Close** — what Pablo brings, direct call to action. No "I look forward to hearing from you" boilerplate.
- Tone: direct, confident, no buzzwords, no excessive enthusiasm

## Honesty rules (same as CV)

- Only reference real projects and contributions
- Don't claim skills or results not in the profile
- "Contributed to" and "worked on" are fine — no inflation

## Output

Deliver in two formats:

### Plain text (for email / portal paste)
```
[Date]

[Role] @ [Company]

[Body]

Pablo Koll
pablokollm@gmail.com | linkedin.com/in/pablo-koll | pablokoll.com
```

### LaTeX (for PDF via coverletter.tex)

Adapt `coverletter.tex` in the repo. Show the modified block ready to paste.

Build: spawn a subagent to run `npm run xelatex` in `/home/pablo/Work/personal/profile/cv/` — keeps output out of main context. Report success or relevant error lines only.

## After delivery

Ask:
- "Do you want to log this cover letter in the job entry?" → if yes, append a `## Cover Letter` section to `CV/jobs/empresa-puesto.md`
