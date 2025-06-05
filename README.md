# dev-flakes

Expected folder structure to avoid copying of the project into nix storage:

```
Container folder
├── .nix
│   └── flake.nix
├── Project folder (git repo)
└── .envrc
```

`.envrc` will have

```
use flake ./.nix
```
