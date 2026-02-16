# Contributing to Linux Fundamentals Course

This course is maintained internally at Cloud86.io. This guide is for team members who want to improve or extend the course.

## Course Philosophy

- **Practical over theoretical** - Real scenarios from our hosting environment
- **Hands-on learning** - Learning by doing, not just reading
- **Self-validating** - Students check their own work with scripts
- **Microlearning** - 10-15 minute chunks
- **Trust-based** - No policing, students take responsibility

## Module Structure

Each module follows this structure:

```
modules/XX-module-name/
├── lesson.md          # Teaching content with examples
├── exercises.md       # Hands-on practice tasks
├── validate.sh        # Bash script to check student work
└── README.md          # (optional) Module overview
```

### lesson.md Guidelines

- Start with "Why This Matters" - real-world context from Cloud86.io
- Use conversational tone (like Jay from Learn Linux TV)
- Include practical examples from hosting environment
- Add WSL2-specific notes where relevant
- Keep formatting minimal - prose over bullet points
- Target reading time: 5-7 minutes

### exercises.md Guidelines

- Progressive difficulty - easy to challenging
- 5-6 exercises per module
- Include hints in collapsible sections (`<details>`)
- Real scenarios from support tickets (anonymized)
- Should take 10-15 minutes total
- Reference validation script at the end

### validate.sh Guidelines

- Use color output (GREEN for pass, RED for fail)
- Check one thing at a time with clear messages
- Provide helpful error messages
- Count passed/failed checks
- End with encouraging message or guidance
- Make executable: `chmod +x validate.sh`

## Adding New Modules

1. Create directory: `modules/XX-module-name/`
2. Add lesson.md with core concepts
3. Create exercises.md with hands-on tasks
4. Write validate.sh to check student work
5. Update main README.md with module status
6. Test everything in actual WSL2

## Module Progression

Current order (scenario-driven):
1. Navigation & File Basics
2. DNS Fundamentals
3. Network Troubleshooting
4. Permissions & Ownership
5. Text Processing & Log Analysis
6. Advanced Scenarios

Each module builds on previous ones.

## Content Standards

### WSL2 Considerations

Always mention when something is different in WSL2:
- File system performance (`/mnt/c/` vs `~/`)
- Networking quirks (localhost forwarding)
- Path conversions Windows ↔ Linux

### Cloud86.io Context

Use our infrastructure as examples:
- cloud86.io domain for DNS examples
- PowerDNS as our DNS server
- Symfony/PHP as our primary stack
- Real (anonymized) support scenarios

### Validation Scripts

Test these aspects:
- Directory structure exists
- Files created with correct names
- Commands executed in correct order
- Cleanup performed properly
- No leftover temporary files

## Writing Style

**DO:**
- Use "you" to address the student
- Be encouraging and supportive
- Explain the "why" not just the "how"
- Use real examples from hosting work
- Keep it conversational

**DON'T:**
- Use corporate jargon
- Over-format with bullets and headers
- Be condescending or assume ignorance
- Create theoretical examples
- Make it feel like a test

## Testing Your Changes

Before committing:

1. **Run through the module yourself** in fresh WSL2
2. **Verify validation script** catches common mistakes
3. **Check timing** - should be 10-15 minutes
4. **Test on Windows** - remember students use WSL2
5. **Review with a colleague** - fresh eyes catch issues

## File Naming Conventions

- Directories: lowercase with hyphens (`network-troubleshooting`)
- Markdown files: lowercase with hyphens (`lesson.md`)
- Scripts: lowercase with hyphens (`validate.sh`)
- Resources: descriptive names (`navigation-basics.md`)

## Resources Directory

Add supporting materials to `/resources/`:
- `cheatsheets/` - Quick reference cards
- `troubleshooting-scenarios/` - Real problem cases
- `sample-logs/` - Example log files for analysis

## Questions or Ideas?

Reach out to Richard or suggest changes via internal wiki.

## Module Development Checklist

When creating a new module:

- [ ] Created directory structure
- [ ] Written lesson.md (5-7 min read)
- [ ] Created exercises.md (5-6 exercises)
- [ ] Built validate.sh (executable, color output)
- [ ] Tested in fresh WSL2 environment
- [ ] Added to main README.md
- [ ] Created cheatsheet in resources/
- [ ] Reviewed by colleague
- [ ] Pushed to GitHub

---

**Remember:** This course represents Cloud86.io's investment in our people. Quality over speed!
