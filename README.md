# Linux Fundamentals - WSL2 Edition

A practical Linux course designed for developers working in WSL2 on Windows. Learn essential Linux skills through real-world scenarios.

## 🎯 Course Overview

This course teaches essential Linux skills through hands-on practice and realistic scenarios. You'll learn by doing - working with files, understanding systems, and building practical skills that apply to any development environment.

**Target audience:** Software developers new to Linux, working in WSL2 on Windows.

**Time commitment:** 10-15 minutes per module.

## 📋 Prerequisites

- Windows 10/11 with WSL2 installed
- Basic terminal familiarity (you know what a command prompt is)
- A desire to learn Linux fundamentals

## 🚀 Getting Started

### 1. Clone this repository in WSL2

```bash
# Open your WSL2 terminal
git clone https://github.com/SQRD-Link/linux-fundamentals-wsl.git
cd linux-fundamentals-wsl
```

### 2. Verify your setup

```bash
# Check you're in WSL2
uname -a
# Should show Linux kernel version

# Check you have bash
bash --version
```

### 3. Start with Module 1

```bash
cd modules/01-navigation-basics
cat lesson.md
```

## 📚 Course Structure

Each module follows the same structure:
- **lesson.md** - Concepts and commands explained
- **exercises.md** - Hands-on practice scenarios
- **validate.sh** - Self-checking script to verify your work

### 🎓 Core Curriculum (Essential for all developers)

#### Module 1: Navigation & File Basics
**Status:** ✅ Available  
**Time:** 10-15 minutes  
Get comfortable navigating the Linux filesystem and manipulating files. Master the basics: pwd, ls, cd, mkdir, cp, mv, rm.

#### Module 2: Permissions & Ownership
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Understand file permissions and ownership. Learn chmod, chown, and how to prevent permission issues.

#### Module 3: Finding Things
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Locate files and search content efficiently using find, grep, and locate.

#### Module 4: Text Processing & Log Analysis
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Parse logs, find patterns, and extract insights from text files using cat, grep, sed, and awk.

---

### 🔧 Extra Curriculum (Specialized topics)

#### Module 5: DNS Fundamentals
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Understand how DNS works - useful for web hosting and network troubleshooting.

#### Module 6: Network Troubleshooting
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Debug connectivity issues using curl, ping, and other network tools.

#### Module 7: Git Essentials
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Master version control basics: clone, add, commit, push, pull, and branches.

#### Module 8: Web Application Projects
**Status:** 🚧 Coming Soon  
**Time:** 15-20 minutes  
Understand web application structure, document roots, and deployment concepts. Includes framework-specific sections (Symfony, Laravel, Node.js).

#### Module 9: Advanced Scenarios
**Status:** 🚧 Coming Soon  
**Time:** 15-20 minutes  
Combine everything you've learned to solve complex real-world problems.

## 🎓 Learning Philosophy

This isn't a certification course - it's practical knowledge for daily development work:

- **Real scenarios:** Based on actual development and troubleshooting needs
- **Self-paced:** Work at your own speed, validate your own progress
- **Hands-on:** Learning by doing, not just reading
- **Trust-based:** We expect you to take responsibility for your learning
- **Generic first:** Core modules teach universal skills; specialized topics come later

## 🆘 Getting Help

- Check the `/resources/cheatsheets/` directory for quick references
- Review `/resources/troubleshooting-scenarios/` for common WSL2 issues and solutions
- Practice makes perfect - repeat exercises until they feel natural

**Highly recommended:** Read `/resources/troubleshooting-scenarios/wsl2-common-issues.md` - it covers the mistakes everyone makes when starting with WSL2.

## 🔄 Course Updates

New modules are released progressively. Check back regularly for updates.

**Last updated:** February 2026

---

**Questions or feedback?** Reach out to Richard for improvements or corrections.