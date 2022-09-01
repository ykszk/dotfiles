curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
curl -sL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh | grep ^alias | grep -v "\\\$" > ~/.config/fish/conf.d/git-aliases.sh
fisher update
set -U FZF_LEGACY_KEYBINDINGS 0
git clone --depth 1 https://github.com/yeseni-today/ays-fish-theme.git /tmp/ays
cp /tmp/ays/*.fish ~/.config/fish/functions && rm -rf /tmp/ays