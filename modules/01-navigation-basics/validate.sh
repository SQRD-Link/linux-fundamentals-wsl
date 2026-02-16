#!/bin/bash

# Module 1: Navigation & File Basics - Validation Script
# This script checks if you completed all exercises correctly
# Following best practices: non-destructive, idempotent, user-friendly

# Strict mode (but not -e, we want to run ALL checks)
set -u
set -o pipefail

# Color codes for output (with fallback for non-color terminals)
RED=$(tput setaf 1 2>/dev/null || echo '')
GREEN=$(tput setaf 2 2>/dev/null || echo '')
YELLOW=$(tput setaf 3 2>/dev/null || echo '')
RESET=$(tput sgr0 2>/dev/null || echo '')

# Counters
PASSED=0
FAILED=0

# Helper functions with clear, actionable messages
pass() {
    echo -e "${GREEN}✓${RESET} $1"
    ((PASSED++))
}

fail() {
    echo -e "${RED}✗${RESET} $1"
    ((FAILED++))
}

warn() {
    echo -e "${YELLOW}⚠${RESET} $1"
}

# Check functions - each validates ONE thing with clear feedback
# Check if path exists with specific type and helpful feedback
check_exists() {
    local path="$1"
    local type="$2"
    local description="$3"
    
    # Check existence first
    if [[ ! -e "$path" ]]; then
        fail "$description missing: $path"
        return 1
    fi
    
    # Then check correct type
    if [[ "$type" = "dir" ]]; then
        if [[ -d "$path" ]]; then
            pass "$description exists"
            return 0
        else
            fail "$description exists but is not a directory: $path"
            return 1
        fi
    elif [[ "$type" = "file" ]]; then
        if [[ -f "$path" ]]; then
            pass "$description exists"
            return 0
        else
            fail "$description exists but is not a regular file: $path"
            return 1
        fi
    fi
    
    return 1
}

# Check that a file does NOT exist (for testing cleanup)
check_not_exists() {
    local path="$1"
    local description="$2"
    
    if [[ -e "$path" ]]; then
        fail "$description should have been deleted: $path"
        return 1
    else
        pass "$description properly removed"
        return 0
    fi
}

echo "========================================="
echo "Module 1: Validation Script"
echo "========================================="
echo ""
echo "Checking your work in a non-destructive way..."
echo "This script only READS files, never modifies them."
echo ""

# Set base directory (using proper quoting)
BASE_DIR="$HOME/cloud86-training"

# Pre-flight check: Does base directory exist?
if [[ ! -d "$BASE_DIR" ]]; then
    echo -e "${RED}✗${RESET} Main training directory not found!"
    echo ""
    echo "Expected location: $BASE_DIR"
    echo ""
    echo "Did you complete Exercise 1?"
    echo "The exercises should have created this directory structure."
    echo ""
    echo "Hint: Re-read exercises.md and make sure you're working"
    echo "      in your HOME directory (~), not /mnt/c/"
    echo ""
    exit 1
fi

# Verify we're on Linux filesystem, not Windows mount
if [[ "$BASE_DIR" == /mnt/* ]]; then
    warn "Your training directory is on /mnt/ (Windows filesystem)"
    warn "This works but will be SLOW. Consider moving to ~/cloud86-training"
    warn "See: resources/troubleshooting-scenarios/wsl2-common-issues.md"
    echo ""
fi

echo "Checking Exercise 1: Development Workspace Structure"
echo "---------------------------------------------"

check_exists "$BASE_DIR" "dir" "Main cloud86-training directory"
check_exists "$BASE_DIR/projects" "dir" "Projects directory"
check_exists "$BASE_DIR/projects/symfony-demo" "dir" "Symfony demo directory"
check_exists "$BASE_DIR/projects/symfony-demo/src" "dir" "Symfony src directory"
check_exists "$BASE_DIR/projects/symfony-demo/public" "dir" "Symfony public directory"
check_exists "$BASE_DIR/projects/symfony-demo/config" "dir" "Symfony config directory"
check_exists "$BASE_DIR/projects/php-basics" "dir" "PHP basics directory"
check_exists "$BASE_DIR/backups" "dir" "Backups directory"
check_exists "$BASE_DIR/temp" "dir" "Temp directory"

echo ""
echo "Checking Exercise 2: Project Files"
echo "---------------------------------------------"

check_exists "$BASE_DIR/projects/symfony-demo/README.md" "file" "README.md"
check_exists "$BASE_DIR/projects/symfony-demo/public/index.php" "file" "public/index.php"
check_exists "$BASE_DIR/projects/symfony-demo/public/.htaccess" "file" "public/.htaccess"
check_exists "$BASE_DIR/projects/symfony-demo/config/services.yaml" "file" "config/services.yaml"
check_exists "$BASE_DIR/projects/symfony-demo/config/routes.yaml" "file" "config/routes.yaml"

echo ""
echo "Checking Exercise 4: Backup Files"
echo "---------------------------------------------"

check_exists "$BASE_DIR/backups/services.backup.yaml" "file" "services.backup.yaml"
check_exists "$BASE_DIR/backups/routes.backup.yaml" "file" "routes.backup.yaml"

echo ""
echo "Checking Exercise 5: Temp Directory Organization"
echo "---------------------------------------------"

check_exists "$BASE_DIR/temp/logs" "dir" "temp/logs directory"
check_exists "$BASE_DIR/temp/logs/test1.log" "file" "test1.log in logs directory"
check_exists "$BASE_DIR/temp/logs/test2.log" "file" "test2.log in logs directory"
check_exists "$BASE_DIR/temp/debug.txt" "file" "debug.txt in temp directory"

# Check that cache.tmp was properly deleted
check_not_exists "$BASE_DIR/temp/cache.tmp" "cache.tmp"

# Check that log files are NOT in temp root (should be in logs/ subdirectory)
if [[ -f "$BASE_DIR/temp/test1.log" ]] || [[ -f "$BASE_DIR/temp/test2.log" ]]; then
    fail "Log files should be in logs/ subdirectory, not temp root"
    echo "   Hint: You should have moved them with: mv *.log logs/"
else
    pass "Log files properly organized in logs/ subdirectory"
fi

echo ""
echo "Checking Exercise 6: Customer Project Setup"
echo "---------------------------------------------"

check_exists "$BASE_DIR/projects/customer-site" "dir" "customer-site directory"
check_exists "$BASE_DIR/projects/customer-site/public_html" "dir" "public_html directory"
check_exists "$BASE_DIR/projects/customer-site/public_html/assets" "dir" "assets directory"
check_exists "$BASE_DIR/projects/customer-site/public_html/assets/css" "dir" "css directory"
check_exists "$BASE_DIR/projects/customer-site/public_html/assets/js" "dir" "js directory"
check_exists "$BASE_DIR/projects/customer-site/logs" "dir" "logs directory"
check_exists "$BASE_DIR/projects/customer-site/config" "dir" "config directory"
check_exists "$BASE_DIR/projects/customer-site/public_html/index.php" "file" "index.php"
check_exists "$BASE_DIR/projects/customer-site/config/database.php" "file" "database.php"

echo ""
echo "========================================="
echo "RESULTS"
echo "========================================="
echo -e "Passed: ${GREEN}$PASSED${RESET}"
echo -e "Failed: ${RED}$FAILED${RESET}"
echo ""

if [[ $FAILED -eq 0 ]]; then
    echo -e "${GREEN}🎉 Congratulations! All exercises completed successfully!${RESET}"
    echo ""
    echo "You've mastered the basics of Linux navigation and file manipulation."
    echo "These skills form the foundation for everything else you'll learn."
    echo ""
    echo "Key skills you've learned:"
    echo "  • Navigate the filesystem with pwd, ls, cd"
    echo "  • Create and organize directories and files"
    echo "  • Copy, move, and safely delete files"
    echo "  • Understand WSL2 filesystem performance"
    echo "  • Follow the safety workflow before destructive commands"
    echo ""
    echo "Next steps:"
    echo "  1. Review any concepts that felt unclear"
    echo "  2. Practice these commands in different scenarios"
    echo "  3. Read: resources/troubleshooting-scenarios/wsl2-common-issues.md"
    echo "  4. Move on to Module 2: DNS Fundamentals (coming soon)"
    echo ""
    echo "Clean up (optional):"
    echo "  rm -rf $BASE_DIR"
    echo ""
    exit 0
else
    echo -e "${YELLOW}⚠️  Some exercises need attention${RESET}"
    echo ""
    echo "Don't worry - this is part of learning!"
    echo ""
    echo "To fix the issues:"
    echo "  1. Review the failed checks above"
    echo "  2. Re-read the relevant exercise instructions in exercises.md"
    echo "  3. Check for typos in file/directory names (case matters!)"
    echo "  4. Verify you're in the correct directory with: pwd"
    echo "  5. Use ls and ls -la to see what you actually created"
    echo ""
    echo "Common mistakes:"
    echo "  • Wrong directory: Make sure you're in ~/cloud86-training"
    echo "  • Typos: Linux is case-sensitive (Test.txt ≠ test.txt)"
    echo "  • Working on /mnt/c/: Move to ~ for better performance"
    echo ""
    echo "Run this script again after making corrections:"
    echo "  bash validate.sh"
    echo ""
    exit 1
fi
