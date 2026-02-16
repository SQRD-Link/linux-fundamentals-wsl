# WSL2 Common Issues - Troubleshooting Scenarios

Real-world problems you'll encounter and how to fix them.

## Scenario 1: "Why is Git so slow?"

**Symptoms:**
- `git status` takes 5+ seconds
- `git add .` hangs
- Commits take forever

**Diagnosis:**
```bash
pwd
# Output: /mnt/c/Users/YourName/projects/symfony-app
```

**Root cause:** You're running Git on files in the Windows filesystem (`/mnt/c/`)

**Solution:**
```bash
# Move project to Linux filesystem
cd ~
mkdir projects
mv /mnt/c/Users/YourName/projects/symfony-app ~/projects/
cd ~/projects/symfony-app

# Verify it's fast now
time git status
# Should be instant
```

**Lesson:** Never run development workflows from `/mnt/c/`. Always work in `~/projects/`.

---

## Scenario 2: "Script fails with ^M: bad interpreter"

**Symptoms:**
```bash
./deploy.sh
bash: ./deploy.sh: /bin/bash^M: bad interpreter: No such file or directory
```

**Diagnosis:**
The script has Windows line endings (CRLF) instead of Unix (LF).

**Root cause:** 
- Created/edited the script in Windows (Notepad, some editors)
- Or Git is configured to convert line endings incorrectly

**Solution:**
```bash
# Install dos2unix if not present
sudo apt install dos2unix -y

# Convert the script
dos2unix deploy.sh

# Make it executable
chmod +x deploy.sh

# Run it
./deploy.sh
```

**Prevention:**
```bash
# Configure Git to never convert line endings in WSL
git config --global core.autocrlf false
git config --global core.eol lf

# In VS Code: Click "CRLF" in bottom right → Select "LF"
```

**Why it matters:** Production servers run Linux. Scripts with CRLF won't work there either!

---

## Scenario 3: "Composer install takes forever"

**Symptoms:**
```bash
composer install
# ... 10 minutes later, still running
```

**Diagnosis:**
```bash
pwd
# Output: /mnt/d/projects/symfony-app
```

**Root cause:** Running Composer on Windows filesystem.

**Real measurements:**
- `/mnt/c/`: 8-10 minutes for typical Symfony project
- `~/projects/`: 30-45 seconds for the same project

**Solution:**
```bash
# Move project
cd ~
mkdir -p projects
cp -r /mnt/d/projects/symfony-app ~/projects/
cd ~/projects/symfony-app

# Delete vendor and try again
rm -rf vendor
composer install
# Should be much faster now
```

---

## Scenario 4: "Can't connect to MySQL from WSL2"

**Symptoms:**
```bash
# MySQL is running on Windows
mysql -h localhost -u root -p
# ERROR 2002 (HY000): Can't connect to local MySQL server
```

**Diagnosis:**
In WSL2, `localhost` refers to the Linux VM, not Windows!

**Solutions:**

**Option A: Use Windows hostname**
```bash
# Find Windows hostname
hostname
# Output: DESKTOP-ABC123

# Connect using .local suffix
mysql -h DESKTOP-ABC123.local -u root -p
```

**Option B: Use Windows IP**
```bash
# In PowerShell, find Windows IP:
# ipconfig

# Use that IP from WSL
mysql -h 192.168.1.100 -u root -p
```

**Option C: Make MySQL bind to all interfaces**

In Windows, configure MySQL to listen on `0.0.0.0` instead of `127.0.0.1`.

**The lesson:** WSL2 network is like connecting to another computer - `localhost` doesn't cross the boundary!

---

## Scenario 5: "Symfony server works in WSL but can't access from Windows browser"

**Symptoms:**
```bash
# In WSL2
symfony server:start
# Server listening on http://127.0.0.1:8000

# Windows browser: http://localhost:8000
# Error: "This site can't be reached"
```

**Common causes:**

**1. Server bound to 127.0.0.1 only**

**Solution:** Bind to all interfaces:
```bash
# Instead of:
symfony server:start --bind=127.0.0.1

# Use:
symfony server:start --bind=0.0.0.0
# Or just:
symfony server:start  # Usually defaults to 0.0.0.0
```

**2. Windows Firewall blocking WSL**

**Solution:**
- Check Windows Defender Firewall
- Allow the port through firewall
- Or temporarily disable to test

**3. Corporate VPN or security software**

Some corporate VPNs break WSL port forwarding.

**Workaround:** Find WSL2 IP and use that:
```bash
# In WSL2
hostname -I
# Output: 172.20.123.45

# Access from Windows browser:
# http://172.20.123.45:8000
```

---

## Scenario 6: "Git shows every file as modified (permissions)"

**Symptoms:**
```bash
git status
# Shows all files modified, but you haven't changed them

git diff
# Shows only permission changes: old mode 100644, new mode 100755
```

**Root cause:** 
- Working on a repo in `/mnt/c/` 
- Or mixing Windows Git and WSL Git on the same repo

**Solutions:**

**Solution A: Move to Linux filesystem**
```bash
# Move the repo
mv /mnt/c/projects/myapp ~/projects/
cd ~/projects/myapp

# Reset the permission "changes"
git config core.fileMode false
git reset --hard
```

**Solution B: Configure Git properly (if must stay on /mnt/c/)**
```bash
cd /mnt/c/projects/myapp
git config core.fileMode false
git config core.autocrlf false
```

**Best practice:** 
- Keep repos in `~/projects/`
- Only use Git from inside WSL, never Windows Git
- Configure: `git config --global core.fileMode true` (in WSL)

---

## Scenario 7: "Docker Compose extremely slow"

**Symptoms:**
```bash
docker-compose up
# Takes 2-3 minutes to start
# Application responses are very slow
```

**Diagnosis:**
```bash
cat docker-compose.yml
# volumes:
#   - /mnt/c/projects/app:/var/www/app
```

**Root cause:** Docker bind mount pointing to Windows filesystem.

**Solution:**
```bash
# Move project to Linux filesystem
mv /mnt/c/projects/app ~/projects/
cd ~/projects/app

# Update docker-compose.yml
# Change:
#   - /mnt/c/projects/app:/var/www/app
# To:
#   - ~/projects/app:/var/www/app
# Or:
#   - ./:/var/www/app  (if running from project root)

docker-compose down
docker-compose up
# Should be much faster now
```

**Performance difference:**
- Bind mount from `/mnt/c/`: Symfony request time 800-1500ms
- Bind mount from `~/`: Symfony request time 50-100ms

---

## Quick Diagnostic Checklist

When something is slow or broken in WSL2:

1. **Check location:**
   ```bash
   pwd
   # If you see /mnt/c/ or /mnt/d/ → That's your problem!
   ```

2. **Check line endings (for scripts):**
   ```bash
   file script.sh
   # Should say: "ASCII text" or "UTF-8 Unicode text"
   # NOT: "ASCII text, with CRLF line terminators"
   ```

3. **Check network config (for connectivity):**
   ```bash
   # Are you using localhost incorrectly?
   # Remember: localhost in WSL != localhost in Windows
   ```

4. **Check Git config:**
   ```bash
   git config --list | grep -E "autocrlf|fileMode|eol"
   # Should show:
   # core.autocrlf=false
   # core.eol=lf
   ```

## The Golden Rules (Repeat After Me)

1. **Store code in `~/projects/`, not `/mnt/c/`**
2. **Only use Git from inside WSL for WSL projects**
3. **Scripts need LF line endings, not CRLF**
4. **`localhost` in WSL ≠ `localhost` in Windows**
5. **When in doubt, check `pwd` - are you on `/mnt/`?**

---

**These scenarios are based on real issues Cloud86.io developers have encountered. Learn from them!**
