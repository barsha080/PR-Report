"""
GitHub PR Data Fetcher
(c) 2026 Qorix

This script fetches Pull Request data from GitHub repositories using the GitHub REST API
and formats it for import into the PR Report Card Dashboard.

Usage:
    python fetch_github_prs.py --token YOUR_TOKEN --repo owner/repo-name --output prs.json

Requirements:
    pip install requests
"""

import argparse
import json
import sys
from datetime import datetime
from typing import List, Dict, Any

try:
    import requests
except ImportError:
    print("Error: requests library not found. Install with: pip install requests")
    sys.exit(1)


class GitHubPRFetcher:
    """
    Fetches Pull Request data from GitHub API.
    """
    
    def __init__(self, token: str, repo: str):
        """
        Initialize the GitHub PR fetcher.
        
        Args:
            token: GitHub personal access token
            repo: Repository in format 'owner/repo-name'
        """
        self.token = token
        self.repo = repo
        self.base_url = "https://api.github.com"
        self.headers = {
            "Authorization": f"token {token}",
            "Accept": "application/vnd.github.v3+json"
        }
    
    def fetch_pull_requests(self, state: str = "all", max_prs: int = 100) -> List[Dict[str, Any]]:
        """
        Fetch pull requests from the repository.
        
        Args:
            state: PR state filter ('all', 'open', 'closed')
            max_prs: Maximum number of PRs to fetch
            
        Returns:
            List of PR data dictionaries
        """
        url = f"{self.base_url}/repos/{self.repo}/pulls"
        params = {
            "state": state,
            "per_page": min(max_prs, 100),
            "sort": "updated",
            "direction": "desc"
        }
        
        print(f"Fetching PRs from {self.repo}...")
        
        try:
            response = requests.get(url, headers=self.headers, params=params)
            response.raise_for_status()
            prs = response.json()
            print(f"Found {len(prs)} PRs")
            return prs
        except requests.exceptions.RequestException as e:
            print(f"Error fetching PRs: {e}")
            return []
    
    def fetch_pr_files(self, pr_number: int) -> List[Dict[str, Any]]:
        """
        Fetch files changed in a specific PR.
        
        Args:
            pr_number: Pull request number
            
        Returns:
            List of file change objects
        """
        url = f"{self.base_url}/repos/{self.repo}/pulls/{pr_number}/files"
        
        try:
            response = requests.get(url, headers=self.headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f"Warning: Could not fetch files for PR #{pr_number}: {e}")
            return []
    
    def fetch_pr_reviews(self, pr_number: int) -> List[Dict[str, Any]]:
        """
        Fetch reviews for a specific PR.
        
        Args:
            pr_number: Pull request number
            
        Returns:
            List of review objects
        """
        url = f"{self.base_url}/repos/{self.repo}/pulls/{pr_number}/reviews"
        
        try:
            response = requests.get(url, headers=self.headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f"Warning: Could not fetch reviews for PR #{pr_number}: {e}")
            return []
    
    def calculate_lines_changed(self, files: List[Dict[str, Any]]) -> int:
        """
        Calculate total lines changed from file list.
        
        Args:
            files: List of file change objects
            
        Returns:
            Total lines changed (additions + deletions)
        """
        return sum(f.get('additions', 0) + f.get('deletions', 0) for f in files)
    
    def format_for_dashboard(self, prs: List[Dict[str, Any]], include_details: bool = True) -> List[Dict[str, Any]]:
        """
        Format PR data for dashboard import.
        
        Args:
            prs: List of PR data from GitHub API
            include_details: Whether to fetch additional details (files, reviews)
            
        Returns:
            Formatted data ready for dashboard import
        """
        formatted = []
        
        for i, pr in enumerate(prs, 1):
            print(f"Processing PR {i}/{len(prs)}: #{pr['number']} - {pr['title']}")
            
            # Fetch additional details if requested
            lines_changed = pr.get('additions', 0) + pr.get('deletions', 0)
            if include_details and lines_changed == 0:
                files = self.fetch_pr_files(pr['number'])
                lines_changed = self.calculate_lines_changed(files)
            
            # Determine status
            if pr['state'] == 'closed':
                status = 'merged' if pr.get('merged_at') else 'closed'
            elif pr.get('draft', False):
                status = 'draft'
            else:
                status = 'open'
            
            # Create dashboard-compatible record
            pr_data = {
                "id": int(f"{pr['id']}{int(datetime.now().timestamp())}"),  # Unique ID
                "number": pr['number'],
                "title": pr['title'],
                "author": pr['user']['login'],
                "repo": self.repo,
                "status": status,
                "linesChanged": lines_changed,
                "createdDate": pr['created_at'][:10],
                "reviewedDate": (pr['merged_at'] or pr['closed_at'] or pr['updated_at'])[:10],
                "url": pr['html_url'],
                "checklist": {},  # To be filled during manual review
                "score": 0,  # To be calculated
                "comments": f"Fetched from GitHub. Original description: {pr['body'][:200] if pr['body'] else 'No description'}...",
                "timestamp": datetime.now().isoformat()
            }
            
            formatted.append(pr_data)
        
        return formatted
    
    def export_to_json(self, data: List[Dict[str, Any]], output_file: str):
        """
        Export formatted data to JSON file.
        
        Args:
            data: Formatted PR data
            output_file: Output filename
        """
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        
        print(f"\n✅ Data exported to {output_file}")
        print(f"Total PRs: {len(data)}")
        print("\nNext steps:")
        print("1. Open PR Report Card Dashboard")
        print("2. Go to Export tab")
        print("3. Use 'Import from JSON Backup' to load this file")
        print("4. Complete guideline checklist for each PR")


def main():
    """
    Main entry point for the script.
    """
    parser = argparse.ArgumentParser(
        description="Fetch Pull Request data from GitHub for PR Report Card Dashboard"
    )
    parser.add_argument(
        "--token",
        required=True,
        help="GitHub personal access token"
    )
    parser.add_argument(
        "--repo",
        required=True,
        help="Repository in format 'owner/repo-name'"
    )
    parser.add_argument(
        "--state",
        default="all",
        choices=["all", "open", "closed"],
        help="PR state filter (default: all)"
    )
    parser.add_argument(
        "--max",
        type=int,
        default=100,
        help="Maximum number of PRs to fetch (default: 100)"
    )
    parser.add_argument(
        "--output",
        default=f"pr-data-{datetime.now().strftime('%Y%m%d')}.json",
        help="Output filename (default: pr-data-YYYYMMDD.json)"
    )
    parser.add_argument(
        "--quick",
        action="store_true",
        help="Quick mode - don't fetch detailed file information"
    )
    
    args = parser.parse_args()
    
    # Validate repository format
    if '/' not in args.repo:
        print("Error: Repository must be in format 'owner/repo-name'")
        sys.exit(1)
    
    # Create fetcher instance
    fetcher = GitHubPRFetcher(args.token, args.repo)
    
    # Fetch PRs
    prs = fetcher.fetch_pull_requests(args.state, args.max)
    
    if not prs:
        print("No PRs found or error occurred.")
        sys.exit(1)
    
    # Format for dashboard
    formatted_data = fetcher.format_for_dashboard(prs, include_details=not args.quick)
    
    # Export to JSON
    fetcher.export_to_json(formatted_data, args.output)


if __name__ == "__main__":
    main()
