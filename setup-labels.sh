#!/bin/bash

# GitHub Label Setup Script
# This script creates all required labels for the issue management workflow
# Usage: ./setup-labels.sh <owner> <repo> <github-token>

set -e

if [ $# -ne 3 ]; then
    echo "Usage: $0 <owner> <repo> <github-token>"
    echo "Example: $0 myorg myrepo ghp_xxxxxxxxxxxxx"
    exit 1
fi

OWNER=$1
REPO=$2
TOKEN=$3

API_URL="https://api.github.com/repos/$OWNER/$REPO/labels"

# Function to create a label
create_label() {
    local name=$1
    local color=$2
    local description=$3
    
    echo "Creating label: $name"
    
    curl -X POST \
        -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "$API_URL" \
        -d "{\"name\":\"$name\",\"color\":\"$color\",\"description\":\"$description\"}" \
        > /dev/null 2>&1 || echo "  - Label may already exist or there was an error"
}

echo "Setting up labels for $OWNER/$REPO..."
echo ""

# Status Labels
echo "Creating Status Labels..."
create_label "status: backlog" "D3D3D3" "All new tickets start here"
create_label "status: sprint-backlog" "FFA500" "Ready for sprint planning"
create_label "status: to-do" "1E90FF" "Tasks assigned for current sprint"
create_label "status: in-progress" "FFFF00" "Currently being worked on"
create_label "status: code-review" "9370DB" "Awaiting code review"
create_label "status: dev-testing" "FF69B4" "Testing in dev environment"
create_label "status: qa" "32CD32" "QA testing before staging"
create_label "status: for-release" "00CED1" "Ready for staging release"

echo ""
echo "Creating Type Labels..."
create_label "type: user-story" "0075CA" "User story ticket"
create_label "type: test-case-failed" "D73A4A" "Failed test case from QA"
create_label "type: internal-feedback" "FBCA04" "Internal team feedback"

echo ""
echo "Creating Sprint Labels..."
for i in {1..10}; do
    create_label "sprint-$i" "5319E7" "Sprint $i"
done

echo ""
echo "Creating QA Labels..."
create_label "qa-ready" "28A745" "Ready for QA testing"

echo ""
echo "Creating Priority Labels..."
create_label "priority: critical" "B60205" "Critical priority"
create_label "priority: high" "D93F0B" "High priority"
create_label "priority: medium" "FBCA04" "Medium priority"
create_label "priority: low" "0E8A16" "Low priority"

echo ""
echo "✅ Label setup complete!"
echo ""
echo "You can view your labels at: https://github.com/$OWNER/$REPO/labels"
