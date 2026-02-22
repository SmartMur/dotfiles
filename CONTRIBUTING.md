# Contributing

Thanks for improving these dotfiles.

## Local Setup

```bash
git clone https://github.com/SmartMur/dotfiles.git
cd dotfiles
./install.sh --skip-brew
```

## Required Checks Before PR

```bash
bash -n bootstrap.sh
bash -n install.sh
python3 scripts/security_scrub.py --no-history
```

If you changed `Brewfile`, also verify:

```bash
brew bundle check --file Brewfile || true
```

## Contribution Rules

- Keep changes focused and reversible.
- Do not commit secrets, tokens, private keys, or machine-specific credentials.
- Preserve backup-safe behavior in `install.sh`.
- Document user-facing changes in `README.md` and `CHANGELOG.md`.

## PR Checklist

- What changed and why
- How it was tested
- Risk notes (if any)
