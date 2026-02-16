# Module 1: Navigation & File Basics

**Time:** 10-15 minutes  
**Goal:** Get comfortable navigating and manipulating files in Linux

## Why This Matters

As a developer, you'll spend a lot of time:
- Navigating through project codebases
- Creating and organizing project files
- Moving files between directories
- Cleaning up temporary files

This isn't theoretical - these are skills you'll use daily.

## The Linux Filesystem

Unlike Windows (C:\, D:\, etc.), Linux has a single tree structure starting from `/` (root).

```
/
├── home/           # User home directories
│   └── yourusername/
├── var/            # Variable data (logs, cache)
│   ├── log/
│   └── www/
├── etc/            # Configuration files
├── tmp/            # Temporary files
└── usr/            # User programs
```

**WSL2 Note:** Your Windows drives are mounted at `/mnt/c/`, `/mnt/d/`, etc.

## Essential Navigation Commands

### pwd - Print Working Directory
Shows where you currently are.

```bash
pwd
# Output: /home/yourusername
```

**When to use:** When you're lost or confirming you're in the right place.

### ls - List Files
Shows files and directories in your current location.

```bash
ls                  # Basic list
ls -l               # Detailed list (permissions, size, date)
ls -la              # Include hidden files (starting with .)
ls -lh              # Human-readable file sizes
```

**Real-world example:**
```bash
ls -lh ~/projects/my-app/src
# See all source files with readable sizes
```

### cd - Change Directory
Navigate to different directories.

```bash
cd /var/www         # Go to absolute path
cd my-project       # Go to subdirectory (relative path)
cd ..               # Go up one level
cd ~                # Go to your home directory
cd -                # Go back to previous directory
```

**Pro tip:** Use `Tab` to autocomplete directory names!

## File Manipulation Commands

### mkdir - Make Directory
Create new directories.

```bash
mkdir project-name              # Create single directory
mkdir -p project/src/config     # Create nested directories
```

**The `-p` flag:** Creates parent directories if they don't exist. Essential!

### touch - Create Empty File
Create a new empty file or update timestamp of existing file.

```bash
touch README.md
touch config.json database.sql   # Create multiple files
```

### cp - Copy Files/Directories
Copy files or directories to a new location.

```bash
cp file.txt backup.txt                    # Copy file
cp file.txt /tmp/                         # Copy to directory
cp -r project-folder/ backup-folder/      # Copy directory recursively
```

**The `-r` flag:** Required for copying directories (recursive copy).

### mv - Move/Rename Files
Move files or rename them.

```bash
mv oldname.txt newname.txt              # Rename file
mv file.txt ~/projects/                 # Move file
mv *.log logs/archive/                  # Move all .log files
```

**Gotcha:** `mv` doesn't need `-r` for directories - it just moves them.

### rm - Remove Files
Delete files or directories.

```bash
rm file.txt                     # Remove file
rm -r directory/                # Remove directory and contents
rm -f file.txt                  # Force remove (no confirmation)
```

**⚠️ WARNING:** There's no recycle bin in Linux. `rm` is permanent!

**Never run:** `rm -rf /` (deletes everything - system killer)

### Safer Deletion Habits

**Use interactive mode when learning:**
```bash
# -i flag prompts before each deletion
rm -i file.txt
# remove file.txt? y

# Great for beginners!
alias rm='rm -i'  # Add to ~/.bashrc
```

**Always verify before deleting:**
```bash
# 1. Check what will be deleted
ls *.log

# 2. (Optional) Test with echo
echo rm *.log

# 3. Only then delete
rm *.log
```

**"Soft delete" pattern for practice:**
```bash
# Instead of rm, move to a trash folder
mkdir -p ~/.trash
mv oldfile.txt ~/.trash/

# You can recover it later if needed
# Empty trash manually when sure: rm -rf ~/.trash/*
```

> **💼 Hosting Context:**  
> In production environments, running `rm -rf *` in the wrong directory could delete an entire customer website or wipe all sites on a shared server. A support engineer once ran `rm -rf *` thinking they were in `/var/www/site123/var/cache` but were actually in `/var/www/` - deleting ALL customer sites! This is why the safety workflow is critical.

## Wildcards & Patterns

Use wildcards to work with multiple files:

```bash
*.py            # All files ending in .py
test*           # All files starting with test
file?.txt       # file1.txt, fileA.txt (single character)
```

**Examples:**
```bash
ls *.log                        # List all log files
cp *.js backup/                 # Copy all JavaScript files
rm temp*.txt                    # Remove all temp text files
```

## Practical Workflow Example

Let's say you're setting up a new project:

```bash
# 1. Navigate to your projects folder (always use Linux filesystem!)
cd ~/projects

# 2. Create project structure
mkdir -p project-cloud86/{src,tests,docs,config,scripts}

# 3. Navigate into it
cd project-cloud86

# 4. Check the structure you created
ls -la

# 5. Create some essential files
touch README.md
touch src/app.py              # Or app.js, main.go, etc.
touch config/app.config
touch .gitignore

# 6. Verify everything is there
ls -R
```

**Typical project structure:**
```
project-cloud86/
├── src/                       ← Application code
├── tests/                     ← Test files
├── docs/                      ← Documentation
├── config/                    ← Configuration files
├── scripts/                   ← Helper scripts
├── README.md                  ← Project description
└── .gitignore                 ← Git ignore rules
```

> **💼 Hosting Context:**  
> In production, this structure might live at `/var/www/project-cloud86/`.  
> A web server would have a "document root" pointing to a `public/` directory.  
> We'll learn more about web-specific structures in Module 8.

## The Safety Workflow (Learn This Now!)

Before running ANY destructive command (`rm`, `mv`, or commands with wildcards), follow this workflow:

```bash
# 1. Where am I?
pwd

# 2. What's here?
ls -la

# 3. (Optional) Do a dry run or test first
echo rm *.log          # Shows what would be deleted
# ls *.log             # Shows which files match the pattern

# 4. NOW run the actual command
rm *.log
```

**Why this matters:**

In ANY environment (development, staging, production), running destructive commands in the wrong directory has consequences:
- Development: Lost hours of work
- Staging: Broken deployment pipelines
- Production: Customer data loss, downtime, angry calls

**Make it a habit NOW in WSL2** - it will save you later.

## Common Mistakes to Avoid

1. **Forgetting `-r` when copying directories**
   ```bash
   cp my-folder backup/  # ❌ Error
   cp -r my-folder backup/  # ✅ Correct
   ```

2. **Using `rm -rf` carelessly**
   ```bash
   rm -rf *  # ⚠️ Dangerous! Make sure you're in the right directory
   ```

3. **Confusing absolute vs relative paths**
   ```bash
   cd /var/www         # Absolute (starts with /)
   cd var/www          # Relative (from current directory)
   ```

4. **Working in `/mnt/c/` instead of `~/` (WSL2-specific)**
   ```bash
   pwd
   # If you see /mnt/c/Users/... - STOP! Move to ~/projects/
   # This is the #1 performance killer in WSL2
   ```

5. **Mixing Windows and Linux Git**
   ```bash
   # ❌ BAD: Using Windows Git on Linux files
   # This causes line-ending chaos and permission issues
   
   # ✅ GOOD: Only use Git from inside WSL for WSL projects
   git config --global core.autocrlf false  # Set this in WSL
   ```

6. **Creating shell scripts with Windows tools**
   ```bash
   # If you edit a .sh file in Windows Notepad and try to run it in WSL:
   bash script.sh
   # Error: /bin/bash^M: bad interpreter
   
   # Fix it by converting line endings:
   dos2unix script.sh
   # OR set your editor to use LF (Unix) line endings
   ```
   
   **Why it matters:** Linux servers expect LF line endings, not Windows CRLF. Get in the habit now!

## WSL2 Specific Tips

### Critical: File System Performance

**⚠️ This is probably the most important thing to understand about WSL2:**

WSL2 stores Linux files in a virtual disk (ext4.vhdx) that's optimized for Linux operations. When you work with files in `/home/` or `/var/`, performance is nearly identical to native Linux.

When you access Windows files through `/mnt/c/`, operations go through both Linux AND Windows file system layers, causing **massive slowdowns** - especially for:
- `git status` and `git` operations
- Package installations (`npm install`, `pip install`, etc.)
- Build operations
- Docker bind mounts

**Real-world impact:** A package install that takes 30 seconds in `~/projects/` might take 5+ minutes in `/mnt/c/`.

### The Golden Rule

**DO:**
- ✅ Clone all projects to `~/projects/` (Linux filesystem)
- ✅ Run development servers from `~/projects/`
- ✅ Use VS Code Remote-WSL extension to edit files in place

**DON'T:**
- ❌ Store active projects in `/mnt/c/Users/YourName/`
- ❌ Run package managers or git commands on `/mnt/c/` files
- ❌ Use Windows Git on WSL projects (only use Git inside WSL)

### When You Need Windows Files

Access Windows files for one-off tasks only:

```bash
# Copy a file FROM Windows TO Linux (good)
cp /mnt/c/Users/YourName/Downloads/data.csv ~/projects/my-app/

# Work on the file in Linux filesystem (fast)
cd ~/projects/my-app
```

**Think of it this way:** WSL2 is like a separate Linux server on your laptop. You wouldn't run your development projects over a network share from another computer - same principle applies here.

### Set Up Your Workspace

```bash
# Create your projects folder (do this once)
mkdir ~/projects
cd ~/projects

# Add a quick shortcut to your shell
echo 'alias projects="cd ~/projects"' >> ~/.bashrc
source ~/.bashrc

# Now you can always type: projects
```

### Understanding WSL2's Network Model (Quick Intro)

WSL2 runs as a lightweight VM with its own IP address. This means:

**Key point:** `localhost` in WSL2 refers to the Linux VM, not Windows.

```bash
# When you run a web server in WSL2:
python -m http.server 8000
# Or: npm run dev

# Windows USUALLY auto-forwards the port, so your Windows browser can access:
# http://localhost:8000 ← This works most of the time
```

**The tricky part:** If you need WSL2 to connect to something running on Windows (like a database), you can't use `localhost` - you'd need the Windows IP address.

**For now:** Don't worry about this too much. We'll cover networking in Module 6. Just know that if `localhost` behaves weirdly, this is why.

## Quick Reference

| Command | Purpose | Example |
|---------|---------|---------|
| `pwd` | Show current directory | `pwd` |
| `ls` | List files | `ls -lah` |
| `cd` | Change directory | `cd ~/projects` |
| `mkdir` | Create directory | `mkdir -p path/to/dir` |
| `touch` | Create file | `touch file.txt` |
| `cp` | Copy | `cp -r source dest` |
| `mv` | Move/rename | `mv old new` |
| `rm` | Remove | `rm -r directory` |

## Next Steps

Ready to practice? Open `exercises.md` in this directory to work through hands-on scenarios.

```bash
cat exercises.md
```

Once you complete the exercises, validate your work:

```bash
bash validate.sh
```

---

**Pro tip:** Keep this lesson open in one terminal tab and practice in another!