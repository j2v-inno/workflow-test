# GitHub Issue Management Workflow

This workflow automates the lifecycle management of issues/tickets in your repository with automatic labeling, status validation, and sprint-based automation.

## 📋 Status Flow

```
Backlog → Sprint Backlog → To Do → In Progress → Code Review → Dev Testing → QA → For Release → Closed
```

### Status Descriptions

| Status | Label | Description |
|--------|-------|-------------|
| **Backlog** | `status: backlog` | All new tickets are created here |
| **Sprint Backlog** | `status: sprint-backlog` | Tickets with complete requirements, ready for sprint planning |
| **To Do** | `status: to-do` | Items discussed with devs, assigned for the sprint |
| **In Progress** | `status: in-progress` | Items currently being worked on |
| **Code Review** | `status: code-review` | Items with PR, awaiting code review |
| **Dev Testing** | `status: dev-testing` | Confirmed working on dev environment |
| **QA** | `status: qa` | Passed dev testing, final review before staging |
| **For Release** | `status: for-release` | Set for release to staging after sprint |

## 🏷️ Ticket Types

### User Story (US)
- **Label:** `type: user-story`
- **Auto-detected when:** Title starts with "US" or body contains "As an Admin | User | Project admin | Manager"
- **Required fields:**
  - User description starting with "As an [role]..."
  
### Test Case Failed (TC)
- **Label:** `type: test-case-failed`
- **Auto-detected when:** Title starts with "TC" or body contains test case structure
- **Required fields:**
  - Title
  - Steps
  - Expected behavior
  - SQA Failed message

### Internal Feedback (IF)
- **Label:** `type: internal-feedback`
- **Auto-detected when:** Title starts with "IF"
- **Required fields:**
  - Subject
  - Feedback description

## ✅ Transition Rules

### Backlog → Sprint Backlog
- ✓ Must have required content based on ticket type
- ✓ User Stories must include "As an [role]" statement
- ✓ Test Cases must include Steps and Expected Behavior
- ✓ Internal Feedback must include Subject and Description

### Sprint Backlog → To Do
- ✓ Must have a sprint label (e.g., `sprint-1`, `sprint-2`)
- The workflow will validate this before allowing the transition

### In Progress → Code Review
- ✓ Mandatory for all code updates
- A reminder comment will be posted to link the PR

### Dev Testing
- ✓ Automatically labeled as `qa-ready` when moved to this status
- ✓ QA can remove `qa-ready` label if testing fails
- ✓ Developer must fix and re-add `qa-ready` label for retesting

### For Release → Closed
- ✓ After sprint completion, issues are automatically closed
- Daily automated check runs to identify completed sprints

## 🚀 Usage

### Setting Up Labels

Create these labels in your repository:

**Status Labels:**
```
status: backlog (color: #D3D3D3)
status: sprint-backlog (color: #FFA500)
status: to-do (color: #1E90FF)
status: in-progress (color: #FFFF00)
status: code-review (color: #9370DB)
status: dev-testing (color: #FF69B4)
status: qa (color: #32CD32)
status: for-release (color: #00CED1)
```

**Type Labels:**
```
type: user-story (color: #0075CA)
type: test-case-failed (color: #D73A4A)
type: internal-feedback (color: #FBCA04)
```

**Sprint Labels:**
```
sprint-1, sprint-2, sprint-3, etc.
```

**QA Labels:**
```
qa-ready (color: #28A745)
```

### Quick Commands (via Comments)

You can change status by commenting on issues with these commands:

- `/backlog` - Move to Backlog
- `/sprint-backlog` - Move to Sprint Backlog
- `/todo` - Move to To Do
- `/in-progress` - Move to In Progress
- `/code-review` - Move to Code Review
- `/dev-testing` - Move to Dev Testing
- `/qa` - Move to QA
- `/release` - Move to For Release
- `/qa-ready` - Mark as ready for QA testing
- `/qa-failed` - Mark QA testing as failed

### Example Workflows

#### Creating a User Story
1. Create issue with title: "US: Dashboard Analytics"
2. Body must include: "As an Admin, I want to..."
3. Workflow automatically adds `type: user-story` and `status: backlog` labels

#### Moving to Sprint
1. Ensure issue has all required content
2. Add sprint label: `sprint-3`
3. Change label to `status: sprint-backlog`
4. Once planned, change to `status: to-do`

#### Dev Testing Process
1. Developer moves issue to `status: dev-testing`
2. Workflow automatically adds `qa-ready` label
3. QA tests and removes `qa-ready` if it fails
4. Developer fixes issue and adds `qa-ready` label back
5. QA retests

## 📁 Installation

1. Create `.github/workflows/` directory in your repository
2. Copy `issue-management.yml` to `.github/workflows/`
3. Create the required labels in your repository
4. (Optional) Create issue templates in `.github/ISSUE_TEMPLATE/`

## 🔧 Customization

### Modify Sprint Close Behavior
The workflow includes a scheduled job that runs daily. To change when issues are automatically closed, modify the schedule in the workflow file:

```yaml
schedule:
  - cron: '0 0 * * *'  # Daily at midnight
```

### Add Additional Validations
You can add more validation rules in the `validate_status_transition` job by editing the script section.

## 📝 Notes

- Only one status label can be active at a time
- Status changes trigger validation automatically
- Failed validations revert the issue to Backlog with an explanation
- QA workflow uses the `qa-ready` label to track testing readiness
- Sprint labels should follow the format: `sprint-[number]`

## 🐛 Troubleshooting

**Issue not auto-labeled:**
- Check if the title or body matches the detection patterns
- Manually add the type label if needed

**Status transition blocked:**
- Read the validation error comment on the issue
- Ensure all requirements are met before changing status
- Add required labels (e.g., sprint labels)

**QA workflow not working:**
- Ensure issue is in `status: dev-testing` 
- Check that `qa-ready` label exists in repository

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Labels Guide](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels)
- [Issue Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/about-issue-and-pull-request-templates)
