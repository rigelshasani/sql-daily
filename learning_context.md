# Consolidated Data Analytics Learning

**Last Updated:** September 9, 2025
**Day of Week:**  Day 2/7, Week 12
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

**Current Pacing:** Week 12 of 23 in an intensive 300-hour program. On track with 132/300 hours logged.

### High-Level Roadmap

* **Weeks 12–14:** Customer Analytics (Churn, Segmentation), BI Tools (Power BI/Tableau), and Regression
* **Weeks 15–18:** Portfolio expansion with advanced projects (Time Series, Attribution), advanced SQL, and completing all Pandas deep-dives
* **Weeks 19–23:** Finalize projects, conduct mock interviews, develop specialization, and launch job search

---

## 3. Progress Dashboard

**Overall Progress:** 139.30 / 300 hours (44% complete)
**This Week's Pace:** Day 2/7: 7.2 hours/22

```
SQL Proficiency
Advanced SQL               ████████░░░░░░░░░░░░  40% (32/80) ← Index optimization PASSED
├── CTEs/Recursive       ████████████████████ 100% ← MASTERED
└── Query Optimization   ████████░░░░░░░░░░░░  40% ← Index order & sargability PASSED

Python/Pandas Mastery
Performance Deep-Dives     ████░░░░░░░░░░░░░░░░   9% (4/45) ← Core focus (Gate B active)

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

* **SQL:** Advanced. Mastered CTEs, recursive queries, and index optimization patterns. Next focus: advanced query optimization.
* **Pandas:** Intermediate–Advanced. Strong in data manipulation. Growth area: performance optimization.
* **Statistics:** Foundational–Intermediate. Mastered A/B testing workflow. Ready for regression.
* **Data Visualization:** Foundational. Proficient in business-context charts. Next: interactive dashboards.

### Recent Breakthrough

**SQL Index Optimization (Sep 9, 2025)**: Mastered sargable rewrites including sign/zero-safe division handling and half-open time windows. Key insight: business logic determines edge case behavior (zero/negative values typically return FALSE).

### Previous Breakthrough

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

1. **Pandas Performance Optimization (6h):** Gate B - vectorization patterns, predicate pushdown, categorical dtypes.
2. **Churn & Customer Analysis (8h):** Build cohort retention curves and start customer segmentation project.
3. **SQL Optimization (4h):** Complete drills 171-180 (query optimization basics) - advanced patterns beyond sargability.
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
* **Status:** In progress / Passed (date).
* **Next Concept on Pass:** <topic>

### 7.2 Active Exit Rule — Pandas Performance

* **Checks (must all pass):**

  1. **Vectorization Patterns:**
     * Replace row-wise `.apply()`/`.iterrows()` with: (a) `.map()`/`.merge()` for lookups, (b) boolean masks/`np.select()` for conditional logic, (c) `.groupby().transform()` for group-aware operations.

  2. **Optimization Strategy:**
     * Demonstrate predicate pushdown before joins (filter early, join smaller).
     * Use categorical dtypes for low-cardinality string columns.

  3. **Performance Verification:**
     * Benchmark with timing comparisons showing meaningful speedup.
     * Include row count context and brief memory usage notes.

* **Progress (Sep 9, 2025):**
  * Vectorization Patterns: **PENDING**
  * Optimization Strategy: **PENDING** 
  * Performance Verification: **PENDING**

* **Status:** In progress.
* **Next Concept on Pass:** **Advanced SQL patterns** — window functions with frames, lateral joins, and recursive CTE optimization.

### 7.3 Completed Exit Rules

* **Gate A — SQL: Index Order & Sargability** ✅ **PASSED (Sep 9, 2025)**
  * Paper Test Mastery: **PASSED** - equality-prefix → first ORDER BY key rule
  * Rewrite to Sargable: **PASSED** - sign/zero-safe division + half-open time windows
  * Plan Verification: **PASSED** - Index Scan, no Sort, Index Cond with equality + range

### 7.4 Verification Protocol

* Start with conceptual understanding, then move to implementation.
* Benchmark on realistic data sizes (10K+ rows minimum).
* Document pattern statements and evidence for each successful optimization.

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

* **Gate A — SQL: Index Order & Sargability** ✅ **PASSED (Sep 9, 2025)**
* **Gate B — Pandas Performance (active)**
  * Replace row-wise `.apply`/`iterrows` with: (a) `map/merge`, (b) boolean masks/`np.select`, (c) `groupby().transform`.
  * Predicate pushdown before joins; use categorical dtypes for low-cardinality keys.
  * Benchmark: demonstrate speedup with timings and row count; include brief memory notes.
* **Gate C — Advanced SQL patterns (next on pass)**
  * Window functions with frames, lateral joins, recursive CTE optimization.

**Measurement**

* Per-session log line only: Evidence link + Gate status (pass/fail + what's missing).