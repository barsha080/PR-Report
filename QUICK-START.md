# PR Report Card Dashboard - Quick Start Guide

(c) 2026 Qorix. All rights reserved.

## ⚡ 5-Minute Setup

### Step 1: Open the Dashboard (30 seconds)
1. Navigate to `PR_ReportCard` folder
2. Double-click `index.html`
3. Dashboard opens in your browser

### Step 2: Add Your First PR Review (2 minutes)
1. Click **"Add PR Review"** tab
2. Fill in the form:
   - PR Number: `123`
   - PR Title: `Add user authentication`
   - Author: `john.doe`
   - Repository: `myorg/myproject`
   - Status: `Merged`
3. Check applicable guideline items (e.g., tests added, docs updated, etc.)
4. Click **"Save PR Review"**
5. See your score!

### Step 3: Explore the Dashboard (2 minutes)
1. **Dashboard tab** - See overview statistics
2. **PR List tab** - View all reviews
3. **Statistics tab** - Team performance metrics
4. **Export tab** - Download your data

### Step 4: (Optional) Export Your First Report (30 seconds)
1. Go to **Export** tab
2. Click **"Export CSV"** or **"Copy to Clipboard"**
3. Share with your team!

**✅ You're ready to track PR quality!**

---

## 📖 Common Tasks

### How to Review a PR
1. Open the PR on GitHub
2. Review the code changes
3. Open PR Report Card Dashboard → "Add PR Review"
4. Fill in PR details
5. Check each guideline:
   - ✅ Met = Check the box
   - ❌ Not met = Leave unchecked
6. Add comments explaining any unchecked items
7. Save review

### How to Filter PRs
1. Go to **PR List** tab
2. Use filter dropdowns:
   - **Status**: Open, Merged, Closed, Draft
   - **Author**: Select team member
   - **Search**: Type keywords
3. Click **Apply Filters**

### How to See Team Performance
1. Go to **Statistics** tab
2. View **Team Performance** table
3. Check **Common Issues** section
4. Export data for meetings

### How to Backup Your Data
1. Go to **Export** tab
2. Click **"Export JSON"**
3. Save file in a secure location
4. To restore: Use **"Import from JSON Backup"**

---

## 🎯 The 20-Point Checklist (Quick Reference)

### Documentation (5 items)
- [ ] PR template filled completely
- [ ] Linked to issue/ticket
- [ ] Explains WHAT changed
- [ ] Explains WHY it changed
- [ ] Screenshots for UI changes

### Quality (5 items)
- [ ] Tests added/updated
- [ ] All tests passing
- [ ] Code coverage maintained
- [ ] Follows style guide
- [ ] Performance considered

### Process (7 items)
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Breaking changes noted
- [ ] No merge conflicts
- [ ] CI/CD checks passing
- [ ] Branch naming correct
- [ ] Commit messages clear

### Security (2 items)
- [ ] No exposed credentials
- [ ] Required approvals obtained

### Best Practices (1 item)
- [ ] PR size reasonable (<500 lines)

**Score = (Checked items / 20) × 100**

---

## 📊 Understanding Scores

| Score | Rating | Meaning |
|-------|--------|---------|
| 90-100 | 🌟 Excellent | Perfect PR! |
| 75-89 | ✅ Good | Minor improvements needed |
| 60-74 | ⚠️ Fair | Several items to improve |
| 0-59 | ❌ Poor | Significant work needed |

**Team Goal:** 70%+ PRs scoring 90+

---

## 🔗 GitHub Integration (Optional)

### Option 1: Manual (Easiest)
- Review PRs on GitHub
- Record scores in dashboard manually
- No setup required

### Option 2: Automated Script
- Use included `fetch_github_prs.py` script
- Requires: Python, GitHub token
- See `GITHUB-SETUP-GUIDE.md` for details

### Option 3: GitHub Actions
- Use `.github-workflows-pr-quality-check.yml` template
- Copy to `.github/workflows/` in your repo
- Automated PR quality checks on every PR

---

## 💡 Pro Tips

1. **Regular Reviews**: Record every PR review for accurate statistics
2. **Export Weekly**: Backup your data regularly
3. **Team Meetings**: Share statistics monthly
4. **Self-Review First**: Developers should self-assess before submitting
5. **Be Consistent**: Apply guidelines fairly across all PRs
6. **Add Context**: Use comments field to explain scores
7. **Track Trends**: Monitor improvement over time

---

## 🆘 Quick Troubleshooting

**Data not saving?**
- Not in private/incognito mode?
- JavaScript enabled?
- Try different browser

**Can't find my PRs?**
- Check filters are cleared
- Try search function
- Export JSON to verify data exists

**Export not working?**
- Allow pop-ups/downloads
- Try different export format
- Check browser download folder

---

## 📚 Need More Help?

- **Detailed Usage**: See [USER-GUIDE.md](USER-GUIDE.md)
- **GitHub Setup**: See [GITHUB-SETUP-GUIDE.md](GITHUB-SETUP-GUIDE.md)
- **Overview**: See [README.md](README.md)

---

## 🎉 Next Steps

1. ✅ Complete your first PR review
2. ✅ Add 5-10 PR reviews to populate dashboard
3. ✅ Export your first report
4. ✅ Share with your team
5. ✅ Set up GitHub integration (optional)
6. ✅ Establish team quality goals
7. ✅ Review statistics monthly

**Happy Reviewing! 📊**

---

*Questions? Contact your team lead or see the complete guides included with this dashboard.*
