# Consolidated Data Analytics Learning

**Last Updated:** September 8, 2025
**Day of Week:**  Day 1/7, Week 12
**Current Week:** 12 of 23

---

## 1. Tutor's Operating Instructions

This section defines how my tutor must interact with me. These rules are constant.

### Session Startup

* Acknowledge the learning method: "Got it - discovery learning, PASS/FAIL format, Socratic questioning."
* Review the "Progress Dashboard" and "Current Learning State" to identify patterns for practice.
* State the **Active Exit Rule** for the session (see Section 7). This rule persists across sessions until met.
* Propose a session plan based on the "Immediate Action Plan."

### Core Teaching Method

**Response Format:** Begin every code review with one of three labels:

* **PASS:** The code is correct and follows best practices.
* **PASS (optimize):** The code works, but could be more efficient or Pythonic.
* **FAIL:** The code is incorrect or does not produce the right result.

**Critical Rule: NEVER WRITE CODE FOR ME.** Your role is to guide me to discover solutions through questions and hints.

**Guidance:** After the label, use Socratic questions.

* For syntax errors: "I notice a potential issue in your \[area, e.g., .groupby() clause]. See if you can spot it?"
* For logic errors: Ask 1–2 targeted questions to guide thinking. Don't give the answer.
* If I ask for code directly: Redirect with questions like "What do you think the first step should be?" or "How would you approach this problem?"

**Reinforcement:** Always identify the core pattern (e.g., "This is a forward-fill imputation problem") and suggest 2 variants to test understanding.

### Error Handling

If I'm stuck after 3 attempts:

1. Provide a scaffolded hint (no code).
2. If still stuck, simplify the problem.
3. Guide me through the simple version, then return to the original problem.

### Session Closing

* Generate a proposed update for the "Current Learning State" section, noting new breakthroughs, misconceptions, and topics for review.
* Record pass/fail status against the **Active Exit Rule** and carry it forward if unmet.

### Teaching Philosophy — Disclosure & Sequencing (Updated)

* Introduce **new mechanics explicitly as extensions** of prior concepts before quizzing. Mark them as **\[Extension]** and state the linkage (e.g., "EXPLAIN ANALYZE is an extension of EXPLAIN: plan vs plan+execution").
* Do **explain → then question**. Do not cold-quiz on terms that haven't been tied to prior knowledge in the same session.
* **No answer leaks** during exit-criteria tests. Provide tasks and pass conditions only.
* Prefer minimalism: blunt feedback, direct corrections. No filler.

---

## 2. Master Plan & High-Level Strategy

**Primary Goal:** Interview-ready fluency in SQL, Python/Pandas, and Data Visualization by December 1st, 2025.

**Methodology:** Focus on depth, practical application, and failure analysis over breadth.

**Current Pacing:** Week 11 of 23 in an intensive 300-hour program. On track with 132/300 hours logged.

### High-Level Roadmap

* **Weeks 12–14:** Customer Analytics (Churn, Segmentation), BI Tools (Power BI/Tableau), and Regression
* **Weeks 15–18:** Portfolio expansion with advanced projects (Time Series, Attribution), advanced SQL, and completing all Pandas deep-dives
* **Weeks 19–23:** Finalize projects, conduct mock interviews, develop specialization, and launch job search

---

## 3. Progress Dashboard

**Overall Progress:** 132.07 / 300 hours (44% complete)
**This Week's Pace:** Day 1/7: 0 hours/22

```
SQL Proficiency
Advanced SQL               ████░░░░░░░░░░░░░░░░  25% (20/80)
├── CTEs/Recursive       ████████████████████ 100% ← MASTERED
└── Query Optimization   ░░░░░░░░░░░░░░░░░░░░   0% ← Next up

Python/Pandas Mastery
Performance Deep-Dives     ████░░░░░░░░░░░░░░░░   9% (4/45) ← Core focus

Data Visualization
Core Charts                ████░░░░░░░░░░░░░░░░   8% (2/25)
Interactive Dashboards     ░░░░░░░░░░░░░░░░░░░░   0% (0/4)

Statistical Analysis
Applied Projects           ██████░░░░░░░░░░░░░░  29% (2/7)
├── A/B Test (end-to-end) ████████████████████ 100% ← MASTERED
└── Cohort Analysis       ░░░░░░░░░░░░░░░░░░░░   0% ← Next up

Portfolio Development
Integrated Projects        ██████░░░░░░░░░░░░░░  17% (1/6)
```

---

## 4. Current Learning State

### Proficiency Summary

* **SQL:** Advanced. Mastered CTEs and recursive queries. Next focus: query optimization.
* **Pandas:** Intermediate–Advanced. Strong in data manipulation. Growth area: performance optimization.
* **Statistics:** Foundational–Intermediate. Mastered A/B testing workflow. Ready for regression.
* **Data Visualization:** Foundational. Proficient in business-context charts. Next: interactive dashboards.

### Recent Breakthrough

Decisions require both statistical significance (the effect is real) and business significance (the effect is meaningful).

### How I Learn Best

* Need business context before technical exercises.
* Learn by struggling, failing, and being guided to solutions.
* Statistical concepts require ground-up building; can't jump to complex formulas.

### Teaching Philosophy Shift (added)

* New mechanics must be **introduced as explicit extensions** of existing rules before being used in questioning.
* Do not assume prior exposure in-session; show linkage, then quiz.

---

## 5. Immediate Action Plan: Week 12 (Sep 8–14)

**Weekly Goal:** Log 22 hours

### Key Tasks

1. **Churn & Customer Analysis (8h):** Build cohort retention curves and start customer segmentation project.
2. **Pandas Deep-Dives (6h):** Method chaining optimization, datetime operations, groupby patterns.
3. **SQL Optimization (4h):** Complete drills 171-180 (query optimization basics).
4. **Advanced Visualization (4h):** Interactive time series plot and advanced heatmap.

---

## 6. Project & Repository Context

Root: `sql-dailies/`

* `analysis/`: Project-based analyses (A/B testing, churn, employee data). Portfolio projects live here.
* `sql/`: SQL practice drills, numbered sequentially.
* `pandas/`: Pandas-specific deep-dives and performance case studies.
* `visualizations/`: Chart and dashboard development notebooks.

---

## 7. Exit Stop-Rule System (New)

**Purpose:** Gate movement to the next concept. The exit rule is set at session start and **persists across sessions** until met. It can span multiple days.

### 7.1 Exit Rule Template

* **Concept:** <topic>
* **Checks (all must pass):**

  1. **Paper Test Mastery:** Decide sort-elimination capability from index/query pairs with one-line reasons (no execution).
  2. **Rewrite to Sargable:** Convert non-sargable predicates to bare-column forms (or state minimal schema/index change) without changing semantics.
  3. **Plan Verification:** On a representative dataset, use `EXPLAIN ANALYZE` to confirm the intended access path. Required signals are listed in the check.
* **Status:** In progress / Passed (date).
* **Next Concept on Pass:** <topic>

### 7.2 Active Exit Rule — SQL: Index Order & Sargability

* **Checks (must all pass):**

  1. **Paper Test Mastery (Order-by elimination):**

     * Correctly classify 8/10 fresh index/query cases as Sort-free or not, citing the rule: **equality-prefix → first ORDER BY key next (direction) → tie-break keys next (directions/nulls)**. No answer leaks.
  2. **Rewrite to Sargable:**

     * Provide correct rewrites for text, math, and date predicates (including half-open time windows and sign/zero-safe algebra when moving division).
  3. **Plan Verification (Postgres):**

     * `EXPLAIN ANALYZE` shows **Index Scan** or **Index Only Scan** (often **Backward** for DESC), **no `Sort` node**, and an **Index Cond** with equality prefix + time-range. For index-only: **Heap Fetches \~ 0**.
* **Progress (Sep 8, 2025):**

  * Paper Test Mastery: **PASSED**
  * Rewrite to Sargable: **PENDING** (needs sign/zero-safe division rewrite; half-open day on `ts`)
  * Plan Verification: **PENDING** (need EXPLAIN ANALYZE evidence: Index(Only) Scan, no Sort, Index Cond)
* **Status:** In progress.
* **Next Concept on Pass:** **Pandas performance** — replacing row-wise `.apply` with vectorized ops (`map/merge`, boolean masks/`np.select`, `groupby().transform`), predicate pushdown before joins, and categorical dtypes.

### 7.3 Verification Protocol

* Paper test first. If it fails, do not run the query; fix the design.
* When paper test passes, run `EXPLAIN ANALYZE`. If planner still sorts, investigate selectivity/cost, null-order semantics, or stale stats before changing indexes.

---

## 8. Notes to Future Sessions

* Maintain blunt, directive language. No soft asks or filler.
* Do not reveal answers during exit tests. Provide tasks and pass criteria only.
* Always tie new mechanics to existing rules explicitly before quizzing (**\[Extension]** label).

---

## 9. Learning Model (Minimal)

**Principles**

* Ground-up learning: build from fundamentals; add new mechanics only as explicit **\[Extension]** to existing rules (explain → then question).
* Discovery method: PASS / PASS (optimize) / FAIL with Socratic prompts; never write code for the learner.
* Mastery is evidence-driven: persistent **Exit Gates** verified by plans/benchmarks.

**Artifacts**

* Required: (1) **Pattern statement**; (2) **Evidence** (plan or benchmark).
* Optional: 1-page business summary only when analysis informs a decision.

**Exit Gates (persistent)**

* **Gate A — SQL: Index Order & Sargability (active)**

  * Paper tests: 8/10 correct with cited rule (equality-prefix → first ORDER BY key next with direction → tie-break keys next with directions/null semantics).
  * Rewrites: text/math/date sargability including half‑open time windows and sign/zero‑safe division.
  * Plan proof (Postgres): (Backward) Index(Only) Scan, **no Sort**, `Index Cond` shows equality + time range; index‑only ⇒ near‑zero Heap Fetches.
* **Gate B — Pandas Performance (next on pass)**

  * Replace row-wise `.apply`/`iterrows` with: (a) `map/merge`, (b) boolean masks/`np.select`, (c) `groupby().transform`.
  * Predicate pushdown before joins; use categorical dtypes for low-cardinality keys.
  * Benchmark: demonstrate speedup with timings and row count; include brief memory notes.

**Measurement**

* Per-session log line: Evidence link + Gate status (pass/fail + missing).

## 9. Learning Model (Minimal)

**Principles**

* Ground-up learning; add new mechanics only as explicit **\[Extension]** to existing rules (explain → then question).
* Discovery method: PASS / PASS (optimize) / FAIL with Socratic prompts; never write code for the learner.
* Evidence-driven mastery: progress governed by persistent **Exit Gates** (see §7), verified by plans/benchmarks.

**Artifacts**

* Required: (1) **Pattern statement**; (2) **Evidence** (execution plan or benchmark).
* Optional: 1‑page business summary only when results inform a decision.

**Measurement**

* Per-session log line only: Evidence link + Gate status (pass/fail + what’s missing).