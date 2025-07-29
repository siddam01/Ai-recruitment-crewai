#!/bin/bash

# Demo Project Setup - Non-interactive version of the main function
# This demonstrates the framework's automated project initialization

set -e

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
echo -e "${BLUE}  Project Framework DEMO Initialization${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Demo project configuration
PROJECT_NAME="demo-ecommerce-app"
PROJECT_TYPE="web_application"
PM_NAME="Demo Manager"
TECH_LEAD="Demo Architect"
TEAM_SIZE="6"
PROJECT_DIR="./demo-projects/$PROJECT_NAME"

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo -e "${YELLOW}DEMO Project Setup Configuration:${NC}"
echo "Project Name: $PROJECT_NAME"
echo "Type: $PROJECT_TYPE"
echo "PM: $PM_NAME"
echo "Tech Lead: $TECH_LEAD"
echo "Team Size: $TEAM_SIZE"
echo "Directory: $PROJECT_DIR"
echo ""

# Create directory structure
create_directory_structure() {
    local project_dir="$1"
    
    print_step "Creating project directory structure..."
    
    mkdir -p "$project_dir"/{docs/{architecture,requirements,planning},src,tests,config,scripts,.agents,.templates}
    
    print_status "Directory structure created"
}

# Copy framework files
copy_framework_files() {
    local project_dir="$1"
    
    print_step "Copying framework templates and configurations..."
    
    # Copy templates
    if [ -d "$TEMPLATES_DIR" ]; then
        cp -r "$TEMPLATES_DIR"/* "$project_dir/.templates/" 2>/dev/null || print_warning "Some template files may not exist yet"
    fi
    
    # Copy agent configurations
    if [ -d "$AGENTS_DIR" ]; then
        cp -r "$AGENTS_DIR"/* "$project_dir/.agents/" 2>/dev/null || print_warning "Some agent files may not exist yet"
    fi
    
    # Copy essential guides
    if [ -f "$GUIDES_DIR/getting-started/quick-start-guide.md" ]; then
        cp "$GUIDES_DIR/getting-started/quick-start-guide.md" "$project_dir/docs/" 2>/dev/null || print_warning "Quick start guide not found"
    fi
    
    print_status "Framework files copied"
}

# Create project configuration
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
  project_management: "github_projects"
  communication: "slack"
  documentation: "markdown"
  version_control: "git"
EOF
    
    print_status "Project configuration created"
}

# Initialize project charter
initialize_project_charter() {
    local project_dir="$1"
    local project_name="$2"
    
    print_step "Initializing project charter..."
    
    cat > "$project_dir/docs/project-charter.md" << 'EOF'
# Project Charter - Demo E-Commerce App

## Project Information

| Field | Value |
|-------|-------|
| **Project Name** | Demo E-Commerce App |
| **Project Code** | DEMO-ECOM-001 |
| **Project Manager** | Demo Manager |
| **Sponsor** | Framework Demo |
| **Start Date** | 2024-01-15 |
| **Target End Date** | 2024-04-15 |
| **Budget** | $100,000 |
| **Priority** | High |

## Executive Summary

This demo project showcases the Project Management & Architecture Framework by setting up a complete e-commerce application project structure with AI-powered assistance.

## Project Objectives

### Primary Objectives
1. Demonstrate framework capabilities for web application projects
2. Show automated project setup and configuration
3. Illustrate AI agent integration for project management

## Success Criteria
1. Complete project setup in under 5 minutes
2. Generate all required documentation templates
3. Configure AI agents for project assistance
EOF
    
    print_status "Project charter created"
}

# Set up Git repository
setup_git_repository() {
    local project_dir="$1"
    
    print_step "Setting up Git repository..."
    
    cd "$project_dir"
    
    # Initialize Git repository
    git init --quiet
    
    # Create .gitignore
    cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.env
.env.local

# Production builds
/build
/dist

# IDE files
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
EOF
    
    # Initial commit
    git add .
    git commit -m "Initial project setup with framework templates" --quiet
    
    print_status "Git repository initialized"
    cd - > /dev/null
}

# Create README
create_readme() {
    local project_dir="$1"
    local project_name="$2"
    
    print_step "Creating project README..."
    
    cat > "$project_dir/README.md" << EOF
# $project_name

## Project Overview

This is a web application project initialized with the Project Management & Architecture Framework.

## Quick Start

1. Review the project charter: \`docs/project-charter.md\`
2. Check the project configuration: \`project-config.yaml\`
3. Follow the quick start guide: \`docs/quick-start-guide.md\`

## AI Agents

This project is configured with AI agents to assist with:
- Project management and planning
- Architecture design decisions
- Code generation and review
- Quality assurance

## Framework Features Demonstrated

- ✅ Automated project initialization
- ✅ Template-driven documentation
- ✅ AI agent configuration
- ✅ Git repository setup
- ✅ Project structure organization

## Next Steps

1. Customize the project charter with your specific requirements
2. Configure AI agents based on your team needs
3. Start development following the framework guidelines
EOF
    
    print_status "README created"
}

# Display results
display_results() {
    local project_dir="$1"
    local project_name="$2"
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}     DEMO Setup Complete! 🎉          ${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${BLUE}Demo project created:${NC} $project_dir"
    echo -e "${BLUE}Project name:${NC} $project_name"
    echo ""
    echo -e "${YELLOW}Files Created:${NC}"
    find "$project_dir" -type f | sort | sed 's|^|  • |'
    echo ""
    echo -e "${YELLOW}Directory Structure:${NC}"
    find "$project_dir" -type d | sort | sed 's|^|  📁 |'
    echo ""
    echo -e "${GREEN}Framework demonstration completed successfully! 🚀${NC}"
}

# Main execution
main() {
    print_step "Starting DEMO project initialization..."
    
    # Check if framework directory exists
    if [ ! -d "$FRAMEWORK_ROOT" ]; then
        echo "Framework directory not found: $FRAMEWORK_ROOT"
        exit 1
    fi
    
    # Remove existing demo if it exists
    if [ -d "$PROJECT_DIR" ]; then
        print_warning "Removing existing demo project..."
        rm -rf "$PROJECT_DIR"
    fi
    
    # Execute setup steps
    create_directory_structure "$PROJECT_DIR"
    copy_framework_files "$PROJECT_DIR"
    create_project_config "$PROJECT_DIR" "$PROJECT_NAME" "$PROJECT_TYPE" "$PM_NAME" "$TECH_LEAD" "$TEAM_SIZE"
    initialize_project_charter "$PROJECT_DIR" "$PROJECT_NAME"
    create_readme "$PROJECT_DIR" "$PROJECT_NAME"
    setup_git_repository "$PROJECT_DIR"
    
    # Show results
    display_results "$PROJECT_DIR" "$PROJECT_NAME"
}

# Run the demo
main "$@"