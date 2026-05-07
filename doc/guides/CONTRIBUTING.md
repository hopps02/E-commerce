# Contribution Guidelines

To maintain a professional workflow and high traceability, please follow these standards.

## 1. Commit Message Convention
We use **Conventional Commits**. This makes the history readable and allows for automated changelog generation.

**Format**: `<type>(<scope>): <description>`

- **feat**: A new feature (e.g., `feat(auth): add biometric login`)
- **fix**: A bug fix (e.g., `fix(api): handle timeout error`)
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests

## 2. GitLab Workflow
- **Issues**: Every task should have a corresponding GitLab Issue.
- **Merge Requests (MR)**: Create an MR for every feature/fix. 
- **Linking**: Use `Closes #123` in the MR description to automatically close the issue when merged.
- **Branch Naming**: Use `feature/issue-number-short-description` or `fix/issue-number-short-description`.

## 3. Code Standards
- Follow the **MVVM + Clean Architecture** patterns defined in [ARCHITECTURE.md](./ARCHITECTURE.md).
- Use **Riverpod** for ViewModels/Controllers.
- Maintain strict separation between layers (UI -> Domain -> Data).


