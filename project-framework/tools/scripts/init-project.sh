#!/bin/bash

# Project Management & Architecture Framework - Project Initialization Script
# This script helps you quickly set up a new project with the framework

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Framework paths
FRAMEWORK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TEMPLATES_DIR="$FRAMEWORK_ROOT/templates"
AGENTS_DIR="$FRAMEWORK_ROOT/agents"
GUIDES_DIR="$FRAMEWORK_ROOT/guides"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Project Framework Initialization     ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Function to print status messages
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Function to prompt for user input
prompt_user() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " user_input
        user_input=${user_input:-$default}
    else
        read -p "$prompt: " user_input
    fi
    
    eval "$var_name='$user_input'"
}

# Function to validate project name
validate_project_name() {
    local name="$1"
    if [[ ! "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        print_error "Project name must contain only letters, numbers, hyphens, and underscores"
        return 1
    fi
    return 0
}

# Function to create directory structure
create_directory_structure() {
    local project_dir="$1"
    
    print_step "Creating project directory structure..."
    
    mkdir -p "$project_dir"/{
        docs/{architecture,requirements,planning},
        src,
        tests,
        config,
        scripts,
        .agents,
        .templates
    }
    
    print_status "Directory structure created"
}

# Function to copy framework files
copy_framework_files() {
    local project_dir="$1"
    
    print_step "Copying framework templates and configurations..."
    
    # Copy templates
    cp -r "$TEMPLATES_DIR"/* "$project_dir/.templates/"
    
    # Copy agent configurations
    cp -r "$AGENTS_DIR"/* "$project_dir/.agents/"
    
    # Copy essential guides
    cp "$GUIDES_DIR/getting-started/quick-start-guide.md" "$project_dir/docs/"
    
    print_status "Framework files copied"
}

# Function to create project configuration
create_project_config() {
    local project_dir="$1"
    local project_name="$2"
    local project_type="$3"
    local pm_name="$4"
    local tech_lead="$5"
    local team_size="$6"
    
    print_step "Creating project configuration..."
    
    cat > "$project_dir/project-config.yaml" << EOF
project:
  name: "$project_name"
  type: "$project_type"
  phase: "initiation"
  start_date: "$(date +%Y-%m-%d)"
  estimated_duration: "12 weeks"
  created_date: "$(date +%Y-%m-%d)"
  
team:
  project_manager: "$pm_name"
  tech_lead: "$tech_lead"
  team_size: $team_size
  
ai_agents:
  enabled: true
  project_manager_agent: true
  architect_agent: true
  developer_agent: false
  qa_agent: false
  devops_agent: false

settings:
  auto_reporting: true
  daily_standups: true
  weekly_reviews: true
  risk_monitoring: true

tools:
  project_management: "github_projects"  # Options: jira, azure_devops, github_projects, trello
  communication: "slack"                 # Options: slack, teams, discord
  documentation: "markdown"              # Options: confluence, notion, markdown
  version_control: "git"                 # Options: git, svn
EOF
    
    print_status "Project configuration created"
}

# Function to initialize project charter
initialize_project_charter() {
    local project_dir="$1"
    local project_name="$2"
    local project_type="$3"
    
    print_step "Initializing project charter..."
    
    # Copy and customize project charter template
    cp "$TEMPLATES_DIR/project-management/project-charter.md" "$project_dir/docs/project-charter.md"
    
    # Replace placeholder values
    sed -i.bak "s/\[Enter project name\]/$project_name/g" "$project_dir/docs/project-charter.md"
    sed -i.bak "s/\[DD\/MM\/YYYY\]/$(date +%d\/%m\/%Y)/g" "$project_dir/docs/project-charter.md"
    rm -f "$project_dir/docs/project-charter.md.bak"
    
    print_status "Project charter template ready for customization"
}

# Function to create initial WBS
create_initial_wbs() {
    local project_dir="$1"
    local project_type="$2"
    
    print_step "Creating initial Work Breakdown Structure..."
    
    cp "$TEMPLATES_DIR/project-management/work-breakdown-structure.md" "$project_dir/docs/planning/wbs.md"
    
    # Customize WBS based on project type
    case "$project_type" in
        "web_application")
            cat >> "$project_dir/docs/planning/wbs.md" << EOF

### Web Application Specific Tasks

#### Frontend Development
- UI/UX Design
- Component Development
- State Management
- Responsive Design
- Cross-browser Testing

#### Backend Development
- API Design
- Database Schema
- Authentication/Authorization
- Business Logic Implementation
- Performance Optimization

#### Integration
- Frontend-Backend Integration
- Third-party Service Integration
- Payment Gateway Integration (if applicable)
EOF
            ;;
        "mobile_app")
            cat >> "$project_dir/docs/planning/wbs.md" << EOF

### Mobile Application Specific Tasks

#### Mobile Development
- Platform Selection (iOS/Android/Cross-platform)
- UI/UX Design for Mobile
- Native/Hybrid Development
- Device Testing
- App Store Preparation

#### Backend Services
- Mobile API Development
- Push Notification Setup
- Offline Capability
- Data Synchronization
EOF
            ;;
    esac
    
    print_status "Initial WBS created"
}

# Function to set up Git repository
setup_git_repository() {
    local project_dir="$1"
    
    print_step "Setting up Git repository..."
    
    cd "$project_dir"
    
    # Initialize Git repository
    git init
    
    # Create .gitignore
    cat > .gitignore << EOF
# Dependencies
node_modules/
*/node_modules/
.pnp
.pnp.js

# Production builds
/build
/dist
/out

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Temporary files
*.tmp
*.temp
.cache/

# Database
*.db
*.sqlite
*.sqlite3

# Configuration (only if containing secrets)
config/production.yaml
config/secrets.yaml
EOF
    
    # Initial commit
    git add .
    git commit -m "Initial project setup with framework templates"
    
    print_status "Git repository initialized"
}

# Function to create README
create_readme() {
    local project_dir="$1"
    local project_name="$2"
    local project_type="$3"
    
    print_step "Creating project README..."
    
    cat > "$project_dir/README.md" << EOF
# $project_name

## Project Overview

This is a $project_type project initialized with the Project Management & Architecture Framework.

## Quick Start

1. Review the project charter: \`docs/project-charter.md\`
2. Check the project configuration: \`project-config.yaml\`
3. Follow the quick start guide: \`docs/quick-start-guide.md\`

## Project Structure

\`\`\`
$project_name/
├── docs/                   # Project documentation
│   ├── architecture/       # Architecture documents
│   ├── requirements/       # Requirements documentation
│   └── planning/          # Project planning documents
├── src/                   # Source code
├── tests/                 # Test files
├── config/                # Configuration files
├── scripts/               # Build and utility scripts
├── .agents/               # AI agent configurations
├── .templates/            # Document templates
└── project-config.yaml    # Main project configuration
\`\`\`

## Development Setup

1. Clone the repository
2. Install dependencies
3. Configure environment
4. Run initial setup

## AI Agents

This project is configured with AI agents to assist with:
- Project management and planning
- Architecture design decisions
- Code generation and review
- Quality assurance

## Contributing

1. Follow the established coding standards
2. Update documentation for any changes
3. Use the provided templates for consistency
4. Leverage AI agents for assistance

## Resources

- [Framework Documentation](docs/quick-start-guide.md)
- [Architecture Templates](.templates/architecture/)
- [Project Management Templates](.templates/project-management/)
- [Agent Configurations](.agents/)
EOF
    
    print_status "README created"
}

# Function to display next steps
display_next_steps() {
    local project_dir="$1"
    local project_name="$2"
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}     Project Setup Complete! 🎉       ${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${BLUE}Project created:${NC} $project_dir"
    echo -e "${BLUE}Project name:${NC} $project_name"
    echo ""
    echo -e "${YELLOW}Next Steps:${NC}"
    echo "1. cd $project_dir"
    echo "2. Review and customize docs/project-charter.md"
    echo "3. Update project-config.yaml with specific details"
    echo "4. Follow the quick start guide: docs/quick-start-guide.md"
    echo ""
    echo -e "${YELLOW}Key Files Created:${NC}"
    echo "• project-config.yaml         - Main project configuration"
    echo "• docs/project-charter.md     - Project charter template"
    echo "• docs/planning/wbs.md        - Work breakdown structure"
    echo "• .agents/                    - AI agent configurations"
    echo "• .templates/                 - Document templates"
    echo ""
    echo -e "${YELLOW}Quick Commands:${NC}"
    echo "• View project structure:     tree $project_dir"
    echo "• Start planning:             cd $project_dir && cat docs/quick-start-guide.md"
    echo "• Configure AI agents:        cd $project_dir/.agents"
    echo ""
    echo -e "${GREEN}Happy coding! 🚀${NC}"
}

# Main script execution
main() {
    # Check if framework directory exists
    if [ ! -d "$FRAMEWORK_ROOT" ]; then
        print_error "Framework directory not found: $FRAMEWORK_ROOT"
        exit 1
    fi
    
    # Get project details from user
    echo "Let's set up your new project!"
    echo ""
    
    # Project name
    while true; do
        prompt_user "Enter project name" "" PROJECT_NAME
        if validate_project_name "$PROJECT_NAME"; then
            break
        fi
    done
    
    # Project type
    echo ""
    echo "Select project type:"
    echo "1) Web Application"
    echo "2) Mobile Application"
    echo "3) Desktop Application"
    echo "4) API/Backend Service"
    echo "5) Data Analytics"
    echo "6) AI/ML Project"
    echo ""
    
    while true; do
        prompt_user "Enter choice (1-6)" "1" PROJECT_TYPE_CHOICE
        case "$PROJECT_TYPE_CHOICE" in
            1) PROJECT_TYPE="web_application"; break ;;
            2) PROJECT_TYPE="mobile_app"; break ;;
            3) PROJECT_TYPE="desktop_app"; break ;;
            4) PROJECT_TYPE="api_service"; break ;;
            5) PROJECT_TYPE="data_analytics"; break ;;
            6) PROJECT_TYPE="ai_ml"; break ;;
            *) print_warning "Please enter a number between 1 and 6" ;;
        esac
    done
    
    # Team details
    echo ""
    prompt_user "Project Manager name" "$(whoami)" PM_NAME
    prompt_user "Technical Lead name" "TBD" TECH_LEAD
    prompt_user "Estimated team size" "5" TEAM_SIZE
    
    # Project directory
    echo ""
    prompt_user "Project directory" "./$PROJECT_NAME" PROJECT_DIR
    
    # Confirm setup
    echo ""
    echo -e "${YELLOW}Project Setup Summary:${NC}"
    echo "Name: $PROJECT_NAME"
    echo "Type: $PROJECT_TYPE"
    echo "PM: $PM_NAME"
    echo "Tech Lead: $TECH_LEAD"
    echo "Team Size: $TEAM_SIZE"
    echo "Directory: $PROJECT_DIR"
    echo ""
    
    prompt_user "Proceed with setup? (y/n)" "y" CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        print_warning "Setup cancelled"
        exit 0
    fi
    
    # Create project
    echo ""
    print_step "Starting project initialization..."
    
    # Expand relative path to absolute
    PROJECT_DIR=$(readlink -f "$PROJECT_DIR")
    
    # Check if directory already exists
    if [ -d "$PROJECT_DIR" ]; then
        print_error "Directory already exists: $PROJECT_DIR"
        prompt_user "Continue anyway? (y/n)" "n" CONTINUE
        if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    
    # Execute setup steps
    create_directory_structure "$PROJECT_DIR"
    copy_framework_files "$PROJECT_DIR"
    create_project_config "$PROJECT_DIR" "$PROJECT_NAME" "$PROJECT_TYPE" "$PM_NAME" "$TECH_LEAD" "$TEAM_SIZE"
    initialize_project_charter "$PROJECT_DIR" "$PROJECT_NAME" "$PROJECT_TYPE"
    create_initial_wbs "$PROJECT_DIR" "$PROJECT_TYPE"
    create_readme "$PROJECT_DIR" "$PROJECT_NAME" "$PROJECT_TYPE"
    setup_git_repository "$PROJECT_DIR"
    
    # Show completion message
    display_next_steps "$PROJECT_DIR" "$PROJECT_NAME"
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Project Framework Initialization Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "This script helps you quickly set up a new project with the"
    echo "Project Management & Architecture Framework."
    echo ""
    echo "The script will prompt you for:"
    echo "  - Project name"
    echo "  - Project type (web app, mobile app, etc.)"
    echo "  - Team member names"
    echo "  - Project directory location"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo ""
    echo "Example:"
    echo "  $0"
    echo ""
    exit 0
fi

# Run main function
main "$@"