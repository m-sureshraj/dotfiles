# Suresh's dotfiles

coming soon...

## Installation

To install with a one-liner, run this:

```shell script
bash <(wget -qO- --no-cache https://raw.githubusercontent.com/m-sureshraj/dotfiles/master/scripts/bootstrap.linux.sh)
```

The above script has been successfully tested on the following Ubuntu releases.

* `20.10` Groovy Gorilla
* `20.04` Focal Fossa  

## What does it do?

When you invoke the above script, this is what it does in a nutshell:

* Updates system package lists. `apt-get update`
* Install a few system dependencies and util packages
  ```
  build-essential, curl, git, vim, htop, tree, zsh, fonts-powerline
  ```
* Install the latest LTS release of [Node.js](https://nodejs.org/en/) through [NVM](https://github.com/nvm-sh/nvm)
* Clone and **symlink** this repository's dotfiles to `$HOME`
* Setup [VIM](https://www.vim.org/sponsor/index.php)
* Setup [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* Finally, switches the current shell to `zsh`

## Credits
