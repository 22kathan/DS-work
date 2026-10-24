# Session 3: Git & GitHub for Data Science

This directory contains the complete walkthrough and solutions for the **GIT-GITHUB** assignment in both Markdown format and interactive Jupyter Notebook (`session_3_git_github.ipynb`).

---

## 📌 Task 1: Verify Git Installation & Configuration

- **Git Version**: `git version 2.55.0.windows.5`
- **Configured Identity**:
  - `user.name`: `kathan`
  - `user.email`: `gadhiyakathan10@gmail.com`

```bash
# Terminal Commands
git --version
git config --global user.name "kathan"
git config --global user.email "gadhiyakathan10@gmail.com"
```

---

## 📌 Task 2: Local Git Repository Initialization (`music-recommendation`)

Initialized a local repository named `music-recommendation` located at `scratch/music-recommendation`:

```bash
mkdir music-recommendation
cd music-recommendation
git init -b main
# Created README.md
git add README.md
git commit -m "Initial commit for music-recommendation project"
```

**Initial Commit Hash**: `8bfed32`

---

## 📌 Task 3: Connecting to GitHub Remote (`foodie-favorites`)

Connected local `music-recommendation` repository to the GitHub remote `foodie-favorites`:

```bash
git remote add origin https://github.com/22kathan/foodie-favorites.git
git remote -v
```

**Output**:
```text
origin  https://github.com/22kathan/foodie-favorites.git (fetch)
origin  https://github.com/22kathan/foodie-favorites.git (push)
```

To push to GitHub once the remote repository is created on your GitHub account:
```bash
git push -u origin main
```

---

## 📌 Task 4: Team Collaboration Simulation & GitHub Issue

### 1. Updated `README.md` Section:
Added the **Top 3 Music Apps** section:
```markdown
## Top 3 Music Apps
1. **Spotify**: Leading global streaming service with collaborative filtering and matrix factorization recommendation algorithms.
2. **YouTube Music**: Deep learning recommendation engine powered by Google's multi-modal video and audio consumption data.
3. **Wynk Music**: Popular regional and global streaming platform featuring curated playlists and low-latency offline playback.
```

Committed with message:
```bash
git add README.md
git commit -m "docs: add Top 3 Music Apps section to README"
```

### 2. GitHub Issue Template:
- **Title**: `[Feature Request]: Add Collaborative Playlist Sharing Functionality`
- **Labels**: `enhancement`, `good first issue`
- **Description**:
  > **Problem**: Currently, users receive algorithmic single-track recommendations without the ability to share custom-curated playlists with friends.  
  > **Proposed Solution**: Implement an exportable playlist URL generator and a collaborative queueing feature allowing multiple users to contribute songs to a shared session.  
  > **Business Value**: Drives organic peer-to-peer user acquisition and increases average daily active engagement.

---

## 📌 Task 5: Avoiding the Notebook Versioning Anti-Pattern with Git

### Why Avoid `analysis_v1.ipynb`, `analysis_final2.ipynb`?
1. **Single Source of Truth**: Maintain a single canonical notebook filename while relying on Git's atomic commit history to preserve every historical state, experiment, and parameter tweak.
2. **Isolated Feature Branches**: Use branch workflows (e.g., `git checkout -b exp/xgboost-tuning`) to test novel models without corrupting working baseline code on the `main` branch.
3. **Effortless Rollback & Diffing**: Compare exact cell diffs across commits and revert breaking changes instantly using `git revert` or `git checkout`.
4. **Collaborative Accountability**: GitHub pull requests provide transparent audit trails detailing why a metric changed, replacing ambiguous manual version suffixes.
