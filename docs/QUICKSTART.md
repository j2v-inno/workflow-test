# Quick Start Guide

Get your GitHub issue management workflow up and running in 5 minutes!

## 📦 Installation Steps

### Step 1: Add the Workflow File
```bash
# In your repository root
mkdir -p .github/workflows
cp issue-management.yml .github/workflows/
git add .github/workflows/issue-management.yml
git commit -m "Add issue management workflow"
git push
```

### Step 2: Set Up Labels

**Option A: Using the Script (Recommended)**
```bash
chmod +x setup-labels.sh
./setup-labels.sh <your-org> <your-repo> <your-github-token>
```

To create a GitHub token:
1. Go to https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select scope: `repo` (full repository access)
4. Copy the token and use it in the script

**Option B: Manual Setup**
1. Go to your repository on GitHub
2. Click "Issues" → "Labels"
3. Create labels from `labels.yml` file

### Step 3: Add Issue Templates (Optional but Recommended)
```bash
mkdir -p .github/ISSUE_TEMPLATE
cp user-story-template.md .github/ISSUE_TEMPLATE/
cp test-case-failed-template.md .github/ISSUE_TEMPLATE/
cp internal-feedback-template.md .github/ISSUE_TEMPLATE/
git add .github/ISSUE_TEMPLATE/
git commit -m "Add issue templates"
git push
```

### Step 4: Test the Workflow

1. **Create a test User Story:**
   - Go to Issues → New Issue
   - Select "User Story" template
   - Fill in with: "As an Admin, I want to test the workflow..."
   - Submit
   - Verify it gets `type: user-story` and `status: backlog` labels automatically

2. **Test status transition:**
   - Add a sprint label: `sprint-1`
   - Try changing to `status: sprint-backlog`
   - Then change to `status: to-do`
   - Verify it works (sprint label is required)

3. **Test comment commands:**
   - Comment `/in-progress` on the issue
   - Verify status changes automatically

## 🎯 Common Use Cases

### Start a New Sprint
1. Create sprint label: `sprint-5`
2. Add to issues in Sprint Backlog
3. Move to `status: to-do` when ready to start

### Developer Workflow
1. Pick issue from To Do
2. Comment `/in-progress`
3. Work on the feature
4. Create PR and link to issue
5. Comment `/code-review`
6. After review: `/dev-testing`

### QA Workflow
1. Check issues with `qa-ready` label
2. Test the feature
3. If passed: `/qa`
4. If failed: Remove `qa-ready` label and comment feedback
5. Developer fixes and re-adds `qa-ready`

### Release Process
1. Move approved items to `/release`
2. After sprint deployment
3. Issues auto-close (or manually close)

## ⚡ Quick Commands Reference

| Command | Action |
|---------|--------|
| `/backlog` | Move to Backlog |
| `/sprint-backlog` | Move to Sprint Backlog |
| `/todo` | Move to To Do |
| `/in-progress` | Start working |
| `/code-review` | Ready for review |
| `/dev-testing` | Move to Dev Testing |
| `/qa` | Move to QA |
| `/release` | Ready for release |
| `/qa-ready` | Mark ready for QA |
| `/qa-failed` | Mark QA as failed |

## 🔍 Verification

After installation, verify the workflow is running:
1. Go to "Actions" tab in your repository
2. You should see "Issue Management Workflow"
3. Create a test issue to trigger it
4. Check the Actions tab to see it running

## 🐛 Troubleshooting

**Workflow not running?**
- Check the `.github/workflows/` directory exists
- Verify the YAML file is properly formatted
- Check Actions tab for any errors

**Labels not auto-applying?**
- Ensure labels exist in your repository
- Check issue title/body matches detection patterns
- Manually add if needed

**Status transitions blocked?**
- Read the comment explaining why
- Ensure all requirements are met
- Check that sprint labels are added when needed

## 📚 Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Customize the workflow to fit your team's needs
- Set up branch protection rules for code review
- Configure GitHub Projects for sprint boards

## 💡 Pro Tips

1. **Use Projects:** Create a GitHub Project board with columns matching your statuses
2. **Automate PRs:** Link PRs to issues using "Closes #123" in PR description
3. **Sprint Planning:** Use milestones for sprint planning and tracking
4. **Notifications:** Set up Slack/Teams integration for status changes
5. **Metrics:** Use GitHub Insights to track sprint velocity

## 🤝 Support

Having issues? 
- Check the [README.md](README.md) for detailed documentation
- Review the workflow file for customization options
- Open an issue in this repository for questions

---

**Ready to go?** Start with Step 1 above! 🚀
