# GitHub Actions Setup Guide

(c) 2026 Qorix. All rights reserved.

## 🎯 Overview

This guide shows you how to set up GitHub Actions to automatically collect PR data for the PR Report Card Dashboard.

## 📋 What Gets Automated

✅ **Automatic PR Data Collection** - Every time a PR is created, updated, or closed  
✅ **Bulk PR Sync** - Fetch all historical PRs on demand or schedule  
✅ **Quality Checks** - Automated preliminary quality scoring  
✅ **Downloadable Artifacts** - Easy import into dashboard  

## 🚀 Quick Setup (5 Minutes)

### Step 1: Copy Workflow Files to Your Repository

1. **Navigate to your GitHub repository folder:**
   ```powershell
   cd "C:\path\to\your\github\repository"
   ```

2. **Create workflows directory:**
   ```powershell
   mkdir -p .github\workflows
   ```

3. **Copy the workflow files:**
   ```powershell
   # From PR_ReportCard folder
   copy "c:\Users\barshas\Downloads\Connector Zoho_Jira\jira_dashboard\PR_ReportCard\.github\workflows\*" .github\workflows\
   ```

   Or manually copy these 3 files:
   - `collect-pr-data.yml` - Auto-collects data on PR events
   - `sync-all-prs.yml` - Syncs all historical PRs
   - `pr-quality-check.yml` - Runs quality checks

### Step 2: Commit and Push

```powershell
git add .github\workflows\
git commit -m "Add PR Report Card automation workflows"
git push origin main
```

### Step 3: Verify Installation

1. Go to your GitHub repository
2. Click **Actions** tab
3. You should see three new workflows:
   - ✅ Collect PR Data for Dashboard
   - ✅ Sync All PRs to Dashboard
   - ✅ PR Quality Check

**✅ Setup Complete!**

---

## 📊 How to Use

### Automatic Collection (Runs Automatically)

**Triggers:**
- When a PR is opened
- When a PR is edited
- When a PR is closed/merged
- When a PR is updated

**What Happens:**
1. Workflow runs automatically
2. Collects PR data (number, title, author, lines changed, etc.)
3. Creates downloadable artifact
4. Posts comment on the PR

**To Access Data:**
1. Go to **Actions** tab → Click on the workflow run
2. Scroll to **Artifacts** section
3. Download `pr-data-all` or `pr-{number}-data`
4. Extract the JSON file

### Manual Full Sync (Run on Demand)

**Use Case:** Import all historical PRs at once

**Steps:**
1. Go to **Actions** tab
2. Select **"Sync All PRs to Dashboard"** workflow
3. Click **"Run workflow"** → **"Run workflow"**
4. Wait for completion (may take a few minutes for many PRs)
5. Download the `pr-data-complete` artifact
6. Extract and import into dashboard

### Scheduled Sync (Weekly)

The sync workflow also runs **automatically every Sunday at midnight** to keep data fresh.

You can customize the schedule in `sync-all-prs.yml`:
```yaml
schedule:
  - cron: '0 0 * * 0'  # Sunday at midnight
  # Change to '0 0 * * *' for daily
  # Change to '0 0 1 * *' for monthly
```

---

## 📥 Importing Data into Dashboard

### Method 1: Import from Downloaded Artifact

1. **Download artifact from GitHub Actions:**
   - Go to Actions → Select workflow run
   - Download artifact (ZIP file)
   - Extract the JSON file

2. **Import into dashboard:**
   - Open `PR_ReportCard/index.html`
   - Go to **Export** tab
   - Click **"Choose File"** under "Import from JSON Backup"
   - Select the extracted JSON file
   - Data will be imported!

### Method 2: Auto-Sync (Advanced)

For automatic synchronization, you can set up a local server that fetches artifacts automatically.

---

## 🔧 Workflow Configuration

### Collect PR Data Workflow

**File:** `.github/workflows/collect-pr-data.yml`

**Configuration Options:**

```yaml
# Line 34: Enable/disable automatic commits
if: false  # Set to true to commit data to repository
```

**What it collects:**
- PR number, title, author
- Repository name
- Status (open, merged, closed, draft)
- Lines changed (additions + deletions)
- Created and reviewed dates
- PR URL
- Additional GitHub metadata (commits, files changed, labels)

### Sync All PRs Workflow

**File:** `.github/workflows/sync-all-prs.yml`

**Configuration Options:**

```yaml
# Line 10-11: Schedule configuration
schedule:
  - cron: '0 0 * * 0'  # Weekly - customize as needed
```

**Fetches:**
- All PRs from the repository (open, closed, merged)
- Up to 100 PRs per page (handles pagination)
- Complete historical data

### PR Quality Check Workflow

**File:** `.github/workflows/pr-quality-check.yml`

**What it checks:**
- PR template completion
- Issue/ticket linking
- PR size (<500 lines)
- Branch naming conventions
- Merge conflicts
- Commit message quality
- Breaking changes documentation

**Outputs:**
- Automated score (0-100)
- Comment on PR with results
- GitHub status check

---

## 🎯 Workflow Permissions

The workflows require these permissions (already configured):

```yaml
permissions:
  contents: write      # To commit data (if enabled)
  pull-requests: read  # To read PR information
```

If you get permission errors, check your repository settings:
1. Go to **Settings** → **Actions** → **General**
2. Under "Workflow permissions"
3. Select "Read and write permissions"
4. Save

---

## 📊 Understanding the Data Structure

**Data collected for each PR:**

```json
{
  "id": 12345678,
  "number": 123,
  "title": "Add new feature",
  "author": "username",
  "repo": "org/repo-name",
  "status": "merged",
  "linesChanged": 450,
  "createdDate": "2026-04-01",
  "reviewedDate": "2026-04-08",
  "url": "https://github.com/org/repo/pull/123",
  "checklist": {},
  "score": 0,
  "comments": "Auto-collected from GitHub",
  "timestamp": "2026-04-08T10:30:00Z",
  "autoCollected": true,
  "githubData": {
    "additions": 300,
    "deletions": 150,
    "changedFiles": 8,
    "commits": 5,
    "reviewComments": 3,
    "labels": ["enhancement", "backend"]
  }
}
```

**Note:** `checklist` and `score` start empty - you complete these in the dashboard.

---

## 🔄 Complete Workflow

```
┌─────────────────────────────────────────────────────────┐
│  1. PR Created/Updated in GitHub                       │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  2. GitHub Action Triggers Automatically                │
│     - Collect PR Data workflow runs                     │
│     - Quality Check workflow runs                       │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  3. Data Collected and Stored                           │
│     - Creates downloadable artifact                     │
│     - Posts comment on PR with preliminary score        │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  4. Developer Downloads Artifact                        │
│     - Goes to Actions tab → Workflow run                │
│     - Downloads JSON file                               │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  5. Imports into PR Report Card Dashboard               │
│     - Opens dashboard                                   │
│     - Imports JSON file                                 │
│     - Completes quality checklist                       │
└─────────────────────────────────────────────────────────┘
```

---

## 🛠️ Troubleshooting

### Workflow Not Running

**Problem:** Workflow doesn't trigger on PR events

**Solutions:**
1. Check workflows are in correct location: `.github/workflows/`
2. Verify YAML syntax is valid (use GitHub's editor)
3. Check repository Actions are enabled (Settings → Actions)
4. Ensure you have admin/write access to repository

### Permission Errors

**Problem:** `Resource not accessible by integration`

**Solutions:**
1. Go to Settings → Actions → General
2. Enable "Read and write permissions"
3. Re-run the workflow

### Artifact Not Found

**Problem:** Can't find downloaded artifact

**Solutions:**
1. Check workflow completed successfully (green checkmark)
2. Look in **Artifacts** section at bottom of workflow run page
3. Artifacts expire after retention period (30-365 days)
4. Re-run the workflow if needed

### Data Not Importing

**Problem:** JSON import fails or shows errors

**Solutions:**
1. Verify JSON file is valid (open in text editor)
2. Check file isn't corrupted during download
3. Re-download from GitHub Actions
4. Try importing smaller dataset first

---

## 📈 Advanced Usage

### Custom Data Collection

Edit `collect-pr-data.yml` to add custom fields:

```yaml
# Add after line 30
custom_field: pr.custom_value,
team: pr.labels.find(l => l.name.startsWith('team-'))?.name,
priority: pr.labels.find(l => l.name.startsWith('priority-'))?.name,
```

### Integration with Other Tools

The collected JSON can be:
- Imported into spreadsheets
- Used by other automation tools
- Processed by custom scripts
- Stored in databases
- Sent to analytics platforms

### Multiple Repositories

To track PRs across multiple repositories:
1. Install workflows in each repository
2. Download artifacts from each
3. Merge JSON files before importing
4. Or maintain separate dashboard instances

---

## 🔐 Security Notes

✅ **Safe Practices:**
- Workflows run in isolated GitHub Actions environment
- No credentials stored in workflows
- Uses GitHub's built-in authentication
- Artifacts are repository-scoped

⚠️ **Be Careful:**
- Don't commit sensitive data in PR descriptions
- Review artifacts before sharing externally
- Control who has access to workflow artifacts

---

## 📚 Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [github-script Action](https://github.com/actions/github-script)
- [PR Report Card User Guide](USER-GUIDE.md)

---

## ✅ Quick Checklist

- [ ] Copied workflow files to `.github/workflows/`
- [ ] Committed and pushed to repository
- [ ] Verified workflows appear in Actions tab
- [ ] Tested with a new PR
- [ ] Downloaded and imported artifact successfully
- [ ] Completed quality checklist for imported PRs
- [ ] Set up scheduled sync (if desired)
- [ ] Trained team on using the system

---

**Need Help?** See [USER-GUIDE.md](USER-GUIDE.md) or contact your team administrator.

**Happy Automating! 🚀**
