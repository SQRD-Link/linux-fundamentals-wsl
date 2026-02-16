# Linux Navigation & File Operations - Quick Reference

## Navigation

| Command | What it does | Example |
|---------|--------------|---------|
| `pwd` | Show current directory | `pwd` |
| `cd <dir>` | Change to directory | `cd /var/www` |
| `cd ..` | Go up one level | `cd ..` |
| `cd ~` | Go to home directory | `cd ~` |
| `cd -` | Go to previous directory | `cd -` |
| `ls` | List files | `ls` |
| `ls -l` | List with details | `ls -l` |
| `ls -a` | List all (including hidden) | `ls -a` |
| `ls -lh` | List with human-readable sizes | `ls -lh` |
| `ls -R` | List recursively | `ls -R` |

## File Operations

| Command | What it does | Example |
|---------|--------------|---------|
| `touch <file>` | Create empty file | `touch index.php` |
| `mkdir <dir>` | Create directory | `mkdir assets` |
| `mkdir -p <path>` | Create nested directories | `mkdir -p src/config/prod` |
| `cp <src> <dest>` | Copy file | `cp file.txt backup.txt` |
| `cp -r <src> <dest>` | Copy directory | `cp -r project/ backup/` |
| `mv <src> <dest>` | Move/rename | `mv old.txt new.txt` |
| `rm <file>` | Remove file | `rm temp.txt` |
| `rm -r <dir>` | Remove directory | `rm -r old-project/` |
| `rm -f <file>` | Force remove | `rm -f locked.txt` |

## Wildcards

| Pattern | Matches | Example |
|---------|---------|---------|
| `*` | Any characters | `*.php` matches all PHP files |
| `?` | Single character | `file?.txt` matches file1.txt, fileA.txt |
| `[abc]` | One of a, b, or c | `file[123].txt` |
| `[!abc]` | Not a, b, or c | `file[!0].txt` |

## Common Combinations

```bash
# List all PHP files with details
ls -lh *.php

# Copy all log files to backup
cp *.log backup/

# Remove all temporary files
rm temp*

# Create project structure in one command
mkdir -p project/{src,config,public}

# See directory tree
ls -R

# Go to directory and list files
cd /var/www && ls -la
```

## Path Types

### Absolute Paths
Start from root (`/`)
```bash
cd /var/www/html
ls /home/user/projects
```

### Relative Paths
Start from current directory
```bash
cd projects/symfony
ls ../php-basics
```

### Special Paths
- `~` = Your home directory (`/home/username`)
- `.` = Current directory
- `..` = Parent directory
- `-` = Previous directory

## Pro Tips

1. **Use Tab completion** - Type first few letters and press Tab
2. **Use arrow keys** - ↑/↓ to cycle through command history
3. **Use `Ctrl+R`** - Search command history
4. **Use `Ctrl+C`** - Cancel current command
5. **Use `clear`** - Clear the terminal screen

## WSL2 Specific

```bash
# Access Windows C: drive
cd /mnt/c/Users/YourName

# Stay in Linux filesystem for better performance
cd ~/projects

# See all mounted drives
ls /mnt/
```

## Safety Checks

Before using dangerous commands:
```bash
# Always check where you are
pwd

# List files before removing
ls -la

# Use rm carefully
rm -i file.txt  # Asks for confirmation
```

## Need More Help?

- `man <command>` - Show manual for command (e.g., `man ls`)
- `<command> --help` - Quick help (e.g., `ls --help`)
- `which <command>` - Show where command is located

---

**Print this and keep it near your desk!**
