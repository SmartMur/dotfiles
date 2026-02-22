# Contributing

Thanks for improving these dotfiles.

## Local Setup

```bash
git clone https://github.com/SmartMur/dotfiles.git
cd dotfiles
./install.sh --skip-brew
```

Install local hooks once:

```bash
brew install pre-commit
pre-commit install
```

## Required Checks Before PR

```bash
bash -n bootstrap.sh
bash -n install.sh
pre-commit run --all-files
python3 scripts/security_scrub.py --no-history
```

For security-sensitive changes, also review `docs/SECURITY_RULEBOOK.md`.

If you changed `Brewfile`, also verify:

```bash
brew bundle check --file Brewfile || true
```

## Contribution Rules

- Keep changes focused and reversible.
- Do not commit secrets, tokens, private keys, or machine-specific credentials.
- Preserve backup-safe behavior in `install.sh`.
- Document user-facing changes in `README.md` and `CHANGELOG.md`.
- Follow `docs/SECURITY_RULEBOOK.md` incident flow if any leakage is detected.

## PR Checklist

- What changed and why
- How it was tested
- Risk notes (if any)
