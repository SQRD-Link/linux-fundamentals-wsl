# Module 1: Exercises - Navigation & File Basics

**Estimated time:** 10-15 minutes

## Setup

These exercises will create files and directories in your home directory. Don't worry - the validation script will check everything and you can delete it all when done.

**Important:** Do all exercises in order. The validation script checks the complete setup.

## Exercise 1: Create Your Development Workspace

You're setting up a local development environment. Create the following structure:

```
~/linux-practice/
├── projects/
│   ├── project-cloud86/
│   │   ├── src/
│   │   ├── tests/
│   │   └── config/
│   └── demo-app/
├── backups/
└── temp/
```

**Commands you'll need:**
- `mkdir -p` for nested directories
- `cd` to navigate

**Steps:**
1. Navigate to your home directory
2. Create the main `linux-practice` folder
3. Create the nested structure shown above

<details>
<summary>💡 Hint (click to reveal)</summary>

```bash
cd ~
mkdir -p linux-practice/{projects/{project-cloud86/{src,tests,config},demo-app},backups,temp}
```

Or step by step:
```bash
cd ~
mkdir linux-practice
cd linux-practice
mkdir projects backups temp
cd projects
mkdir project-cloud86 demo-app
cd project-cloud86
mkdir src tests config
```
</details>

## Exercise 2: Create Project Files

In the `project-cloud86` directory, create these files:
- `README.md` (in the project-cloud86 root)
- `src/app.py` (or app.js, main.go - your choice!)
- `config/app.config`
- `config/database.config`
- `.gitignore`

**Commands you'll need:**
- `touch` to create files
- `cd` to navigate to the right location

**Challenge:** Can you do this with just two `touch` commands?

<details>
<summary>💡 Hint (click to reveal)</summary>

```bash
cd ~/linux-practice/projects/project-cloud86
touch README.md .gitignore
touch src/app.py config/app.config config/database.config
```
</details>

## Exercise 3: Practice Listing & Navigation

Run these commands and observe the output. Make sure you understand what each one shows:

```bash
# 1. Where are you?
pwd

# 2. List everything in linux-practice
ls -la ~/linux-practice

# 3. List the project-cloud86 structure recursively
ls -R ~/linux-practice/projects/project-cloud86

# 4. Show detailed info about config files
ls -lh ~/linux-practice/projects/project-cloud86/config
```

**Question to think about:** Why does `ls -la` show more files than `ls`?

<details>
<summary>💡 Answer</summary>

The `-a` flag shows hidden files (those starting with `.`). That's why you see `.gitignore` with `-a` but not without it.
</details>

## Exercise 4: Copy Files for Backup

Create a backup of your config files:

1. Copy all files from `project-cloud86/config/` to `~/linux-practice/backups/`
2. Rename the copies to include `.backup` before the extension:
   - `app.config` → `app.backup.config`
   - `database.config` → `database.backup.config`

**Commands you'll need:**
- `cp` to copy files
- `mv` to rename files

<details>
<summary>💡 Hint (click to reveal)</summary>

```bash
cd ~/linux-practice
cp projects/project-cloud86/config/*.config backups/
cd backups
mv app.config app.backup.config
mv database.config database.backup.config
```
</details>

## Exercise 5: Organize and Clean Up

Let's simulate a real scenario: You've been testing and created some temporary files. Clean them up properly.

**Tasks:**

1. Create these test files in the `temp` directory:
   ```bash
   test1.log
   test2.log
   debug.txt
   cache.tmp
   ```

2. Move all `.log` files to a new `temp/logs/` subdirectory

3. Delete the `.tmp` file (we don't need cache files)

4. Verify your temp directory now has:
   - `logs/` directory containing the .log files
   - `debug.txt` file

**Commands you'll need:**
- `mkdir` to create the logs directory
- `mv` with wildcards to move .log files
- `rm` to remove the .tmp file
- `ls` to verify

<details>
<summary>💡 Hint (click to reveal)</summary>

```bash
cd ~/linux-practice/temp
touch test1.log test2.log debug.txt cache.tmp
mkdir logs
mv *.log logs/
rm cache.tmp
ls -la
ls logs/
```
</details>

## Exercise 6: Real-World Scenario - New Project Setup

You're starting a new web application project. Set up a professional directory structure.

**Task:** In `~/linux-practice/projects/`, create a new project:

```
web-app/
├── public/
│   ├── index.html
│   └── assets/
│       ├── css/
│       └── js/
├── src/
└── config/
    └── app.config
```

**Challenge:** Do this with as few commands as possible (aim for 3-4 commands total).

<details>
<summary>💡 Efficient solution</summary>

```bash
cd ~/linux-practice/projects
mkdir -p web-app/{public/assets/{css,js},src,config}
cd web-app
touch public/index.html config/app.config
```
</details>

## Exercise 7: Understanding WSL2 Performance (IMPORTANT!)

This exercise demonstrates why file location matters in WSL2.

**Task:** Compare file operation speeds between Linux filesystem and Windows filesystem.

**Part A: Create a test in Linux filesystem**
```bash
cd ~
mkdir perf-test-linux
cd perf-test-linux

# Time creating 1000 files in Linux filesystem
time for i in {1..1000}; do touch file$i.txt; done
```

**Part B: Create the same test in Windows filesystem**
```bash
cd /mnt/c/Users/YourName/  # Adjust to your Windows username
mkdir perf-test-windows
cd perf-test-windows

# Time creating 1000 files in Windows filesystem
time for i in {1..1000}; do touch file$i.txt; done
```

**Part C: Compare the results**

Look at the "real" time output from both commands.

**Questions to answer:**
1. Which was faster? By how much?
2. Now imagine running package installs with hundreds of files - what would happen on `/mnt/c/`?
3. What's the lesson for your daily work?

**Clean up:**
```bash
rm -rf ~/perf-test-linux
rm -rf /mnt/c/Users/YourName/perf-test-windows
```

<details>
<summary>💡 What you should see</summary>

The Linux filesystem (`~/perf-test-linux`) should be **significantly faster** - often 5-10x or more.

**The lesson:** Always work in `~/projects/` for active development. Only use `/mnt/c/` for occasional file transfers.

**Real-world impact:** 
- `git status` on `/mnt/c/`: 5 seconds
- `git status` on `~/`: instant
- Package installs on `/mnt/c/`: 5+ minutes
- Package installs on `~/`: 30 seconds

This isn't academic - it affects your daily productivity!
</details>

## Validation

Once you've completed all exercises (1-7), run the validation script:

```bash
cd ~/linux-practice
bash ~/linux-fundamentals-wsl/modules/01-navigation-basics/validate.sh
```

Or from the module directory:

```bash
cd ~/linux-fundamentals-wsl/modules/01-navigation-basics
bash validate.sh
```

## Clean Up (After Validation)

Once you've successfully validated your work, you can remove the training directory:

```bash
rm -rf ~/linux-practice
```

**⚠️ Warning:** Make sure validation passed before deleting! The validation script checks all your work.

## Reflection Questions

After completing these exercises, ask yourself:

1. When would you use absolute paths vs relative paths?
2. Why is `mkdir -p` safer than just `mkdir` for nested directories?
3. What's the difference between `cp` and `mv`?
4. Why should you be extra careful with `rm -rf`?
5. Why does file location matter so much in WSL2?

## What's Next?

Module 2 will teach you Permissions & Ownership - understanding who can read, write, and execute files, which is critical for any development or system administration work.

---

**Stuck?** Review the lesson.md file or ask a colleague. These are foundational skills - it's worth taking time to understand them properly.