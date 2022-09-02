# My dotfiles

- [How to store dotfiles | Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

## INSTALLATION

Setup repository
```sh
curl https://raw.githubusercontent.com/ykszk/dotfiles/main/.dotfiles/setup.sh | bash
```

Setup tools
```sh
bash .dotfiles/install.sh
```

## Commit, Pull and Push
Use `config` alias instead of git command.

```sh
config status
config pull
config add -a
config push
```
