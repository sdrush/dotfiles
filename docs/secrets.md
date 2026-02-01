# Secret Management with SOPS 🔒

We use [sops-nix](https://github.com/Mic92/sops-nix) to manage secrets. This allows us to check encrypted secret files into Git while keeping the values secure.

## 🛠️ The Stack

- **SOPS**: The tool used to encrypt/decrypt files.
- **Age**: The modern encryption format used for the keys.
- **Secrets File**: `secrets.yaml` in the root of the repo.

## 🔑 Your Age Key

Your private key is stored locally at:
`~/.config/sops/age/keys.txt`

> [!CAUTION]
> **NEVER** check this file into Git. If you lose this file, you lose access to all encrypted secrets in this repository. Back it up in a secure password manager (e.g., Bitwarden).

## 📝 Common Workflows

### 1. View or Edit Secrets

Run the helper recipe:

```zsh
just secrets
```

This opens `secrets.yaml` in your `$EDITOR`. When you save and exit, SOPS automatically re-encrypts the file.

### 2. Add a New Secret

1. Run `just secrets`.
2. Add a new key-value pair under the `secrets` section.
3. Save and close.
4. Reference the secret in your Nix code (usually in `modules/user/secrets.nix`).

### 3. Rotate Keys / Add a New Machine

If you set up a new machine, you must add its public `age` key to `.sops.yaml` in the repo root before it can decrypt the secrets.

## 🔍 Verification

To verify that secrets are being decrypted correctly after a rebuild:

```zsh
cat /run/user/$(id -u)/secrets/test_secret
```

(Note: Locations may vary; check `modules/user/secrets.nix` for specific secret paths).
