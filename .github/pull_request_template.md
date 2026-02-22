## Summary

What changed and why.

## Validation

Commands run:

```bash
bash -n bootstrap.sh
bash -n install.sh
python3 scripts/security_scrub.py --no-history
```

## Checklist

- [ ] No secrets/tokens/private keys added
- [ ] Install path still works (`./install.sh`)
- [ ] README updated if behavior changed
- [ ] `docs/SECURITY_RULEBOOK.md` reviewed for security-sensitive changes
- [ ] If incident-related: history rewrite and collaborator recovery steps documented
