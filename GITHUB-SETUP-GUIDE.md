# GitHub Integration Setup Guide

(c) 2026 Qorix. All rights reserved.

## 📖 Overview

This guide explains how to integrate the PR Report Card Dashboard with GitHub to automate PR data collection and quality checking.

## 🎯 Integration Options

There are multiple ways to integrate this dashboard with GitHub:

1. **Manual Process** - Review PRs on GitHub, record scores manually
2. **GitHub API** - Fetch PR data programmatically
3. **GitHub Actions** - Automate PR quality checks
4. **Webhooks** - Real-time PR event processing
5. **Third-Party Tools** - Use existing PR review automation tools

---

## Option 1: Manual Review Process

### Setup Steps

1. **Review PR on GitHub**
   - Open the PR in your GitHub repository
   - Read through code changes
   - Check comments and reviews

2. **Record in Dashboard**
   - Open the PR Report Card Dashboard
   - Navigate to "Add PR Review" tab
   - Fill in PR details
   - Complete guideline checklist
   - Save review

3. **Track Over Time**
   - Use Dashboard tab for overview
   - Check Statistics for trends
   - Export reports as needed

### Pros & Cons

✅ **Pros:**
- No technical setup required
- Full control over evaluation
- Works immediately

❌ **Cons:**
- Manual data entry required
- Time-consuming for many PRs
- Potential for inconsistency

---

## Option 2: GitHub API Integration

### Prerequisites

- GitHub account with repository access
- Personal Access Token (PAT) or GitHub App
- Basic knowledge of REST APIs

### Step 1: Create GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Set token name: `PR-Report-Card-Access`
4. Select scopes:
   - `repo` - Full repository access
   - `read:org` - Read organization data
5. Click "Generate token"
6. **Copy and save the token securely**

### Step 2: Fetch PR Data

Use the GitHub REST API to retrieve PR information:

```bash
# Get all PRs for a repository
curl -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/OWNER/REPO/pulls?state=all&per_page=100

# Get specific PR details
curl -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/OWNER/REPO/pulls/123

# Get PR reviews
curl -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/OWNER/REPO/pulls/123/reviews

# Get PR files changed
curl -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/OWNER/REPO/pulls/123/files
```

### Step 3: Process API Response

Example API response structure:

```json
{
  "number": 123,
  "title": "Add new feature",
  "user": {
    "login": "username"
  },
  "state": "open",
  "created_at": "2026-04-01T10:00:00Z",
  "updated_at": "2026-04-08T15:30:00Z",
  "html_url": "https://github.com/org/repo/pull/123",
  "body": "PR description...",
  "additions": 150,
  "deletions": 50,
  "changed_files": 5
}
```

### Step 4: Create Import Script

Create a Python script to fetch and format PR data:

```python
#!/usr/bin/env python3
"""
GitHub PR Data Fetcher
(c) 2026 Qorix
"""

import requests
import json
from datetime import datetime

GITHUB_TOKEN = "your_token_here"
REPO_OWNER = "your_org"
REPO_NAME = "your_repo"

headers = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json"
}

def fetch_prs(state="all"):
    """
    Fetch pull requests from GitHub repository.
    
    Args:
        state: PR state filter (all, open, closed)
        
    Returns:
        List of PR data dictionaries
    """
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/pulls"
    params = {"state": state, "per_page": 100}
    
    response = requests.get(url, headers=headers, params=params)
    response.raise_for_status()
    
    return response.json()

def fetch_pr_files(pr_number):
    """
    Fetch files changed in a PR.
    
    Args:
        pr_number: Pull request number
        
    Returns:
        List of changed files
    """
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/pulls/{pr_number}/files"
    
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    
    return response.json()

def calculate_lines_changed(files):
    """
    Calculate total lines changed from file list.
    
    Args:
        files: List of file change objects
        
    Returns:
        Total lines changed (additions + deletions)
    """
    return sum(f.get('additions', 0) + f.get('deletions', 0) for f in files)

def export_for_dashboard(prs):
    """
    Format PR data for dashboard import.
    
    Args:
        prs: List of PR data from GitHub API
        
    Returns:
        Formatted data ready for dashboard import
    """
    formatted = []
    
    for pr in prs:
        files = fetch_pr_files(pr['number'])
        lines_changed = calculate_lines_changed(files)
        
        pr_data = {
            "id": pr['id'],
            "number": pr['number'],
            "title": pr['title'],
            "author": pr['user']['login'],
            "repo": f"{REPO_OWNER}/{REPO_NAME}",
            "status": pr['state'],
            "linesChanged": lines_changed,
            "createdDate": pr['created_at'][:10],
            "reviewedDate": pr['updated_at'][:10],
            "url": pr['html_url'],
            "checklist": {},  # To be filled manually
            "score": 0,  # To be calculated
            "comments": "",
            "timestamp": datetime.now().isoformat()
        }
        
        formatted.append(pr_data)
    
    return formatted

if __name__ == "__main__":
    print("Fetching PRs from GitHub...")
    prs = fetch_prs()
    
    print(f"Found {len(prs)} PRs")
    
    formatted_data = export_for_dashboard(prs)
    
    output_file = f"pr-data-{datetime.now().strftime('%Y%m%d')}.json"
    with open(output_file, 'w') as f:
        json.dump(formatted_data, f, indent=2)
    
    print(f"Data exported to {output_file}")
    print("Import this file in the Dashboard's Export tab")
```

### Step 5: Import to Dashboard

1. Run the Python script to generate JSON file
2. Open PR Report Card Dashboard
3. Go to Export tab
4. Use "Import from JSON Backup" to load data
5. Complete checklist evaluation for each PR

---

## Option 3: GitHub Actions Automation

### Create PR Quality Check Workflow

Create `.github/workflows/pr-quality-check.yml`:

```yaml
# PR Quality Check Workflow
# (c) 2026 Qorix

name: PR Quality Check

on:
  pull_request:
    types: [opened, edited, reopened, synchronize]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Check PR Template
        id: template-check
        run: |
          # Check if PR body is not empty
          if [ -z "${{ github.event.pull_request.body }}" ]; then
            echo "::error::PR description is empty"
            echo "template_filled=false" >> $GITHUB_OUTPUT
          else
            echo "template_filled=true" >> $GITHUB_OUTPUT
          fi
      
      - name: Check Issue Link
        id: issue-check
        run: |
          # Check if PR references an issue
          if echo "${{ github.event.pull_request.body }}" | grep -qE "#[0-9]+|https://"; then
            echo "issue_linked=true" >> $GITHUB_OUTPUT
          else
            echo "::warning::No issue reference found"
            echo "issue_linked=false" >> $GITHUB_OUTPUT
          fi
      
      - name: Check PR Size
        id: size-check
        run: |
          # Check if PR is reasonable size
          ADDITIONS=${{ github.event.pull_request.additions }}
          DELETIONS=${{ github.event.pull_request.deletions }}
          TOTAL=$((ADDITIONS + DELETIONS))
          
          if [ $TOTAL -gt 500 ]; then
            echo "::warning::PR is large ($TOTAL lines). Consider breaking it down."
            echo "size_ok=false" >> $GITHUB_OUTPUT
          else
            echo "size_ok=true" >> $GITHUB_OUTPUT
          fi
      
      - name: Check Branch Naming
        id: branch-check
        run: |
          BRANCH="${{ github.head_ref }}"
          
          # Check if branch follows convention (feature/, bugfix/, hotfix/, etc.)
          if echo "$BRANCH" | grep -qE "^(feature|bugfix|hotfix|refactor|docs)/"; then
            echo "branch_valid=true" >> $GITHUB_OUTPUT
          else
            echo "::warning::Branch name should follow convention: feature/, bugfix/, etc."
            echo "branch_valid=false" >> $GITHUB_OUTPUT
          fi
      
      - name: Calculate Score
        id: score
        run: |
          SCORE=0
          
          [ "${{ steps.template-check.outputs.template_filled }}" == "true" ] && SCORE=$((SCORE + 25))
          [ "${{ steps.issue-check.outputs.issue_linked }}" == "true" ] && SCORE=$((SCORE + 25))
          [ "${{ steps.size-check.outputs.size_ok }}" == "true" ] && SCORE=$((SCORE + 25))
          [ "${{ steps.branch-check.outputs.branch_valid }}" == "true" ] && SCORE=$((SCORE + 25))
          
          echo "score=$SCORE" >> $GITHUB_OUTPUT
          echo "PR Quality Score: $SCORE/100"
      
      - name: Comment on PR
        uses: actions/github-script@v6
        with:
          script: |
            const score = ${{ steps.score.outputs.score }};
            const emoji = score >= 90 ? '🌟' : score >= 75 ? '✅' : score >= 60 ? '⚠️' : '❌';
            
            const body = `## ${emoji} PR Quality Check
            
            **Score: ${score}/100**
            
            | Criteria | Status |
            |----------|--------|
            | PR Template Filled | ${{ steps.template-check.outputs.template_filled == 'true' && '✅' || '❌' }} |
            | Issue Linked | ${{ steps.issue-check.outputs.issue_linked == 'true' && '✅' || '⚠️' }} |
            | Reasonable Size | ${{ steps.size-check.outputs.size_ok == 'true' && '✅' || '⚠️' }} |
            | Branch Naming | ${{ steps.branch-check.outputs.branch_valid == 'true' && '✅' || '⚠️' }} |
            
            Please ensure all criteria are met for the best PR quality!`;
            
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: body
            });
```

### Add PR Template

Create `.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Description
<!-- Provide a clear description of what this PR does -->

## Related Issue
<!-- Link to the issue this PR addresses -->
Closes #

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Checklist
- [ ] Self-review completed
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
- [ ] Code follows project style guide
- [ ] All tests passing

## Screenshots (if applicable)
<!-- Add screenshots for UI changes -->

## Additional Notes
<!-- Any other information relevant to this PR -->
```

---

## Option 4: Webhook Integration

### Setup GitHub Webhook

1. Go to repository Settings → Webhooks → Add webhook
2. Set Payload URL to your server endpoint
3. Select content type: `application/json`
4. Choose events: `Pull requests`
5. Save webhook

### Example Webhook Handler (Node.js)

```javascript
/**
 * GitHub Webhook Handler
 * (c) 2026 Qorix
 */

const express = require('express');
const crypto = require('crypto');
const app = express();

app.use(express.json());

const WEBHOOK_SECRET = process.env.GITHUB_WEBHOOK_SECRET;

/**
 * Verify GitHub webhook signature
 */
function verifySignature(req) {
    const signature = req.headers['x-hub-signature-256'];
    const hmac = crypto.createHmac('sha256', WEBHOOK_SECRET);
    const digest = 'sha256=' + hmac.update(JSON.stringify(req.body)).digest('hex');
    return crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(digest));
}

/**
 * Handle PR events
 */
app.post('/webhook/github', (req, res) => {
    // Verify signature
    if (!verifySignature(req)) {
        return res.status(401).send('Unauthorized');
    }
    
    const event = req.headers['x-github-event'];
    const payload = req.body;
    
    if (event === 'pull_request') {
        const action = payload.action;
        const pr = payload.pull_request;
        
        console.log(`PR ${action}: #${pr.number} - ${pr.title}`);
        
        // Process PR data
        // Store in database or trigger evaluation
        
        // Example: Check PR template
        if (!pr.body || pr.body.trim().length === 0) {
            console.warn(`PR #${pr.number} has empty description`);
        }
        
        // Calculate quality metrics
        const linesChanged = pr.additions + pr.deletions;
        console.log(`Lines changed: ${linesChanged}`);
    }
    
    res.status(200).send('OK');
});

app.listen(3000, () => {
    console.log('Webhook server listening on port 3000');
});
```

---

## Option 5: Third-Party Tools

### Danger JS

Automated PR checking with custom rules:

```javascript
// dangerfile.js
// (c) 2026 Qorix

import { danger, warn, fail, message } from 'danger';

// Check PR description
if (!danger.github.pr.body || danger.github.pr.body.length < 10) {
    fail('Please provide a detailed PR description');
}

// Check for issue link
const hasIssueLink = /closes #\d+|fixes #\d+/i.test(danger.github.pr.body);
if (!hasIssueLink) {
    warn('Consider linking this PR to an issue');
}

// Check PR size
const bigPRThreshold = 500;
const additions = danger.github.pr.additions;
const deletions = danger.github.pr.deletions;

if (additions + deletions > bigPRThreshold) {
    warn('This PR is quite large. Consider breaking it into smaller PRs');
}

// Check for tests
const hasTests = danger.git.modified_files.some(f => f.includes('.test.') || f.includes('.spec.'));
const hasCode = danger.git.modified_files.some(f => f.endsWith('.js') || f.endsWith('.ts'));

if (hasCode && !hasTests) {
    warn('Consider adding tests for your changes');
}

message('✅ Thanks for your contribution!');
```

### CodeRabbit

AI-powered PR reviews - configure in `.coderabbit.yaml`:

```yaml
# CodeRabbit Configuration
# (c) 2026 Qorix

reviews:
  auto_review: true
  request_changes_workflow: true
  
checks:
  - name: "PR Description"
    enabled: true
  - name: "Test Coverage"
    enabled: true
  - name: "Code Complexity"
    enabled: true
  - name: "Security Scan"
    enabled: true
```

---

## 📊 Recommended Workflow

### Combined Approach

1. **GitHub Actions** - Automated basic checks
2. **PR Report Card** - Manual detailed evaluation
3. **Export & Report** - Regular team reviews

### Process Flow

```
1. Developer creates PR
   ↓
2. GitHub Actions runs quality checks
   ↓
3. Automated comment with preliminary score
   ↓
4. Reviewer performs detailed evaluation
   ↓
5. Record score in PR Report Card Dashboard
   ↓
6. Weekly/monthly statistics review
   ↓
7. Continuous improvement iterations
```

---

## 🔐 Security Best Practices

1. **Never commit tokens** - Use environment variables or GitHub Secrets
2. **Limit token permissions** - Grant minimum required scopes
3. **Rotate tokens regularly** - Change tokens every 90 days
4. **Use GitHub Apps** - Preferred over personal access tokens for production
5. **Verify webhook signatures** - Always validate webhook authenticity

---

## 🛠️ Troubleshooting

### API Rate Limits

GitHub limits:
- Authenticated: 5,000 requests/hour
- Unauthenticated: 60 requests/hour

Solution: Cache responses, use conditional requests

### Webhook Delivery Issues

1. Check webhook delivery logs in GitHub settings
2. Verify endpoint is publicly accessible
3. Check firewall/security group rules
4. Validate webhook secret

### Action Failures

1. Check workflow logs in Actions tab
2. Verify permissions in workflow file
3. Test locally with `act` tool
4. Review GitHub Actions documentation

---

## 📚 Additional Resources

- [GitHub REST API Documentation](https://docs.github.com/en/rest)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Webhooks Guide](https://docs.github.com/en/webhooks)
- [Danger JS Documentation](https://danger.systems/js/)

---

For questions or assistance, consult your team's DevOps or reach out to the dashboard maintainer.

**Happy Automating! 🚀**
