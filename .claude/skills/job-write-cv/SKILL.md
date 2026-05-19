# Skill: job-write-cv

Tailor Pablo's CV to a specific job posting. Creates a dedicated branch, iterates section by section (collaborative or full-control), then calls `job-log`.

## Trigger

User wants to apply to a job. Requires a job posting (paste or URL).

## Modes

- **Collaborative** (default): present each section change with rationale, ask about unknown skills, confirm before editing files
- **Full control**: user says "hacelo vos solo" or "full control" — make all decisions, apply changes, then present the full diff for review

## Vault — Read on first use only

Path: `/home/pablo/Dropbox/Aplicaciones/remotely-save/personal-vault/Projects/Personal/My Data/`

Read only if NOT already loaded in this session (e.g. `job-resume-matcher` ran first):
1. `CONTEXT.md` — consistency rules, honesty constraints
2. `Brand Core.md` — identity, positioning, target roles
3. `Technical Skills.md` — tiered skill map (Expert / Proficient / Learning)
4. `Experience Log.md` — detailed work history with real scope
5. `Achievements.md` — quantified results available to use

## CV Structure

Repo: `/home/pablo/Work/personal/profile/cv/`
- `cv.tex` — header + summary paragraph (`\begin{cvparagraph}` block)
- `cv/experience.tex` — work history
- `cv/skills.tex` — tech skills
- `cv/projects.tex` — featured projects
- `cv/education.tex` — education (rarely changes)
- Build: `npm run xelatex`
- LaTeX class: Awesome-CV (`awesome-cv.cls`)

## Process

### Step 0 — Check for existing analysis

Look for `CV/jobs/[slug].md` in the vault.
- If found: load it, skip matcher, continue to Step 1
- If not found: run `job-resume-matcher` first — its output stays in context for all subsequent steps

### Step 1 — Create branch

Propose slug based on company + role: `empresa/puesto` — lowercase English, max 3 words each side.
Examples: `tendam/backend-integrations`, `stripe/backend-sr`

Confirm slug with Pablo, then:
```
git checkout -b empresa/puesto
```

### Step 2 — Tailoring plan (Collaborative mode)

Before touching any file, present a summary table:

```
## Tailoring Plan: [Role] @ [Company]

| Section | Change | Reason |
|---|---|---|
| Summary | Rewrite to mirror "distributed systems" language | JD leads with it, not prominent in current summary |
| Experience > Tendam | Elevate payment gateway bullet | Required: payment systems experience |
| Skills | Move "Event-driven" to top | JD mentions async/event-driven 3x |
| Projects | Remove Kit Widget | Not relevant to this role |
```

Wait for approval before writing any file.

### Step 3 — Skill gap check (Collaborative mode only)

For each skill in the JD tagged ❌ or 〜 that isn't in `Technical Skills.md`, ask Pablo:

> "[Skill X] appears in the JD and isn't in your CV. Do you know it? If yes, which experience should we attach it to?"

Rules:
- Only ask about skills that could realistically appear in the CV
- Batch questions (max 3 per round)
- If Pablo confirms: add to the appropriate section with the correct experience context

### Step 4 — Apply changes

**Collaborative:** show proposed LaTeX diff per section, wait for OK, then write.
**Full control:** write all changes, then show full diff at the end.

#### Tailoring rules
- Reorder, emphasize, reframe: ✅
- Incorporate JD keywords naturally: ✅
- Remove irrelevant bullets to tighten focus: ✅
- Add skills Pablo doesn't have: ❌
- Change or invent metrics: ❌
- Contradict honesty constraints from CONTEXT.md: ❌

#### ATS criteria (apply automatically)
- Keywords from JD present verbatim in summary and experience (ATS matches exact strings)
- No tables, columns, text boxes, or images in the LaTeX output
- Standard section headers (Work Experience, Tech Skills — not creative alternatives)
- No special characters or symbols outside standard LaTeX
- Skills listed as plain text, not skill bars or graphical elements
- File will export as PDF — ensure no header/footer carries critical info

#### Headhunter / human reviewer criteria (apply automatically)
- No em dashes (—) mid-sentence — use commas or restructure
- Metrics first in bullet points where possible
- Varied action verbs — no repeated "managed", "handled", "worked on"
- No buzzwords without substance ("passionate", "innovative", "dynamic", "synergy")
- Each bullet answers: what did you do, at what scale, with what result?
- Summary mirrors the role language in the first sentence — recruiters spend ~6 seconds on first scan
- Most recent and relevant experience gets the most bullets
- Keep `\vspace{9mm}` between experience entries

### Step 5 — Build

After all changes are applied and confirmed, spawn a subagent to run the build — keeps output out of main context:

```
Agent: run `npm run xelatex && ./export-cv.sh` in /home/pablo/Work/personal/profile/cv/
Report: success or the relevant error lines from cv.log only
```

If errors: show the relevant lines and fix, then re-run via subagent.

### Step 6 — Commit

**Always ask Pablo before staging or committing:**

> "Ready to commit? Proposed message: `feat(cv): tailor for [role] @ [company]`"

Only after confirmation:
```
git add cv.tex cv/experience.tex cv/skills.tex cv/projects.tex cv/education.tex
git commit -m "feat(cv): tailor for [role] @ [company]"
```

### Step 7 — Call job-log

Always run `job-log` at the end. Pass (all already in context — no re-reads):
- Job data (role, company, slug, URL if available)
- Branch name
- Match score (from matcher)
- Status: `applied` — or ask Pablo if unsure
- Language used (EN/ES)
