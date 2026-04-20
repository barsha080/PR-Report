# 📋 Review Comment Templates

Copy the relevant template below into a GitHub issue comment.

---

## 🔍 REVIEWER — Round N Review Comment

> Set label to `rework-required` or `approved` after posting.

```
## 🔍 Round N Review — [Reviewer Name] — [YYYY-MM-DD] — Doc v[X.X]

| ID | Checkpoint | Status | Finding / Remark |
|----|-----------|--------|-----------------|
| SRS.1 | Document is as per template | ✅ OK | — |
| SRS.2 | Title page updated | ✅ OK | — |
| SRS.3 | Document change history maintained | ✅ OK | — |
| SRS.4 | Introduction section is clear | ✅ OK | — |
| SRS.5 | Abbreviations & definitions identified | ✅ OK | — |
| SRS.6 | Reference documents identified | ✅ OK | — |
| SRS.7 | Proper alignment maintained | ✅ OK | — |
| SRS.8 | Hyperlinks are correct | ✅ OK | — |
| SRS.9 | Font & size as per template | ✅ OK | — |
| SRS.10 | No spelling/grammar issues | ✅ OK | — |
| SRS.11 | Requirements are clear and unambiguous | ✅ OK | — |
| SRS.12 | No conflicting requirements | ✅ OK | — |
| SRS.13 | Requirements are testable | ✅ OK | — |
| SRS.14 | Acceptance criteria defined | ✅ OK | — |
| SRS.15 | Edge cases considered | ✅ OK | — |
| SRS.16 | All functional requirements captured | ✅ OK | — |
| SRS.17 | Non-functional requirements included | ✅ OK | — |
| SRS.18 | Dependencies identified | ✅ OK | — |
| SRS.19 | Assumptions documented | ✅ OK | — |
| SRS.20 | Requirements mapped to Feature / User Story | ✅ OK | — |
| SRS.21 | Traceability maintained | ✅ OK | — |
| SRS.22 | No orphan requirements | ✅ OK | — |

### 📌 Open Findings
- [ ] SRS.X — [describe finding]
- [ ] SRS.X — [describe finding]

### 🏁 Decision
- [ ] ✅ Approved — setting label to `approved`, closing issue
- [ ] 🔴 Changes Requested — setting label to `rework-required`, assigning back to Author
```

---

## 🔧 AUTHOR — Rework Complete + Findings Response

> Set label to `re-review-requested` and re-assign to Reviewer after posting.

```
## 🔧 Rework Complete — Round N Response — [Author Name] — [YYYY-MM-DD] — Doc v[X.X]

| Finding | Decision | Action Taken |
|---------|----------|-------------|
| SRS.X — [finding] | ✅ Accepted | [what was done] |
| SRS.X — [finding] | ✅ Accepted | [what was done] |
| SRS.X — [finding] | ❌ Not Accepted | [rationale] |

### 📄 Document Change Summary
- Version: v[old] → v[new]
- Changed sections: [list]
- Disputed findings: [explain if any]

### ➡️ Next Action
- Assigning back to [Reviewer Name] for Round [N+1]
- Label set to `re-review-requested`
```

---

## 🗂️ AUTHOR — Iteration Log (keep updated, post as comment each round)

```
## 🗂️ Review Iteration Log

| Round | Action | By | Date | Doc Version | Label |
|-------|--------|----|------|-------------|-------|
| R1 | Review Requested | [Author] | YYYY-MM-DD | v1.0 | `in-review` |
| R1 | Review Complete | [Reviewer] | YYYY-MM-DD | v1.0 | `rework-required` |
| R2 | Rework Complete | [Author] | YYYY-MM-DD | v1.1 | `re-review-requested` |
| R2 | Review Complete | [Reviewer] | YYYY-MM-DD | v1.1 | `approved` |
```

---

## ✅ REVIEWER — Final Approval Comment

> Set label to `approved` and close the issue.

```
## ✅ Final Approval — [Reviewer Name] — [YYYY-MM-DD] — Doc v[X.X]

All findings have been addressed satisfactorily.

| Metric | Value |
|--------|-------|
| Total Rounds | [N] |
| Total Findings Raised | [count] |
| Accepted | [count] |
| Not Accepted (with rationale) | [count] |
| Final Document Version | v[X.X] |

**Decision: ✅ APPROVED**

Setting label to `approved`. Closing issue.
```
