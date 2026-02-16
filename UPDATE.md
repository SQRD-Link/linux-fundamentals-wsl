# Updating Your Course Repository

## For Students Who Already Started

If you cloned the course before **February 16, 2026**, follow these steps to get the latest updates.

---

## 🔄 Quick Update (Recommended)

### Step 1: Update your course files

```bash
# Navigate to your course directory
cd ~/linux-fundamentals-wsl

# Pull the latest changes
git pull origin main
```

**That's it!** Your course materials are now updated.

---

## 📂 What Changed?

### Module 1 Updates (February 2026)

The course is now **generic** and works for all developers:

**Old approach:**
- `~/cloud86-training/` directory
- Symfony-specific examples
- Hosting company focus

**New approach:**
- `~/linux-practice/` directory
- Generic `project-cloud86` examples
- Universal developer skills

---

## 🤔 What About My Old Work?

### Option 1: Keep Your Old Work (Recommended)

**Your existing practice directory is fine!** 

If you already created `~/cloud86-training/` with Symfony examples:
- ✅ You can keep working with it
- ✅ Your learning is still valid
- ✅ The concepts are the same

**However:** The validation script now expects `~/linux-practice/` with generic file names.

### Option 2: Start Fresh with New Structure

**If you want to align with the new course:**

```bash
# 1. Backup your old work (optional)
mv ~/cloud86-training ~/cloud86-training-backup

# 2. Start Module 1 fresh with new structure
cd ~/linux-fundamentals-wsl/modules/01-navigation-basics
cat exercises.md

# 3. Create the new structure
mkdir -p ~/linux-practice
# ... follow the updated exercises
```

### Option 3: Migrate Your Work

**If you want to convert your existing work:**

```bash
# Rename the main directory
mv ~/cloud86-training ~/linux-practice

# Rename project directories
cd ~/linux-practice/projects
mv symfony-demo project-cloud86
mv customer-site web-app  # If you completed Exercise 6

# You'll need to recreate some files with new names
# See exercises.md for the new structure
```

**Note:** This requires manual file renaming and isn't necessary unless you want to validate with the new script.

---

## ✅ Validation Script Changes

The validation script now checks for:

**Old structure:**
```
~/cloud86-training/
└── projects/
    ├── symfony-demo/
    │   ├── public/index.php
    │   └── config/services.yaml
    └── customer-site/
```

**New structure:**
```
~/linux-practice/
└── projects/
    ├── project-cloud86/
    │   ├── src/app.py  (or .js, .go, etc.)
    │   └── config/app.config
    └── web-app/
```

---

## 🎯 My Recommendation

### If you haven't finished Module 1 yet:
→ **Start fresh with the new structure** (`~/linux-practice/`)

### If you already completed Module 1:
→ **Keep your old work** and move on to Module 2 when it's ready

### If you want everything aligned:
→ **Start fresh** - Module 1 only takes 10-15 minutes

---

## 📝 Key Differences

| Aspect | Old Version | New Version |
|--------|-------------|-------------|
| **Main directory** | `~/cloud86-training/` | `~/linux-practice/` |
| **Project name** | `symfony-demo/` | `project-cloud86/` |
| **Source files** | `public/index.php` | `src/app.py` (or .js, .go) |
| **Config files** | `config/services.yaml` | `config/app.config` |
| **Focus** | Symfony/hosting | Generic development |
| **Customer project** | `customer-site/` | `web-app/` |

---

## 🆘 Help! I'm Confused

**Simple decision tree:**

1. **Did you finish Module 1 and validation passed?**
   - Yes → Keep your work, no need to change anything
   - No → Start fresh with new structure

2. **Do you care about running the validation script?**
   - Yes → Use the new structure (`~/linux-practice/`)
   - No → Your old structure is fine for learning

3. **Still unsure?**
   - **Just start fresh** - it only takes 10-15 minutes and reinforces the concepts!

---

## 🔍 How to Check Which Version You Have

```bash
# Check if you have the old structure
ls ~/cloud86-training 2>/dev/null && echo "Old structure" || echo "Not found"

# Check if you have the new structure
ls ~/linux-practice 2>/dev/null && echo "New structure" || echo "Not found"

# Check which commit you're on
cd ~/linux-fundamentals-wsl
git log --oneline -1
# If you see commits from Feb 16, 2026 or later → you have the new version
```

---

## 💡 Pro Tip

The concepts in Module 1 are the same regardless of structure:
- Navigation (pwd, ls, cd)
- File operations (mkdir, touch, cp, mv, rm)
- WSL2 performance tips
- Safety workflow

**The skills transfer 100%** - only the example names changed!

---

## 🚀 After Updating

1. ✅ Your course files are updated
2. ✅ You can continue learning
3. ✅ New modules will use the generic approach
4. ✅ Future updates are easy: just `git pull`

---

**Questions?** Reach out to Richard for help.

**Last updated:** February 16, 2026