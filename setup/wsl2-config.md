# WSL2 Setup & Configuration Guide

This guide ensures your WSL2 environment is properly configured for web development at Cloud86.io.

## Prerequisites

- Windows 10 version 2004+ or Windows 11
- WSL2 installed
- Ubuntu distribution (recommended) or Debian

## Verify WSL2 Installation

Open PowerShell and check your WSL version:

```powershell
wsl --list --verbose
```

You should see:
```
  NAME      STATE           VERSION
* Ubuntu    Running         2
```

If VERSION shows `1`, upgrade to WSL2:
```powershell
wsl --set-version Ubuntu 2
```

## First-Time Setup

### 1. Update Your System

Open your WSL2 terminal and run:

```bash
sudo apt update
sudo apt upgrade -y
```

### 2. Install Essential Tools

```bash
# Git (for version control)
sudo apt install git -y

# Curl (for downloading files and testing APIs)
sudo apt install curl -y

# Wget (alternative download tool)
sudo apt install wget -y

# Net-tools (for network diagnostics)
sudo apt install net-tools -y

# Build essentials (may be needed for some packages)
sudo apt install build-essential -y
```

### 3. Configure Git (if not done already)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@cloud86.io"
```

## File System Best Practices

### ⚠️ Critical: Where to Store Files

**DO:**
- ✅ Store all project files in the Linux filesystem: `~/projects/`
- ✅ Clone repositories to: `~/projects/`
- ✅ Run development servers from Linux filesystem

**DON'T:**
- ❌ Store projects in `/mnt/c/` (Windows filesystem)
- ❌ Edit Linux files from Windows File Explorer
- ❌ Mix Windows and Linux file systems for the same project

**Why?** WSL2 accessing Windows files is much slower and can cause permission issues.

### Recommended Directory Structure

Create this structure in your home directory:

```bash
mkdir -p ~/projects        # Your development projects
mkdir -p ~/bin            # Personal scripts
mkdir -p ~/backup         # Quick backups
```

Add to your `~/.bashrc` for quick navigation:

```bash
echo 'alias projects="cd ~/projects"' >> ~/.bashrc
source ~/.bashrc
```

Now you can type `projects` to jump to your projects folder!

## WSL2 Networking Quirks

### Localhost Behaves Differently

**Critical concept:** WSL2 is a lightweight Linux VM, not native Linux. This affects networking.

On native Linux, `localhost` always means "this computer." In WSL2:
- `localhost` inside WSL2 → points to the Linux VM
- `localhost` in Windows → points to Windows
- They're **not the same thing**, even though they're on the same laptop!

### How Port Forwarding Works (NAT Mode - Default)

By default, WSL2 uses NAT mode with automatic port forwarding:

**Windows → WSL2 (usually works automatically):**
```bash
# In WSL2, start a web server:
symfony server:start
# Listening on http://127.0.0.1:8000

# Windows browser can access it as:
# http://localhost:8000 ← Auto-forwarded by WSL2
```

**WSL2 → Windows (requires Windows IP):**
```bash
# If Windows is running MySQL on port 3306...

# ❌ This WON'T work from WSL2:
mysql -h localhost -u root

# ✅ This WILL work (use Windows hostname):
mysql -h $(hostname).local -u root

# Or get Windows IP and use that:
# Find it with: ipconfig (in PowerShell)
```

### Mirrored Networking Mode (Optional - Advanced)

Recent WSL2 versions (2.0.0+, Windows 11 23H2+) support "mirrored mode" where `localhost` works in both directions - more like native Linux.

To enable mirrored mode, create `C:\Users\YourName\.wslconfig`:

```ini
[wsl2]
networkingMode=mirrored
```

Then restart WSL:
```powershell
wsl --shutdown
```

**Should you enable this?** 
- ✅ Pro: Simpler localhost behavior
- ❌ Con: Some edge cases and bugs reported
- 🤔 For learning: Start with NAT mode to understand the concepts, enable mirrored later if needed

### Practical Advice for Symfony Development

For Cloud86.io work:

1. **Most of the time, port forwarding "just works"** - run Symfony in WSL2, access from Windows browser
2. **If connecting to Windows services fails**, remember `localhost` doesn't cross the boundary
3. **Production Linux servers work like "WSL2 → Windows"** - they connect to other hosts by IP, not localhost
   
Understanding WSL2's networking helps you think correctly about real server environments!

## Performance Optimization

### 1. Configure .wslconfig (Optional)

Create `C:\Users\YourName\.wslconfig` in Windows:

```ini
[wsl2]
memory=4GB
processors=2
swap=2GB
```

Restart WSL after changes:
```powershell
wsl --shutdown
```

### 2. Exclude WSL from Windows Defender

Add WSL filesystem to Windows Defender exclusions for better performance:

1. Open Windows Security
2. Virus & threat protection > Manage settings
3. Add exclusion: `%LOCALAPPDATA%\Packages\CanonicalGroupLimited.*`

## Terminal Improvements

### Install Windows Terminal (Recommended)

Download from Microsoft Store for a better experience:
- Tabs
- Better fonts
- Color schemes
- Split panes

### Customize Your Prompt (Optional)

Add to `~/.bashrc`:

```bash
# Colorful prompt with directory
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```

Reload:
```bash
source ~/.bashrc
```

## Development Tools for PHP/Symfony

### Install PHP 8.x

```bash
sudo apt update
sudo apt install php8.1 php8.1-cli php8.1-common php8.1-curl php8.1-mbstring php8.1-mysql php8.1-xml -y
```

Verify:
```bash
php -v
```

### Install Composer

```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer --version
```

## Common Issues & Solutions

### Issue: "Permission denied" when creating files

**Solution:** You're probably in `/mnt/c/`. Move to `~/projects/`

```bash
cd ~/projects
```

### Issue: Commands run very slowly

**Solution:** Make sure you're in the Linux filesystem, not `/mnt/c/`

```bash
pwd
# If you see /mnt/c/, you're in Windows filesystem - move your project!
```

### Issue: Script fails with "bad interpreter" or "^M" errors

**Symptom:**
```bash
bash myscript.sh
# /bin/bash^M: bad interpreter: No such file or directory
```

**Cause:** The script has Windows line endings (CRLF) instead of Unix line endings (LF).

**Solution:**
```bash
# Install dos2unix
sudo apt install dos2unix -y

# Convert the file
dos2unix myscript.sh

# OR: Set your editor to use LF line endings
# In VS Code: Bottom right corner → Click "CRLF" → Select "LF"
```

**Prevention:** Configure Git properly in WSL:
```bash
git config --global core.autocrlf false
git config --global core.eol lf
```

**Why it matters:** Production Linux servers expect LF. Scripts with CRLF endings will fail!

### Issue: Can't access WSL2 from Windows browser

**Solution:** Get your WSL2 IP and use that:

```bash
hostname -I
# Use this IP in your browser: http://172.x.x.x:8000
```

Or use `localhost` - WSL2 usually forwards ports automatically.

### Issue: WSL2 uses too much memory

**Solution:** Create `.wslconfig` as shown in Performance Optimization section.

## Useful WSL Commands (from PowerShell)

```powershell
# List distributions
wsl --list --verbose

# Shutdown WSL
wsl --shutdown

# Start specific distribution
wsl -d Ubuntu

# Set default distribution
wsl --set-default Ubuntu

# Update WSL
wsl --update
```

## Testing Your Setup

Run this quick test to verify everything works:

```bash
# Navigate to home
cd ~

# Create test directory
mkdir wsl-test
cd wsl-test

# Create a file
echo "Hello WSL2!" > test.txt

# View it
cat test.txt

# Check PHP
php -v

# Check git
git --version

# Clean up
cd ..
rm -rf wsl-test

# If all commands worked, you're ready!
```

## Next Steps

Now that your WSL2 is configured:

1. Clone the course repository:
   ```bash
   cd ~/projects
   git clone https://github.com/cloud86io/linux-fundamentals-wsl.git
   cd linux-fundamentals-wsl
   ```

2. Start with Module 1:
   ```bash
   cd modules/01-navigation-basics
   cat lesson.md
   ```

## Resources

- [Official WSL Documentation](https://docs.microsoft.com/windows/wsl/)
- [WSL2 Best Practices](https://docs.microsoft.com/windows/wsl/setup/environment)
- [Cloud86.io Internal Wiki](https://outline.cloud86.io) (internal)

---

**Questions?** Ask your team lead or check the troubleshooting scenarios in the course repository.
