# Git Remote Setup Guide

This guide explains how to set up your local environment to push code to GitLab using a Personal Access Token (PAT).

## 1. Create a Personal Access Token
Go to your GitLab settings and create a token with `read_repository` and `write_repository` scopes:
[GitLab Access Tokens](https://gitlab.com/-/user_settings/personal_access_tokens)

## 2. Set Up the Authenticated Remote
Run this command in your terminal, replacing `<your_token>` with the token you generated:

```powershell
# Remove existing if needed
git remote remove origin-token

# Add the authenticated remote
git remote add origin-token https://moody27358:<your_token>@gitlab.com/azsystem/jar.git
```

## 3. Push Changes (Skipping CI)
To push your changes to the `development` branch without triggering the CI/CD pipeline:

```powershell
git push -o ci.skip origin-token development
```

---

> [!WARNING]
> **SECURITY**: Never save your actual token in this file or any other file in the repository. If you accidentally share your token, revoke it immediately on GitLab.
