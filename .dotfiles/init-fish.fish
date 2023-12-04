cp ~/.config/fish/fish_plugins /tmp/fish_plugins
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
curl -sL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh | grep ^alias | grep -v "\\\$" > ~/.config/fish/conf.d/git-aliases.sh
mv /tmp/fish_plugins ~/.config/fish/fish_plugins && fisher update
set -U FZF_LEGACY_KEYBINDINGS 0
git clone --depth 1 https://github.com/yeseni-today/ays-fish-theme.git /tmp/ays
cp /tmp/ays/fish_right_prompt.fish ~/.config/fish/functions && rm -rf /tmp/ays
