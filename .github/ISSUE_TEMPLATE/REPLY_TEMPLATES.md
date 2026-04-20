# 📋 Review Comment Templates

Copy the relevant template below into a GitHub issue comment.

---

## 🔍 REVIEWER — Round N Review Comment

> Set label to `rework-required` or `approved` after posting.

```
## 🔍 Round N Review — [Reviewer Name] — [YYYY-MM-DD] — Doc v[X.X]

name: Review Automation

on:
  issues:
    types: [labeled]

permissions:
  issues: write

jobs:
  auto-review-comment:
    if: github.event.label.name == 'in-review'
    runs-on: ubuntu-latest

    steps:
      - name: Add Review Comment
        uses: actions/github-script@v7
        with:
          script: |
            const issue_number = context.issue.number;

            // Get existing comments
            const comments = await github.rest.issues.listComments({
              ...context.repo,
              issue_number
            });

            // Calculate round number
            let round = 1;
            for (const c of comments.data) {
              if (c.body && c.body.includes("Round")) {
                round++;
              }
            }

            // Get today's date
            const today = new Date().toISOString().split('T')[0];

            // Generic reusable template
            const body =
            "## 🔍 Round " + round + " Review — [Reviewer Name] — " + today + "\n\n" +

            "### 📝 Feedback\n" +
            "- ID-1 — [Finding] — Open\n" +
            "- ID-2 — [Finding] — Accepted\n" +
            "- ID-3 — [Finding] — Rejected\n\n" +

            "👉 Add more like:\n" +
            "- ID-X — Finding — Open/Accepted/Rejected\n\n" +

            "### 🏁 Decision\n" +
            "- [ ] ✅ Approved\n" +
            "- [ ] 🔴 Changes Requested";

            // Post comment
            await github.rest.issues.createComment({
              ...context.repo,
              issue_number,
              body
            });
---

## 🔧 AUTHOR — Rework Complete + Findings Response

> Set label to `re-review-requested` and re-assign to Reviewer after posting.

```
## 🔧 Rework Complete — Round N Response — [Author Name] — [YYYY-MM-DD] — Doc v[X.X]

| Finding | Decision | Action Taken |
|---------|----------|-------------|
| ID.X — [finding] | ✅ Accepted | [what was done] |
| ID.X — [finding] | ✅ Accepted | [what was done] |
| ID.X — [finding] | ❌ Not Accepted | [rationale] |

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
