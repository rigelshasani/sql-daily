## Data Quality Report — Toy Churn Dataset

**Findings:**  
- Age values are invalid: ~2.4% of ages are invalid and 242 missing.
- Many missing rows for many columns, in differing amounts
- Ranges are flatly spread, data is programatically generated, not business-realistic.
- 

**Actions (hypothetical):**  
- Drop invalid ages, decide imputation vs drop for missing tenures.

**Conclusion:**  
Purpose:
- This is toy data programatically generated to practice on cleaning a dataset.

Limitation:
- Data is unreliable.  
- Any culling fixes analysts could do here would not reliably fix the issues with the dataset. Even fixing ranges would not fix flat spread, and removing data would change how the churn would look like, since some data here has high tenure and it would cause issues with churn values, more specifically it would appear to increase/lower churn rates unrealistically because the data is unreliable.