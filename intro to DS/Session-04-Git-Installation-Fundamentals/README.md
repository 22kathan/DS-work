# Session 4: Git Installation + Fundamentals

This directory contains the complete walkthrough and solutions for the **Git Installation + Fundamentals** assignment in both Markdown format and interactive Jupyter Notebook (`session_4_git_installation_fundamentals.ipynb`).

---

## 📌 Task 1: Verify Git Installation

- **Command**: `git --version`
- **Output**: `git version 2.55.0.windows.5`
- **Status**: Git is installed, configured, and accessible on the operating system PATH.

---

## 📌 Task 2: Configure Global Git Username and Email

Configured global author identity attributes:

```bash
git config --global user.name "kathan"
git config --global user.email "gadhiyakathan10@gmail.com"
```

Verified values:
- **`user.name`**: `kathan`
- **`user.email`**: `gadhiyakathan10@gmail.com`

---

## 📌 Task 3: Initialize `InstaCloneRepo` & Inspect `.git` Folder

Created and initialized local repository `InstaCloneRepo` at `scratch/InstaCloneRepo`:

```bash
mkdir InstaCloneRepo
cd InstaCloneRepo
git init -b main
```

### Observed `.git` Internal Architecture:
| Element | Type | Purpose |
| :--- | :---: | :--- |
| **`HEAD`** | File | Points to the current branch reference (`ref: refs/heads/main`). |
| **`config`** | File | Repository-specific configuration variables and remote mappings. |
| **`description`** | File | Used primarily by the GitWeb daemon. |
| **`hooks/`** | Directory | Client-side lifecycle hook scripts (pre-commit, post-commit). |
| **`info/`** | Directory | Repository-level exclusion rules (`exclude`). |
| **`objects/`** | Directory | Content-addressable object store for blobs, trees, and commits. |
| **`refs/`** | Directory | Pointers to commit objects (local branch heads, tags, remotes). |

---

## 📌 Task 4: Clone Public Repository (`public-apis`) & Analyze `git status`

Cloned the public open-source repository `https://github.com/public-apis/public-apis.git` into `scratch/public-apis`.

### Output of `git status`:
```text
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

### Diagnostics Breakdown:
1. **`On branch master`**: Confirms the active working branch checked out is `master`.
2. **`Your branch is up to date with 'origin/master'`**: Local clone is 100% in sync with the upstream remote tracking branch (no incoming or outgoing commits).
3. **`nothing to commit, working tree clean`**: Working tree exactly matches the HEAD snapshot without any uncommitted edits, staged changes, or untracked files.

---

## 📌 Task 5: Stage & Commit `playlist.txt` with Best Practices

Created `playlist.txt` inside `InstaCloneRepo` containing 3 songs:
```text
1. Starboy - The Weeknd
2. Blinding Lights - The Weeknd
3. Lose Yourself - Eminem
```

Staged and committed with Conventional Commit message:
```bash
git add playlist.txt
git commit -m "feat: add initial playlist with 3 songs"
```

### Commit Log:
```text
commit 6ad338e
Author: kathan <gadhiyakathan10@gmail.com>
Date:   Sat Oct 24 13:05:03 2026 +0530

    feat: add initial playlist with 3 songs

 playlist.txt | 3 +++
 1 file changed, 3 insertions(+)
```
