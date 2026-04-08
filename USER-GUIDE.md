# PR Report Card Dashboard - User Guide

(c) 2026 Qorix. All rights reserved.

## 📚 Table of Contents

1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [Dashboard Overview](#dashboard-overview)
4. [Adding PR Reviews](#adding-pr-reviews)
5. [Viewing and Filtering PRs](#viewing-and-filtering-prs)
6. [Understanding Guidelines](#understanding-guidelines)
7. [Statistics and Analytics](#statistics-and-analytics)
8. [Exporting Data](#exporting-data)
9. [Best Practices](#best-practices)
10. [FAQ](#faq)
11. [Troubleshooting](#troubleshooting)

---

## Introduction

### What is the PR Report Card Dashboard?

The PR Report Card Dashboard is a comprehensive tool designed to help development teams track and improve Pull Request (PR) quality through systematic evaluation and scoring. It provides a standardized approach to PR reviews based on industry best practices and team-specific guidelines.

### Key Benefits

- **Consistency** - Standardized evaluation across all PRs
- **Visibility** - Clear metrics on code review quality
- **Improvement** - Identify patterns and areas for growth
- **Documentation** - Historical record of PR quality
- **Efficiency** - Streamlined review process

### Who Should Use This Tool?

- **Developers** - Self-review before submitting PRs
- **Code Reviewers** - Systematic PR evaluation
- **Team Leads** - Track team performance
- **Project Managers** - Quality metrics and reporting
- **DevOps Engineers** - Integrate with CI/CD pipelines

---

## Getting Started

### Step 1: Open the Dashboard

1. Navigate to the `PR_ReportCard` folder
2. Double-click `index.html`
3. Dashboard opens in your default web browser

**System Requirements:**
- Modern web browser (Chrome, Firefox, Safari, Edge)
- JavaScript enabled
- LocalStorage enabled (not in private/incognito mode)

### Step 2: Understanding the Interface

The dashboard has 7 main tabs:

1. **Dashboard** - Overview and recent PRs
2. **PR List** - All reviewed PRs with filtering
3. **Add PR Review** - Form to record new reviews
4. **Guidelines** - Evaluation criteria reference
5. **Statistics** - Team performance metrics
6. **GitHub Setup** - Integration instructions
7. **Export** - Data backup and reporting

### Step 3: First PR Review

Let's walk through adding your first PR review:

1. Click the **"Add PR Review"** tab
2. Fill in basic PR information
3. Complete the guideline checklist
4. Add any comments
5. Click **"Save PR Review"**

---

## Dashboard Overview

### Main Statistics Cards

The dashboard displays four key metrics:

**Total PRs Reviewed**
- Count of all PR reviews recorded
- Updates automatically as you add reviews

**Average Score**
- Mean score across all PRs
- Indicates overall team quality
- Range: 0-100

**Excellent PRs (90+)**
- Count of PRs scoring 90 or above
- Benchmark for quality standards
- Goal: Maximize this number

**Guideline Compliance**
- Percentage of PRs rated "Excellent"
- Key performance indicator (KPI)
- Target: 80%+ compliance

### Recent PR Reviews

Shows the 5 most recently added PR reviews with:
- PR number and title
- Author and repository
- Status badge (Open/Merged/Closed/Draft)
- Lines changed
- Overall score with color coding

### Score Color Coding

- **Green (90-100)** - Excellent
- **Blue (75-89)** - Good
- **Orange (60-74)** - Fair
- **Red (0-59)** - Needs Improvement

---

## Adding PR Reviews

### Required Information

When adding a PR review, you must provide:

**PR Number** *
- The numeric identifier (e.g., 123 for #123)
- Found in PR URL or title

**PR Title** *
- Full title of the pull request
- Copy directly from GitHub

**Author** *
- GitHub username who created the PR
- Case-sensitive

**Repository** *
- Format: `organization/repository-name`
- Example: `qorix/dashboard-project`

### Optional Information

**Status**
- Open: PR still under review
- Merged: PR has been merged
- Closed: PR closed without merging
- Draft: Work in progress PR

**Lines Changed**
- Total additions + deletions
- Available in GitHub PR "Files changed" tab

**Created Date**
- When PR was opened
- Defaults to today

**Review Completed Date**
- When you finished the review
- Defaults to today

**PR URL**
- Full GitHub URL to the PR
- Makes PR clickable in dashboard

### Guideline Checklist

The checklist contains 20 evaluation criteria organized by category:

**How to Use:**
1. Review each guideline
2. Check if the PR meets the criteria
3. Leave unchecked if criteria not met
4. Score automatically calculates

**Categories:**
- Documentation (5 items)
- Quality (5 items)
- Process (7 items)
- Security (2 items)
- Best Practices (1 item)

### Adding Comments

Use the comments field to:
- Note specific issues found
- Explain why certain criteria weren't met
- Highlight exceptional work
- Record reviewer observations
- Document follow-up items

**Example Comments:**
```
Missing unit tests for new service layer.
Excellent documentation and clear commit messages.
Breaking change properly documented in migration guide.
Consider splitting into smaller PRs in future.
```

### Saving the Review

1. Review all entered information
2. Verify checklist accuracy
3. Click **"Save PR Review"**
4. Confirmation message shows score
5. Review appears in dashboard

### Resetting the Form

Click **"Reset Form"** to:
- Clear all input fields
- Uncheck all checklist items
- Start fresh for next review

⚠️ **Warning:** Only reset after saving, as unsaved data will be lost.

---

## Viewing and Filtering PRs

### PR List Tab

View all recorded PR reviews in reverse chronological order (newest first).

### Filtering Options

**By Status**
- Select from dropdown: All, Open, Merged, Closed, Draft
- Useful for focusing on specific PR states

**By Author**
- Dropdown populated with all authors
- Track individual developer quality
- Compare team members

**By Search Text**
- Type keywords from PR title
- Real-time filtering
- Case-insensitive

### Applying Filters

1. Select desired filters
2. Click **"Apply Filters"**
3. Results update immediately
4. Clear filters to see all PRs

### PR Card Information

Each PR card displays:
- PR number and title (clickable link)
- Overall score with rating
- Author name
- Repository
- Status badge
- Lines changed
- Comments (if any)

---

## Understanding Guidelines

### The 20-Point Checklist

Each guideline is worth 5 points (100% / 20 items = 5 points each).

### Documentation Guidelines

1. **PR template is completely filled out**
   - All template sections have content
   - No "TODO" or placeholder text

2. **Linked to issue/ticket**
   - References Jira, GitHub Issue, or ticket system
   - Uses proper linking syntax

3. **Description clearly explains WHAT changed**
   - Lists all modifications made
   - Technical details included

4. **Description clearly explains WHY it changed**
   - Business justification
   - Problem being solved

5. **Documentation updated**
   - README, wiki, or inline docs
   - API documentation if applicable

6. **Screenshots/demos for UI changes**
   - Before/after images
   - Video demonstrations for complex UX

### Quality Guidelines

7. **Tests added or updated**
   - Unit tests for new functions
   - Integration tests for features
   - E2E tests for workflows

8. **All existing tests pass**
   - CI/CD pipeline green
   - No broken tests
   - No flaky tests introduced

9. **Code coverage maintained or improved**
   - Coverage not decreased
   - New code has tests
   - Coverage reports reviewed

10. **Code follows project style guide**
    - Linting passes
    - Formatting consistent
    - Naming conventions followed

11. **Performance implications considered**
    - No performance regressions
    - Optimization opportunities noted
    - Load/stress testing if needed

### Process Guidelines

12. **Self-review completed**
    - Author reviewed own code
    - Obvious issues fixed
    - Ready for peer review

13. **No merge conflicts**
    - Clean merge with target branch
    - Rebased if necessary
    - Conflicts resolved properly

14. **CI/CD checks all passing**
    - Build succeeds
    - All automated tests pass
    - Quality gates met

15. **Required approvals obtained**
    - Minimum reviewers approved
    - No "Request Changes" outstanding
    - All comments addressed

16. **Branch naming follows convention**
    - Pattern: `feature/`, `bugfix/`, `hotfix/`
    - Descriptive branch name
    - Includes ticket number if applicable

17. **Commit messages clear and descriptive**
    - Follows team conventions
    - Explains what and why
    - Proper grammar and formatting

18. **Linked to issue/ticket**
    - References related work items
    - Proper linking syntax
    - Traceable requirements

### Security Guidelines

19. **No sensitive data or credentials exposed**
    - No hardcoded passwords
    - No API keys in code
    - No PII in logs
    - Secrets properly managed

### Best Practice Guidelines

20. **PR size is reasonable (< 500 lines)**
    - Focused scope
    - Easier to review
    - Lower error rate

---

## Statistics and Analytics

### Team Performance Table

Shows statistics per author:

**Columns:**
- **Author** - Developer username
- **Total PRs** - Number of PRs reviewed
- **Avg Score** - Mean score for all PRs
- **Excellent Count** - PRs scoring 90+
- **Compliance Rate** - Percentage of excellent PRs

### Common Issues Analysis

Identifies the most frequently failed checklist items:

- Lists top 10 issues
- Shows occurrence count
- Helps identify training needs
- Guides process improvements

### Using Statistics

**For Team Leads:**
- Identify struggling developers
- Recognize high performers
- Plan training sessions
- Set improvement goals

**For Individuals:**
- Track personal progress
- Compare to team average
- Identify improvement areas
- Set personal targets

---

## Exporting Data

### Export Options

#### 1. Export JSON

**Use Case:** Complete backup, data migration

**What's Included:**
- All PR reviews
- Complete checklist data
- All metadata and comments

**How To:**
1. Click "Export JSON"
2. File downloads automatically
3. Filename: `pr-reviews-YYYY-MM-DD.json`

**Restore:**
1. Go to Export tab
2. Use "Import from JSON Backup"
3. Select saved JSON file

#### 2. Export CSV

**Use Case:** Spreadsheet analysis, sharing with stakeholders

**What's Included:**
- PR metadata (number, title, author, etc.)
- Score
- Dates
- Comments

**Not Included:**
- Individual checklist items

**How To:**
1. Click "Export CSV"
2. File downloads automatically
3. Open in Excel, Google Sheets, etc.

#### 3. Print Report

**Use Case:** Meeting handouts, documentation

**What's Included:**
- All dashboard data
- Statistics
- Recent PRs
- Guidelines reference

**How To:**
1. Click "Print Report"
2. Print dialog opens
3. Configure printer settings
4. Print or Save as PDF

#### 4. Copy to Clipboard

**Use Case:** Quick sharing in Slack, email

**What's Included:**
- Summary statistics
- Generation timestamp

**How To:**
1. Click "Copy to Clipboard"
2. Paste in desired application

**Example Output:**
```
PR Report Card Summary
================
Total PRs Reviewed: 45
Average Score: 82/100
Excellent PRs (90+): 28
Compliance Rate: 62%
Generated: 4/8/2026, 3:30:00 PM
```

### Import Data

**Import from JSON Backup:**
1. Go to Export tab
2. Click "Choose File" under Import
3. Select previously exported JSON
4. Data merges with existing reviews

⚠️ **Note:** Duplicate PRs (same ID) will be skipped

### Clear All Data

**Use With Caution:**
- Deletes all PR reviews
- Cannot be undone
- Confirmation required

**When to Use:**
- Starting fresh for new project
- Testing the dashboard
- Removing test data

---

## Best Practices

### For Developers (Self-Review)

**Before Creating PR:**
1. Review the 20-point checklist
2. Ensure all applicable items are met
3. Complete PR template thoroughly
4. Link to relevant issues

**After Creating PR:**
1. Perform self-review using dashboard
2. Address any items marked as not met
3. Update PR before requesting reviews

**Goal:** Submit PRs scoring 85+ on first submission

### For Reviewers

**During Review:**
1. Use checklist as review guide
2. Note specific issues in comments
3. Be objective and consistent
4. Provide constructive feedback

**Scoring Tips:**
- Don't inflate scores
- Be fair and consistent
- Consider context
- Document exceptions

**Communication:**
- Explain low scores
- Highlight excellent work
- Suggest specific improvements

### For Team Leads

**Weekly Reviews:**
1. Check dashboard statistics
2. Identify trends
3. Address common issues
4. Recognize top performers

**Monthly Analysis:**
1. Export data for reporting
2. Compare to previous months
3. Set new goals
4. Plan improvements

**Continuous Improvement:**
1. Update guidelines as needed
2. Share best practices
3. Provide training
4. Celebrate successes

### Setting Goals

**Team Goals:**
- Average score > 75
- Compliance rate > 70%
- Common issues decreasing

**Individual Goals:**
- Personal average > 80
- Excellent PRs > 60%
- Zero security violations

---

## FAQ

### General Questions

**Q: Do I need to install anything?**
A: No, just open `index.html` in a web browser.

**Q: Does this work offline?**
A: Yes, after initial load it works completely offline.

**Q: Where is my data stored?**
A: Locally in your browser's localStorage. No server involved.

**Q: Can I access my data on different computers?**
A: No, unless you export and import. Data is per-browser.

**Q: Is there a mobile version?**
A: The interface is responsive but optimized for desktop use.

### Data Questions

**Q: How many PRs can I store?**
A: Typically thousands, limited only by browser storage (5-10MB).

**Q: Can I edit a saved PR review?**
A: Currently no. Export, edit JSON, and re-import.

**Q: Can I delete individual PRs?**
A: Currently no. You can clear all data or manually edit JSON.

**Q: How do I backup my data?**
A: Use Export JSON regularly and save files securely.

### Scoring Questions

**Q: How is the score calculated?**
A: Each checklist item = 5 points. Total checked items × 5 = score.

**Q: Can I customize the checklist?**
A: Not in the UI. You can modify the code in `index.html`.

**Q: What's a good score?**
A: 90+ is excellent, 75-89 is good, 60-74 is fair.

**Q: Should all 20 items always apply?**
A: No. Some items may not be relevant (e.g., UI changes). Use judgment.

### Integration Questions

**Q: Can this pull data from GitHub automatically?**
A: Not directly. See GitHub Setup Guide for integration options.

**Q: Can I integrate with Jira?**
A: Manually by linking Jira tickets in PR descriptions.

**Q: Can multiple people share one dashboard?**
A: No, data is local. Use export/import to share or set up a shared location.

---

## Troubleshooting

### Data Not Saving

**Symptoms:**
- Added PR reviews don't appear after refresh
- Dashboard shows 0 PRs after adding reviews

**Solutions:**
1. Check if in private/incognito mode (localStorage disabled)
2. Verify JavaScript is enabled
3. Check browser console for errors (F12)
4. Try different browser
5. Clear browser cache and try again

### Filters Not Working

**Symptoms:**
- Filters don't update results
- Search doesn't find PRs

**Solutions:**
1. Clear all filters and reapply
2. Check for typos in search
3. Refresh the page
4. Try different browser

### Export Failures

**Symptoms:**
- Export buttons don't download files
- Files are empty or corrupted

**Solutions:**
1. Check browser's download settings
2. Allow pop-ups for the page
3. Try different export format
4. Check available disk space
5. Try different browser

### Display Issues

**Symptoms:**
- Layout broken or overlapping
- Missing buttons or tabs
- Text not readable

**Solutions:**
1. Refresh the page (Ctrl+F5)
2. Clear browser cache
3. Try different browser
4. Check zoom level (should be 100%)
5. Update browser to latest version

### Performance Issues

**Symptoms:**
- Slow loading
- Browser freezing
- Laggy interface

**Solutions:**
1. Too many PRs stored - export old data and clear
2. Close other browser tabs
3. Restart browser
4. Check computer resources

### Getting Help

If problems persist:

1. **Check Browser Console:**
   - Press F12
   - Look for errors in Console tab
   - Take screenshot

2. **Gather Information:**
   - Browser name and version
   - Operating system
   - Steps to reproduce issue
   - Error messages

3. **Contact Support:**
   - Share gathered information
   - Provide exported data if relevant
   - Describe expected vs actual behavior

---

## Appendix

### Keyboard Shortcuts

- **Ctrl+F / Cmd+F** - Search in page
- **Ctrl+P / Cmd+P** - Print (when on Export tab)
- **F5** - Refresh page
- **Ctrl+Shift+Delete** - Clear browser data

### Browser Compatibility

| Browser | Version | Status |
|---------|---------|--------|
| Chrome | 90+ | ✅ Fully Supported |
| Firefox | 88+ | ✅ Fully Supported |
| Safari | 14+ | ✅ Fully Supported |
| Edge | 90+ | ✅ Fully Supported |
| Opera | 76+ | ✅ Fully Supported |
| IE11 | All | ❌ Not Supported |

### File Locations

```
PR_ReportCard/
├── index.html              # Main dashboard file
├── README.md              # Overview and quick start
├── GITHUB-SETUP-GUIDE.md  # Integration guide
└── USER-GUIDE.md          # This file
```

### Version Information

- **Current Version:** 1.0
- **Release Date:** April 2026
- **Author:** Qorix
- **License:** (c) 2026 Qorix. All rights reserved.

---

**Need more help?** Refer to the [README.md](README.md) or [GITHUB-SETUP-GUIDE.md](GITHUB-SETUP-GUIDE.md) for additional information.

**Happy Reviewing! 🎯**
