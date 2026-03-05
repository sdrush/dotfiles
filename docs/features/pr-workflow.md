# 🔄 The Pull Request Workflow

While it's tempting to push changes directly to `main` when working on personal dotfiles, adopting a branch-based **Pull Request (PR) Workflow** provides massive benefits for stability and reproducibility.

## ✨ Why use PRs for Dotfiles?

1. **Safety**: You don't break your main setup if your configuration fails to evaluate.
2. **Visibility**: Our automated `Nix Flake Diff` CI job will post a comment showing exactly which packages and versions are added, upgraded, or removed. You can see the consequences of an update _before_ merging it.
3. **Flake Health**: The `DeterminateSystems` flake checker ensures your `flake.lock` health doesn't degrade.
4. **Reverting is easier**: A single git revert on a merged PR cleanly unwinds an entire feature rather than picking apart individual botched commits.

## 🛠️ Typical Workflow

Instead of writing to `main` directly, follow this loop:

### 1. Create a Branch

```bash
git switch -c feature/add-new-tool
```

### 2. Make Changes & Test Locally

Add your settings or flake inputs, and verify they work on your local machine:

```bash
just rebuild
```

### 3. Commit and Push

Use our pre-configured `commitizen` pre-commit hooks:

```bash
git commit -m "feat(packages): add ripgrep and fd"
git push -u origin HEAD
```

### 4. Open a Pull Request & Review

Using the GitHub CLI, you can instantly create a PR from your terminal:

```bash
gh pr create --title "feat: add new CLI tools" --body "Testing ripgrep integration." --web
```

Or open the URL in your browser.

Wait ~2 minutes for the **GitHub Actions** checks to run. You will see:

- Linting and Formatting checks ensuring codebase health.
- A **Nix Closure Diff** comment showing all new versions/packages that will be installed on your macOS and Linux environments.

### 5. Merge

Once everything is green, merge the PR (Squash & Merge is recommended for a clean history)!

```bash
gh pr merge --squash --delete-branch
```

## 🛡️ Programmatic Governance

To protect yourself from accidentally pushing to `main`, we've enabled **Branch Protection** using the GitHub CLI. What this means:

- You **cannot** run `git push origin main` directly anymore. The git daemon will reject it.
- You **must** go through the PR process, ensuring CI passes and you receive the NVD package diff before the branch gets merged.
- It enforces a linear commit history (rebasing/squashing), preventing messy merge commits from polluting your dotfiles timeline!
