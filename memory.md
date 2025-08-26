# Moving Memory - SQL/Pandas Learning

**Last Updated:** Aug 26, 2025
**Session #:** 74 (Data cleaning introduction & churn analysis concepts)

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

* **Aug 2025:**
  * *Concept:* CTEs as "temporary named subqueries."  
    *What made it click:* Seeing that a CTE is just a prep step (like defining a variable) and then used once in the next query.  
    *Impact:* Much less fear of CTE syntax, now confident in layering queries step-by-step.

* **Aug 2025:**
  * *Concept:* Window functions vs GROUP BY.  
    *What made it click:* Realizing GROUP BY collapses rows, while window functions *annotate* them.  
    *Impact:* Now check: “Do I need to collapse or keep detail?” before choosing approach.

* **Aug 2025:**
  * *Concept:* Memory profiling and dtype optimization.  
    *What made it click:* Seeing `hire_date` drop from ~2680B to 320B after conversion to datetime64 and `dept` shrink massively as category.  
    *Impact:* Confident in profiling and converting object-heavy columns to efficient types.

* **Aug 2025:**
  * *Concept:* Professional data skepticism and quality assessment.
    *What made it click:* Seeing impossible values (negative ages, 999-year-olds) and questioning entire dataset reliability.
    *Impact:* Now always assess data quality scope before diving into analysis. Ask "what percentage is problematic?"

---

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
* **New:** Need concept introduction before domain-specific exercises. Updated teaching prompt to require concept introduction protocol.

### Progress Milestones
*Major achievements and skill level ups*

* **Jul 2025:** SQL drills 1–150 complete.
* **Jul 2025:** Pandas Exercises P001–P035 complete.
* **Aug 2025:** Exercises P051–P060 (performance simulation with normalized scoring) complete.
* **Aug 2025:** Exercises 1-60 complete (skipped 47, 49 from 45-50 set).
* **Aug 2025:** Started advanced consolidation exercises 71-80.
* **Aug 2025:** SQL CTE drills 151–155 complete (CTEs, window functions).  
* **Aug 2025:** Profiling drill complete (memory savings ~43% after dtype conversions).  
* **Aug 2025:** **Data cleaning introduction:** Generated messy churn dataset, assessed data quality scope (2.44% invalid ages, 4.7% missing).

----------------------------------------------------------

## ROLLING MEMORY (Updates Each Session)

### Current Focus Areas
*What am I actively working on right now?*

* [ ] **Primary Topic:** Data cleaning workflows and churn analysis
* [ ] **Secondary Topic:** Missing vs invalid data handling strategies
* [ ] **Exercise Range:** Catch-up work (Monday's pandas cleaning + Tuesday's A/B test scaffold)

### Active Struggle Patterns
*What keeps tripping me up right now?*

#### New Learning Areas (Not Yet Struggles)

* [ ] **Concept:** Churn analysis business logic

  * *Status:* Just introduced - understanding what churn is and column categorization
  * *Next:* Need to practice identifying target variables and predictor importance

* [ ] **Concept:** Data cleaning decision frameworks

  * *Status:* Learning to distinguish missing vs invalid data problems
  * *Next:* Need to practice systematic cleaning approaches

#### Previous Struggles (Still Active)

* [ ] **Pattern:** Recursive hierarchy traversal in pandas

  * *Issue:* Need iterative/loop approach for multi-level reporting structures.
  * *Frequency:* Medium
  * *Last encountered:* Aug 26, 2025

### Recent Progress

*What's been improving lately?*

* **Pattern:** Professional data quality assessment

  * *Progress:* Successfully questioned dataset reliability when seeing impossible values.
  * *Confidence:* Growing - now naturally calculate percentage of problematic data

* **Pattern:** Systematic data exploration

  * *Progress:* Methodically assessed missing vs invalid data using pandas methods.
  * *Confidence:* Medium

### Reinforcement Needed
*What do I understand but need more practice with?*

* [ ] **Pattern:** Data cleaning strategy decisions

  * *Understanding:* Conceptual understanding of remove vs fix vs flag approaches
  * *Practice needed:* Heavy - need to practice systematic cleaning workflows

* [ ] **Pattern:** Business domain knowledge integration

  * *Understanding:* Basic concept of churn analysis introduced
  * *Practice needed:* Medium - need more practice applying business logic to technical decisions

### Next Session Goals
*What do I want to focus on next time?*

1. **Primary goal:** Complete systematic data cleaning workflow (handle invalid ages, missing values, duplicates).
2. **Secondary goal:** Complete A/B test project scaffold (hypothesis, metrics, synthetic data).
3. **Skill to reinforce:** Decision-making frameworks for data quality issues.

## SESSION REFLECTION (Overwrites Each Session)

**What frustrated me today?**
Initially being asked to categorize columns without understanding churn analysis concepts. Led to updating the teaching prompt to require proper concept introduction.

**What felt easy/natural?**
Questioning data reliability when seeing impossible values. The professional skepticism came naturally and led to good systematic analysis.

**What pattern am I starting to see?**
Always assess the scope of data quality problems (percentage affected) before deciding on cleaning strategy. Need to understand business context before making technical decisions.

**What should I drill more?**
Systematic data cleaning workflows. Need more practice with the full end-to-end process of identifying → assessing → deciding → implementing data quality fixes.

**Energy level: Medium-High**
**Confidence level: Medium**

---

## Usage Instructions
* **Persistent sections**: Add new items, never delete
* **Rolling sections**: Update/modify as your focus shifts
* **Session reflection**: Completely overwrite each session
* **Promote items**: Move resolved struggles to "Conquered Struggles", breakthrough moments to "Historical Breakthroughs"