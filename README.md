# Linux Fundamentals for Web Hosting - WSL2 Edition

A practical Linux course designed for Cloud86.io developers working with Symfony/PHP in a web hosting environment.

## 🎯 Course Overview

This course teaches essential Linux skills through real-world scenarios you'll encounter as a developer at a web hosting company. You'll learn by doing - investigating actual infrastructure, debugging realistic problems, and building practical skills.

**Target audience:** Software developers new to Linux, working in WSL2 on Windows.

**Time commitment:** 10-15 minutes per module, 6 modules total.

## 📋 Prerequisites

- Windows 10/11 with WSL2 installed
- Basic terminal familiarity (you know what a command prompt is)
- A desire to understand how web hosting infrastructure actually works

## 🚀 Getting Started

### 1. Clone this repository in WSL2

```bash
# Open your WSL2 terminal
git clone https://github.com/cloud86io/linux-fundamentals-wsl.git
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

## 📚 Course Modules

Each module follows the same structure:
- **lesson.md** - Concepts and commands explained
- **exercises.md** - Hands-on practice scenarios
- **validate.sh** - Self-checking script to verify your work

### Module 1: Navigation & File Basics
**Status:** ✅ Available  
**Time:** 10-15 minutes  
Get comfortable navigating the Linux filesystem and manipulating files.

### Module 2: DNS Fundamentals
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Understand how DNS works in a hosting environment - critical for troubleshooting customer issues.

### Module 3: Network Troubleshooting
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Debug connectivity issues like a pro using curl, ping, and other network tools.

### Module 4: Permissions & Ownership
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Master Linux permissions - prevent those "403 Forbidden" nightmares.

### Module 5: Text Processing & Log Analysis
**Status:** 🚧 Coming Soon  
**Time:** 10-15 minutes  
Parse logs, find patterns, and extract insights from text files.

### Module 6: Advanced Scenarios
**Status:** 🚧 Coming Soon  
**Time:** 15-20 minutes  
Combine everything you've learned to solve complex real-world problems.

## 🎓 Learning Philosophy

This isn't a certification course - it's practical knowledge for your daily work at Cloud86.io:

- **Real scenarios:** Based on actual support tickets and infrastructure
- **Self-paced:** Work at your own speed, validate your own progress
- **Hands-on:** Learning by doing, not just reading
- **Trust-based:** We expect you to take responsibility for your learning

## 🆘 Getting Help

- Check the `/resources/cheatsheets/` directory for quick references
- Review `/resources/troubleshooting-scenarios/` for common WSL2 issues and solutions
- Ask your team - we've all been there!

**Highly recommended:** Read `/resources/troubleshooting-scenarios/wsl2-common-issues.md` - it covers the mistakes everyone makes when starting with WSL2.

## 🔄 Course Updates

New modules are released progressively. Check back regularly for updates.

**Last updated:** February 2026

---

**Questions or feedback?** This course is maintained internally at Cloud86.io. Reach out to Richard for improvements or corrections.
