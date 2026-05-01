---
name: design-doc-writer
description: Generate an engineering design doc grounded in the actual repository. Triggers on "design doc", "tech spec", "RFC", "design proposal", and on indirect phrasings like "design X", "spec this out", "plan this refactor", "think through the architecture of Y". Reads the codebase to ground design in real types and modules; structures the doc data-model-first, with API and architecture as consequences; surfaces trade-offs explicitly; applies a rubric drawn from canonical software-design literature (Parnas, Liskov, Ousterhout, Bloch, Brooks); produces sequential implementation milestones with literal file paths so each milestone can be executed by a follow-up prompt. Plan-mode-friendly.
---

# Design Doc Writer

## Workflow

1. **Establish scope.** Project name, problem, size. Right-size: 1–3 pages small. For large projects, keep *this* doc focused on macro-architecture, data model, and milestones; if a single milestone is itself complex, recommend spawning a child design doc rather than expanding this one.

2. **Ground the design in the codebase before drafting Section 6.** Read schema files, type definitions, migrations, and the modules that will change. Note conventions: API shape, error model, state, testing style. Contradictions with existing patterns become explicit trade-offs, not silent overrides.

3. **Confirm context before fabricating it.** If evidence for *Why*, success metrics, or the data model is missing, ask one or two specific questions. Do not invent plausible-sounding content.

4. **Produce the doc** using the Structure below, applying the Doc principles throughout and the Design rubric in Section 6.

5. **Save to the repo.** Default `docs/design/<short-slug>.md`. Follow the repo's existing convention if there is one.

6. **Self-check.** Any rubric violation surfaced as an explicit trade-off in *Key decisions*, never smuggled in.

## Doc principles

- **Surface trade-offs.** Every non-trivial choice as *Decision → Why → Trade-off accepted.* Don't describe what will be built; describe the choices and why. (Google.)
- **Prose for reasoning, bullets for lists.**
- **Non-goals are rejected plausible goals**, not empty negations.
- **Why cites real evidence** — quotes, ticket counts, metrics, gaps — and answers "why now." (Amazon working-backwards; Stripe users-first.)
- **Success has numbers:** primary metric (baseline → target) plus a guardrail metric.
- **Risks (could-go-wrong) ≠ Open Questions (not-yet-known).** Separate sections. (Monzo.)
- **Right-size.** Past 20 pages, split. (Uber proportionality.)
- **Data and abstractions before APIs and architecture** — they are causes, not peers.

## Structure

1. **Header** — title, status, date, links.
2. **TL;DR** — 3–6 sentences: what, why now, key technical bet.
3. **Why** — problem + evidence + why now, prose.
4. **Goals & Non-Goals.**
5. **Users & Success Metric** — persona, core user story, primary + guardrail metric.
6. **Design** — sub-sections in order, each constrains the next:
   - **6a. Data model** — entities, fields with types, relationships, lifecycle (create / update / delete / retention). Mark PII. **If existing tables change, define the migration strategy** (backfill plan, nullable-first columns, dual-write windows, deprecation steps).
   - **6b. Modules & abstractions** — for each: what it represents, what design decision it hides, what depends on it. Distinguish new modules from existing ones being changed.
   - **6c. API / interface** — public surface, versioning, error model. Falls out of 6b.
   - **6d. Architecture** — components and interactions, with **literal repo file paths** (e.g. `src/lib/auth/session.ts`), not abstract box-and-wire names. Diagram over paragraphs.
   - **6e. UX notes** (if user-facing).
   - **Key decisions & trade-offs** — *Decision / Why / Trade-off / Alternatives rejected.*
7. **Alternatives Considered** — for each: what, why reasonable, why rejected. Include "do nothing." If you cannot say why an alternative was reasonable, you did not consider it.
8. **Cross-cutting** (apply if relevant, else N/A): Security & Privacy, Reliability & Performance, **Observability** (failure metrics, alert triggers, rollback/recovery procedure), Cost, Accessibility / i18n.
9. **Rollout** — feature flags, phases, rollback.
10. **Risks** — table: Risk | Likelihood | Impact | Mitigation.
11. **Open Questions.**
12. **Implementation Milestones** — sequential, shippable units, dependency-ordered (typically: migrations → data access → domain logic → API → UI). Each milestone:
    - **Files to create/modify** (literal paths).
    - **Definition of done**, including the specific tests that must pass (unit / integration / E2E, named per milestone — not a vague upfront promise).
    - The user runs each milestone with *"Execute Milestone N."*

## Design rubric (apply in Section 6)

Each rule names its canonical term so the established literature applies in full. Each must be met, or the violation surfaced as an explicit trade-off in *Key decisions*.

1. **Data-first design.** Specify the data model — entities, fields, types, relationships, lifecycle — before any function or endpoint. Code follows data, not the reverse. (Brooks; Torvalds on data structures.)

2. **Single source of truth.** Each fact computed in exactly one place and read everywhere else. Two definitions of the same fact will drift. (DRY applied to facts and invariants.)

3. **Information hiding.** Each module encapsulates one design decision likely to change, behind an interface that reveals as little as possible about its internals. Modules are bounded by *what changes together*. (Parnas, 1972.)

4. **Deep modules.** Interfaces small relative to the functionality hidden. Many public methods or many parameters = shallow module leaking complexity into callers. Push complexity inward. (Ousterhout, *A Philosophy of Software Design*.)

5. **Single responsibility and cohesion.** One concept per type, one responsibility per function. Description with "and" → split. Defined by behavioral contract, not internals. (SRP; Liskov substitution.)

6. **APIs hard to misuse.** Caller's view, not implementer's. Required parameters first; no boolean flags that switch behavior; return one type with `Optional`/`Result` for failure, not unions or nullables; explicit typed errors. (Bloch, *How to Design a Good API*.)

7. **Default to omission.** Add a parameter, method, type, or field only when a current caller requires it. Adding later is cheap; removing breaks every caller. (Bloch.)

## Self-check

- Section 6 follows order: data → abstractions → API → architecture.
- 6a defines lifecycle and migration strategy where existing tables change.
- 6b names what each module hides.
- 6d uses literal file paths, not abstractions.
- No fact computed in more than one place.
- Each rubric violation surfaced as an explicit trade-off.
- Alternatives explain reasonableness AND rejection.
- Non-goals are plausible-goals-rejected.
- Why grounded in evidence; success has numbers.
- Risks and Open Questions are separate.
- Skipped sections marked N/A with reason.
- Milestones are dependency-ordered with literal files and named tests.
