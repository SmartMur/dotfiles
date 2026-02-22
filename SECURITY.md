# Security Policy

## Supported Versions

Security fixes target the latest state of `main`.

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
5. Force-push only with explicit maintainer approval.

## Baseline Security Checks

- `scripts/security_scrub.py`
- CI workflow: `.github/workflows/ci.yml`
