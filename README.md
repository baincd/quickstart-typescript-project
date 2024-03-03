# Quick Start TypeScript Project

A simple TypeScript project that can be used as a base to quickly standup a new application.

## Usage

1. Open a BASH shell
2. `cd` into directory for the new project (directory must be empty)
3. Run the following

```bash
git clone -o quickstart https://github.com/baincd/quickstart-typescript-project.git . &&
./init.sh
```

## Appendix

<details>
<summary>Useful commands for creating a new TypeScript project</summary>

```bash
# Generate a new node project
npm init --yes

# Install Typescript
npm install --save-dev typescript tsc-watch

# Create .gitignore
curl -sL https://www.toptal.com/developers/gitignore/api/node,visualstudiocode > .gitignore
```
</details>
