# 📓 Repository Backlog & Technical Debt

> **Global Context:** Cross-platform (Linux under WSL, macOS, NixOS) Home-Manager setup.
> **Target Closure:** ~550MB. **CVSS Floor:** 5.0.
> **Constraint:** No IT/Security metaphors in discussions.

---

## 🛠️ Active Sprint: The "Lean & Secure" Cleanup

### 1. Strip "CVE Magnets" via Overlays

- [ ] **Target:** `overlays/default.nix`
- [ ] **Task:** Implement `override` logic for `curl`, `git`, `ffmpeg`, and `imagemagick`.
- [ ] **Details:** Disable GSS-API/LDAP in `curl`; disable GUI/Systemd support in `git`; use `withSmallFeatures` for `ffmpeg`.
- [ ] **Goal:** Delete the vulnerable sub-dependencies (like `openldap`, `libkrb5`, `avahi`) from the 529MB closure.

### 2. DevShell Migration (Package Purge)

- [ ] **Target:** `modules/user/packages/dev.nix` & `modules/user/packages/security.nix`
- [ ] **Task:** Remove "One-off" compilers and build tools from the global profile.
- [ ] **Candidates:** `gcc`, `go`, `yasm`, `ninja`.
- [ ] **Alternative:** Create a `flake.nix` devShell or a `shell.nix` for project-specific compilation.

### 3. CVE Whitelist Maintenance

- [ ] **Target:** `whitelist.toml`
- [ ] **Task:** Cross-reference current `vulnix` output with the new CVSS 5.0 floor.
- [ ] **Goal:** Remove entries for vulnerabilities < 5.0 (ignoring them entirely) and focus only on High/Critical (7.0+) network-facing risks.

---

## 🤖 Justfile Automation & Hygiene

- [ ] **Refine `Justfile`:**
  - [ ] Add `optimize`: Runs `nix-store --optimise` (High impact for WSL disk space).
  - [ ] Add `clean`: Deletes generations older than 30d and collects garbage.
  - [ ] Add `audit`: Runs `vulnix` against the local profile with thresholding.
- [ ] **Cachix Management:**
  - [ ] Set retention policy in Cachix dashboard to 30 days.
  - [ ] Verify GHA `pushFilter` only pushes from `main` to save storage.

---

## 🏗️ Long-Term Architecture

- [ ] **Trait-Based Refactor:** - [ ] Move away from host-specific imports in `flake.nix`.
  - [ ] Implement a `lib.mkSystem` wrapper that accepts "traits" (e.g., `isWSL`, `isWork`, `isDarwin`).
- [ ] **CI/CD Enhancements:**
  - [ ] Add `nvd diff` to `.github/workflows/check.yml` to see closure size/CVE changes on PRs.
  - [ ] Automate `flake update` commits with a "Security Impact" summary.

---

## 📝 Agent Instructions (Shared Context)

_When assisting with this repo:_

1. Prioritize **closure minimalism** (keep under 600MB).
2. Reference the current `whitelist.toml` before suggesting package updates.
3. Assume a **CVSS floor of 5.0**; ignore anything lower unless it's in `ssh` or `age`.
4. Focus on **WSL/macOS parity**—tools must work in both environments.
