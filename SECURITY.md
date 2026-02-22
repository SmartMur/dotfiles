# Security Policy

## Supported Versions

Security fixes target the latest state of `main`.

## Rulebook

The authoritative operating rules and incident playbook live in:

- `docs/SECURITY_RULEBOOK.md`

All contributors are expected to follow that document for day-to-day security workflow and incident handling.

## Reporting Security Issues

Do not open public issues for sensitive vulnerabilities.

Use:
- GitHub Security Advisory (preferred)
- Maintainer private contact

Include:
- What is affected
- Reproduction details
- Impact severity

## Secret Leakage Response

If a secret is exposed:

1. Revoke/rotate immediately.
2. Remove secret from current branch.
3. Rewrite history if needed.
4. Re-run:
   - `python3 scripts/security_scrub.py`
   - `bash -n bootstrap.sh`
   - `bash -n install.sh`
5. Force-push only with explicit maintainer approval.

Use `docs/SECURITY_RULEBOOK.md` for command-level incident steps.

## Baseline Security Checks

- `scripts/security_scrub.py`
- `bash -n bootstrap.sh`
- `bash -n install.sh`
- CI workflow: `.github/workflows/ci.yml`
