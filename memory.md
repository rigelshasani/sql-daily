# Moving Memory - SQL/Pandas Learning

**Last Updated:** Aug 26, 2025
**Session #:** 71-72 (Pandas compression analysis & consecutive hires)

> **Usage Note:** This is a rolling document - update it each session. The reflection prompts get overwritten each time. Archive important insights in the "Notes & Insights" section for permanent reference.

> **Usage Note:** This document has both **persistent sections** (that accumulate over time) and **rolling sections** (that get updated each session).

## PERSISTENT MEMORY (Accumulates Over Time)

### Historical Breakthroughs
*Major "aha" moments - keep forever*

* **Aug 2025:**

  * *Concept:* Importance of normalization before weighted composite scoring.
  * *What made it click:* Seeing how raw dollar differences in salary overwhelmed years and levels.
  * *Impact:* Now always define scale, scope, direction, and guard when building features.

* **Aug 2025:**

  * *Concept:* Using cross joins for dept pair comparisons.
  * *What made it click:* Realizing self-merges can be reduced with `how='cross'` and filtering on `dept_x < dept_y`.
  * *Impact:* Confident in building symmetric matrices and avoiding duplicate pairs.

* **Aug 2025:**

  * *Concept:* Department-level vs employee-level calculations.
  * *What made it click:* Realizing compression ratio is a department metric, not per-employee.
  * *Impact:* Now think carefully about aggregation level before starting calculations.

### Conquered Struggles
*Patterns I used to struggle with but have now mastered*

* **Pattern:** Column selection brackets (`df['col']` vs `df[['col']]`) - *Resolved: Jul 2025*

  * *Original issue:* Confused when result was Series vs DataFrame.
  * *What finally solved it:* Writing self-guide with explicit examples.

* **Pattern:** Boolean logic with `&` and `|` - *Resolved: Jul 2025*

  * *Original issue:* Mixing `and`/`or` with pandas.
  * *What finally solved it:* Habit of always wrapping each condition in parentheses.

* **Pattern:** Within-group operations (shift, cumsum) - *Resolved: Aug 2025*

  * *Original issue:* Operations crossing group boundaries.
  * *What finally solved it:* Always use `.groupby()` before shift/cumsum for group-wise operations.

### Learning Patterns About Myself
*Meta-insights about how I learn best*

* Must merge → rename → drop throwaways immediately, or confusion compounds.
* Need to state population before filtering, otherwise denominators drift.
* Breakthroughs come only after repeating the same pattern in 2–3 contexts.
* Kinesthetic learner - need to fail and fix rather than receive solutions.

### Progress Milestones
*Major achievements and skill level ups*

* **Jul 2025:** SQL drills 1–150 complete.
* **Jul 2025:** Pandas Exercises P001–P035 complete.
* **Aug 2025:** Exercises P051–P060 (performance simulation with normalized scoring) complete.
* **Aug 2025:** Exercises 1-60 complete (skipped 47, 49 from 45-50 set).
* **Aug 2025:** Started advanced consolidation exercises 71-80.

## ROLLING MEMORY (Updates Each Session)

### Current Focus Areas
*What am I actively working on right now?*

* [x] **Primary Topic:** Advanced pandas consolidation exercises
* [x] **Secondary Topic:** Department-level analytics and consecutive event detection
* [x] **Exercise Range:** 71-80 (completed 71-72, working on 73)

### Active Struggle Patterns
*What keeps tripping me up right now?*

#### Conceptual Struggles

* [ ] **Pattern:** Recursive hierarchy traversal in pandas

  * *Issue:* Need iterative/loop approach for multi-level reporting structures.
  * *Frequency:* Medium
  * *Last encountered:* Aug 26, 2025

#### Syntax/Technical Struggles

* [ ] **Issue:** Choosing correct aggregation level before calculations
  * *Context:* Initially tried compression ratio at employee level
  * *Status:* Improving but needs vigilance

### Recent Progress

*What's been improving lately?*

* **Pattern:** Using shift() within groups

  * *Progress:* Successfully used for consecutive hire detection.
  * *Confidence:* Strong

* **Pattern:** Recognizing when to calculate at dept vs employee level

  * *Progress:* Fixed compression ratio calculation after initial confusion.
  * *Confidence:* Growing

### Reinforcement Needed
*What do I understand but need more practice with?*

* [ ] **Pattern:** Multi-level hierarchical queries (manager of managers)

  * *Understanding:* Conceptual understanding good
  * *Practice needed:* Heavy - need iterative approach

* [ ] **Pattern:** Creating and interpreting distance/similarity matrices

  * *Understanding:* Medium
  * *Practice needed:* Medium

### Next Session Goals
*What do I want to focus on next time?*

1. **Primary goal:** Complete exercises 73-75 (manager span, budget simulation, tenure fairness).
2. **Secondary goal:** Practice recursive/iterative hierarchy traversal.
3. **Skill to reinforce:** Choosing correct aggregation level from the start.

## SESSION REFLECTION (Overwrites Each Session)

**What frustrated me today?**
Initially calculating compression ratio at employee level when it should be department level. Realizing I needed to think about aggregation level before diving into code.

**What felt easy/natural?**
Using shift() to compare consecutive rows within groups. Detecting patterns that need group-wise operations vs global operations.

**What pattern am I starting to see?**
Always ask "what level should this metric exist at?" before starting calculations. Department metrics shouldn't vary by employee.

**What should I drill more?**
Hierarchical data structures and recursive-style operations in pandas. Clean approaches to multi-level reporting relationships.

**Energy level: High**
**Confidence level: Medium-Strong**

---

## Usage Instructions
* **Persistent sections**: Add new items, never delete
* **Rolling sections**: Update/modify as your focus shifts
* **Session reflection**: Completely overwrite each session
* **Promote items**: Move resolved struggles to "Conquered Struggles", breakthrough moments to "Historical Breakthroughs"