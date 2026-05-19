# Skill: job-resume-matcher

Analyze a job posting against Pablo's profile before applying. Honest, realistic. No hype.

## Trigger

User pastes or links a job posting. Runs standalone or auto-called by `job-write-cv` if no prior analysis exists.

## Inputs

- Job description (paste or URL — fetch if URL)
- Optional: preferred CV language (EN default)

## Vault — Read on first use only

Path: `/home/pablo/Dropbox/Aplicaciones/remotely-save/personal-vault/Projects/Personal/My Data/`

Read only if these files are not already in context:
1. `CONTEXT.md` — consistency rules, honesty constraints
2. `Brand Core.md` — identity, target roles, what Pablo is NOT looking for
3. `Technical Skills.md` — tiered skill map (Expert / Proficient / Learning)
4. `Experience Log.md` — detailed work history with real scope and contributions

Skip reads if `job-write-cv` already loaded them earlier in the session.

## CV Files (for reference, not editing)

Repo: `/home/pablo/Work/personal/profile/cv/`
- `cv.tex` — summary paragraph
- `cv/experience.tex`, `cv/skills.tex`, `cv/projects.tex`, `cv/education.tex`

## Process

### 1. Parse the job posting

Extract:
- **Role title** — clean, no fluff
- **Company** — name, industry, stage if inferable
- **Location / modality** — remote / hybrid / on-site
- **Required skills** — hard requirements
- **Preferred skills** — nice-to-haves
- **Day-to-day focus** — what does this person actually do?
- **Stack / tech** mentioned
- **Red flags** — "rockstar", "wear many hats", no salary, overloaded JD, etc.

Generate slug: `empresa/puesto` — lowercase English, max 3 words each side, hyphen-separated.
Examples: `tendam/backend-integrations`, `mercadolibre/backend-sr`

### 2. Map against Pablo's profile

Tag each requirement:
- ✅ Strong match — direct production experience
- 〜 Partial match — adjacent, transferable, or Learning tier
- ❌ Gap — no evidence in profile or vault

### 3. Score

- Required weight: **70%** | Preferred weight: **30%**
- `score = (matched_required / total_required * 0.7 + matched_preferred / total_preferred * 0.3) * 100`
- Target to recommend applying: **≥ 70%**

### 4. Brand fit check

- Does role match target roles? (Backend / Integration / Platform / Solutions / Middleware Engineer)
- Company profile: tech-first or legacy-heavy?
- Any "not looking for" signals from Brand Core?

## Output

```
## [Role] @ [Company]
Slug: empresa/puesto  |  Location: ...  |  Modality: ...

### Match Score: XX%
Required: XX%  |  Preferred: XX%

### Skills Map
| Skill | Type | Status |
|---|---|---|
| ... | Required | ✅ / 〜 / ❌ |

### Gaps
- [skill]: [one line — how far is Pablo from this?]

### Red Flags
[skip section if none]
- ...

### Brand Fit
- Role: ✅ / ⚠️ / ❌
- Company: [note]
- Concerns: [if any]

### Verdict
[One honest paragraph. Should Pablo apply? If score <70% or brand misalignment, say so directly.]
```

## On low match or misalignment

1. Show analysis
2. Say clearly it's not a strong fit
3. Ask: "Log this and move on, or apply anyway?"
   - "Log and move on" → call `job-log` with `status: skipped`, stop
   - "Apply anyway" → hand off to `job-write-cv`

## Handoff to job-write-cv

Pass as context (already in session — no re-reads needed):
- Parsed job data (role, company, slug, stack, requirements map)
- Match score + gaps list
- Red flags
- Preferred language (EN/ES)
