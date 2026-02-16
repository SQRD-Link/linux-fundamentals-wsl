# Module 1: Exercises - Navigation & File Basics

**Estimated time:** 10-15 minutes

## Setup

These exercises will create files and directories in your home directory. Don't worry - the validation script will check everything and you can delete it all when done.

**Important:** Do all exercises in order. The validation script checks the complete setup.

## Exercise 1: Create Your Development Workspace

You're setting up a local development environment. Create the following structure:

```
~/cloud86-training/
├── projects/
│   ├── symfony-demo/
│   │   ├── src/
│   │   ├── public/
│   │   └── config/
│   └── php-basics/
├── backups/
└── temp/
```

**Commands you'll need:**
- `mkdir -p` for nested directories
- `cd` to navigate

**Steps:**
1. Navigate to your home directory
2. Create the main `cloud86-training` folder
3. Create the nested structure shown above

<details>
<summary>💡 Hint (click to reveal)</summary>

```bash
cd ~
mkdir -p cloud86-training/{projects/{symfony-demo/{src,public,config},php-basics},backups,temp}
```

Or step by step:
```bash
cd ~
mkdir cloud86-training
cd cloud86-training
mkdir projects backups temp
cd projects
mkdir symfony-demo php-basics
cd symfony-demo
mkdir src public config
```
</details>

## Exercise 2: Create Project Files

In the `symfony-demo` directory, create these files:
- `public/index.php`
- `public/.htaccess`
- `config/services.yaml`
- `config/routes.yaml`
- `README.md` (in the symfony-demo root)

**Commands you'll need:**
- `touch` to create files
- `cd` to navigate to the right location

**Challenge:** Can you do this with just two `touch` commands?

<details>
<summary>💡 Hint (click to reveal)</summary>

```bash
cd ~/cloud86-training/projects/symfony-demo
touch README.md
touch public/index.php public/.htaccess config/services.yaml config/routes.yaml
```
</details>

## Exercise 3: Practice Listing & Navigation

Run these commands and observe the output. Make sure you understand what each one shows:

```bash
# 1. Where are you?
pwd

# 2. List everything in cloud86-training
ls -la ~/cloud86-training

# 3. List the symfony-demo structure recursively
ls -R ~/cloud86-training/projects/symfony-demo

# 4. Show detailed info about config files
ls -lh ~/cloud86-training/projects/symfony-demo/config
```

**Question to think about:** Why does `ls -la` show more files than `ls`?

<details>
<summary>💡 Answer</summary>

The `-a` flag shows hidden files (those starting with `.`). That's why you see `.htaccess` with `-a` but not without it.
</details>

## Exercise 4: Copy Files for Backup

Create a backup of your config files:

1. Copy all files from `symfony-demo/config/` to `~/cloud86-training/backups/`
2. Rename the copies to include `.backup` before the extension:
   - `services.yaml` → `services.backup.yaml`
   - `routes.yaml` → `routes.backup.yaml`

**Commands you'll need:**
- `cp` to copy files
- `mv` to rename files

<details>
<summary>💡 Hint (click to reveal)</summary>

```bash
cd ~/cloud86-training
cp projects/symfony-demo/config/*.yaml backups/
cd backups
mv services.yaml services.backup.yaml
mv routes.yaml routes.backup.yaml
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
cd ~/cloud86-training/temp
touch test1.log test2.log debug.txt cache.tmp
mkdir logs
mv *.log logs/
rm cache.tmp
ls -la
ls logs/
```
</details>

## Exercise 6: Real-World Scenario - Customer Project Setup

Imagine a customer wants to deploy a PHP application. You need to set up their directory structure.

**Task:** In `~/cloud86-training/projects/`, create a new customer project:

```
customer-site/
├── public_html/
│   ├── index.php
│   └── assets/
│       ├── css/
│       └── js/
├── logs/
└── config/
    └── database.php
```

**Challenge:** Do this with as few commands as possible (aim for 3-4 commands total).

<details>
<summary>💡 Efficient solution</summary>

```bash
cd ~/cloud86-training/projects
mkdir -p customer-site/{public_html/assets/{css,js},logs,config}
cd customer-site
touch public_html/index.php config/database.php
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
2. Now imagine running `composer install` with hundreds of files - what would happen on `/mnt/c/`?
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
- `composer install` on `/mnt/c/`: 5+ minutes
- `composer install` on `~/`: 30 seconds

This isn't academic - it affects your daily productivity!
</details>

## Exercise 8: Hosting Troubleshooting Simulation (BONUS)

This is a realistic scenario you'll face at Cloud86.io. A customer reports their site is broken after deployment.

**Scenario:** A developer deployed a Symfony app but now the site shows a 500 error. You need to investigate the file structure.

**Setup:**
```bash
cd ~/cloud86-training/projects

# Create a "broken" deployment
mkdir -p broken-site/{public,var/cache,var/log,src,config}
cd broken-site

# Create files
touch public/index.php
touch config/services.yaml
touch src/Controller.php

# Simulate a typical deployment structure
ls -R
```

**Investigation tasks:**

1. **Map the structure** - Use `ls -R` to see the entire directory tree
2. **Find the document root** - Where should Apache/Nginx point? (Answer: `public/`)
3. **Identify writable directories** - Which directories need write access? (Answer: `var/cache`, `var/log`)
4. **Check for missing essentials** - Are `vendor/` and `.env` present? (They won't be - note this!)

**Answer these questions:**

<details>
<summary>Q1: If the web server points to `/var/www/broken-site/` instead of `/var/www/broken-site/public/`, what would happen?</summary>

**Problem:** The docroot is pointing to the application root instead of `public/`!

**Result:** 
- Visitors see directory listings or download raw PHP files
- The app won't run because `index.php` is in `public/`, not the root
- Security risk - exposes `.env`, config files, and source code

**Fix in production:**
```bash
# Apache/Nginx should point to:
DocumentRoot /var/www/broken-site/public
# NOT:
DocumentRoot /var/www/broken-site
```

This is one of the most common misconfigurations in hosting!
</details>

<details>
<summary>Q2: What commands help you diagnose the structure quickly?</summary>

```bash
# See the full tree
ls -R

# Or with details (permissions, ownership)
ls -laR

# Check where you are
pwd

# If tree is installed (optional):
tree -L 2
```

**In production:** You'll run `ls -la` in the vhost root to quickly verify structure and spot permission issues.
</details>

<details>
<summary>Q3: Why are `vendor/` and `.env` missing?</summary>

**Answer:** They're not in Git - and for good reasons!

- `vendor/` is created by running `composer install` after deployment (contains dependencies)
- `.env` contains sensitive credentials (database passwords, API keys)
- Both are in `.gitignore` for security

**In production after deployment:**
```bash
# Install dependencies
composer install

# Create production environment file
cp .env.example .env
# Then edit .env with production credentials (database host, passwords, etc.)

# Clear cache
php bin/console cache:clear --env=prod
```

Missing either of these causes 500 errors!
</details>

**The Safety Workflow in Action:**

Before helping this customer, you'd:
```bash
# 1. Where am I?
pwd
# Output: /var/www/broken-site

# 2. What's here?
ls -la

# 3. Check the structure
ls -R

# 4. Now diagnose and fix
# (Check docroot, permissions, missing files)
```

**Clean up:**
```bash
cd ~/cloud86-training
rm -rf projects/broken-site
```

**The lesson:** Understanding file structure lets you diagnose 80% of "site broken" issues in the first 30 seconds. Practice this mental model now - it's invaluable in production support!

## Validation

Once you've completed all exercises, run the validation script:

```bash
cd ~/cloud86-training
bash ../validate.sh
```

Or from the module directory:

```bash
cd ~/linux-fundamentals-wsl/modules/01-navigation-basics
bash validate.sh
```

## Clean Up (After Validation)

Once you've successfully validated your work, you can remove the training directory:

```bash
rm -rf ~/cloud86-training
```

**⚠️ Warning:** Make sure validation passed before deleting! The validation script checks all your work.

## Reflection Questions

After completing these exercises, ask yourself:

1. When would you use absolute paths vs relative paths?
2. Why is `mkdir -p` safer than just `mkdir` for nested directories?
3. What's the difference between `cp` and `mv`?
4. Why should you be extra careful with `rm -rf`?

## What's Next?

Module 2 will teach you DNS fundamentals - understanding how domain names resolve to IP addresses, which is critical when troubleshooting customer hosting issues.

**Preview question:** Do you know what happens when someone types `cloud86.io` in their browser? We'll trace that entire journey in the next module!

---

**Stuck?** Review the lesson.md file or ask a colleague. These are foundational skills - it's worth taking time to understand them properly.
