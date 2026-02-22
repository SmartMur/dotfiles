#!/usr/bin/env python3
"""Scan tracked files and history for common secret patterns."""

from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
from dataclasses import dataclass


@dataclass
class Rule:
    name: str
    severity: str
    pattern: re.Pattern[str]


RULES = [
    Rule("anthropic_key", "high", re.compile(r"sk-ant-[A-Za-z0-9_-]{20,}")),
    Rule("openai_project_key", "high", re.compile(r"sk-proj-[A-Za-z0-9_-]{20,}")),
    Rule("github_token", "high", re.compile(r"(ghp|gho)_[A-Za-z0-9]{20,}")),
    Rule("github_pat", "high", re.compile(r"github_pat_[A-Za-z0-9_]{20,}")),
    Rule("aws_access_key", "high", re.compile(r"AKIA[0-9A-Z]{16}")),
    Rule("aws_temp_key", "high", re.compile(r"ASIA[0-9A-Z]{16}")),
    Rule("slack_token", "high", re.compile(r"xox[baprs]-[A-Za-z0-9-]{10,}")),
    Rule(
        "private_key_block",
        "high",
        re.compile(r"-----BEGIN (RSA|OPENSSH|EC|DSA|PGP|PRIVATE) KEY-----"),
    ),
]


def run(cmd: list[str], check: bool = True) -> subprocess.CompletedProcess[str]:
    return subprocess.run(cmd, capture_output=True, text=True, check=check)


def tracked_files() -> list[str]:
    proc = run(["git", "ls-files"])
    return [f.strip() for f in proc.stdout.splitlines() if f.strip() and os.path.isfile(f.strip())]


def scan_tree() -> list[tuple[str, str, str]]:
    findings: list[tuple[str, str, str]] = []
    for path in tracked_files():
        if path.startswith(".git/"):
            continue
        try:
            with open(path, "r", errors="ignore") as fh:
                for lineno, line in enumerate(fh, start=1):
                    for rule in RULES:
                        match = rule.pattern.search(line)
                        if match:
                            findings.append((rule.severity, f"{path}:{lineno}", f"{rule.name} -> {match.group(0)[:80]}"))
        except OSError:
            continue
    return findings


def scan_history() -> list[tuple[str, str, str]]:
    findings: list[tuple[str, str, str]] = []
    revs = run(["git", "rev-list", "--all"]).stdout.splitlines()
    for rev in revs:
        for rule in RULES:
            proc = run(["git", "grep", "-nI", "-E", rule.pattern.pattern, rev], check=False)
            for line in proc.stdout.splitlines():
                if not line.strip():
                    continue
                parts = line.split(":", 3)
                if len(parts) < 4:
                    continue
                _, path, lineno, content = parts
                findings.append((rule.severity, f"{rev[:8]}:{path}:{lineno}", f"{rule.name} -> {content[:80]}"))
    return findings


def show(title: str, findings: list[tuple[str, str, str]]) -> None:
    if not findings:
        print(f"[security_scrub] {title}: no findings")
        return
    print(f"[security_scrub] {title}: {len(findings)} finding(s)")
    for sev, loc, detail in findings[:200]:
        print(f"  - [{sev}] {loc} | {detail}")
    if len(findings) > 200:
        print(f"  ... truncated, {len(findings) - 200} more")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--no-history", action="store_true", help="Skip git history scan")
    args = parser.parse_args()

    tree = scan_tree()
    hist = [] if args.no_history else scan_history()
    show("working tree", tree)
    show("history", hist)

    total = tree + hist
    high = sum(1 for sev, *_ in total if sev == "high")
    print(f"[security_scrub] summary: high={high}")
    if high > 0:
        print("[security_scrub] FAILED: secret patterns detected")
        return 1
    print("[security_scrub] PASSED")
    return 0


if __name__ == "__main__":
    sys.exit(main())
