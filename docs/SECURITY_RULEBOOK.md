# Security Rulebook

Last updated: 2026-02-22

This rulebook defines mandatory security workflow for this dotfiles repository.

## 1. Core Principles

1. Stop the line on security risks.
2. Secrets never belong in tracked files.
3. Track examples and placeholders only.
4. Run security checks before pushing.
5. Treat any leak as a formal incident.

## 2. Non-Negotiable Rules

1. Never commit:
   - tokens, API keys, or private keys
   - machine-specific credentials
   - local secret files (for example `~/.zsh/secrets.zsh`)
2. Keep tracked examples sanitized.
3. Use placeholders in docs/config examples:
   - `CHANGE_ME_*`
   - `${ENV_VAR}`
4. Required local checks before push:
   - `pre-commit run --all-files`
   - `bash -n bootstrap.sh`
   - `bash -n install.sh`
   - `python3 scripts/security_scrub.py --no-history`

## 3. Standard Workflow

### Before coding

- Pull latest `main`.
- Confirm no secret-bearing local files are staged.
- Prefer templates and placeholders for any new configuration examples.

### During coding

- Keep personal credentials in local-only files, not this repo.
- Avoid realistic credentials in README/docs/examples/screenshots.

### Before commit

```bash
git status
pre-commit run --all-files
bash -n bootstrap.sh
bash -n install.sh
python3 scripts/security_scrub.py --no-history
```

### Before push

```bash
pre-commit run --all-files
bash -n bootstrap.sh
bash -n install.sh
python3 scripts/security_scrub.py
```

### After push

- Confirm CI `.github/workflows/ci.yml` passed.
- If any secret finding appears, start incident handling immediately.

## 4. Security Incident Playbook

### Trigger conditions

- Secret/token/key appears in tracked content.
- `security_scrub.py` reports high-severity finding.
- Sensitive machine-local file is committed by mistake.

### Immediate response

1. Freeze pushes/merges on affected branch.
2. Revoke or rotate exposed credentials immediately.
3. Remove leaked content from current branch.
4. Re-run local checks.

### If history is affected

1. Create safety tag:

```bash
git tag pre-history-scrub-$(date +%Y%m%d-%H%M%S)
```

2. Rewrite with `git-filter-repo` using:
   - `--replace-text` for leaked literals
   - `--invert-paths` for files that should never be tracked
3. Verify removal:

```bash
git log --all -S"<leaked-value>" --oneline
git rev-list --all -- <sensitive/path>
```

4. Force-push rewritten refs:

```bash
git push --force origin main
```

5. Notify collaborators to re-clone or hard reset.

### Collaborator recovery

```bash
git fetch origin
git checkout main
git reset --hard origin/main
```

## 5. Documentation Rules

1. Keep `SECURITY.md` and this rulebook aligned.
2. Never include realistic secrets in docs or examples.
3. Replace exposed values with `REDACTED_*` markers.
4. Update docs in the same PR as security-sensitive changes.

## 6. Reference Commands

```bash
# Quick local gate
pre-commit run --all-files
bash -n bootstrap.sh
bash -n install.sh
python3 scripts/security_scrub.py --no-history

# Full scrub including git history
python3 scripts/security_scrub.py
```
