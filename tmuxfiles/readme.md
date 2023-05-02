各スクリプトを実行できるようにするために以下のディレクトリにシンボリックリンクを作成してください。
*時間があったらシェル化する。

cd /usr/local/bin

ln -sfv ~/dotfiles/tmuxfiles/tmux-get-ssid tmux-get-ssid
ln -sfv ~/dotfiles/tmuxfiles/tmux-get-volume tmux-get-volume
ln -sfv ~/dotfiles/tmuxfiles/tmux-loadaverage tmux-loadaverage
ln -sfv ~/dotfiles/tmuxfiles/tmux-pane-border tmux-pane-border
ln -sfv ~/dotfiles/tmuxfiles/tmux-used-mem tmux-used-mem

