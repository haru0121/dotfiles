# dotfiles
## 設定
1. Homebrewインストール
```
xcode-select -v
```
(xcode-selectが存在しなければ)
```
xcode-select --install
```

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
2. zinitインストール
```
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```
```
source ~/.zshrc
zinit self-update
```

```
cd ~ && git clone https://github.com/haru0121/dotfiles.git <git clone dir>
```

```
cd <git clone dir>
```
2. tmuxインストール
```
brew install tmux
```
2. starshipインストール
```
brew install starship
```
3. シンボリックリンクを貼る
gitconfig.templateをコピーしてgitユーザー設定を記入

```
./install.sh
```

（動かなければ実行権限の付与）
```
chmod +x install.sh
```
保存
```
source ~/.zsh/.zshrc
```

```
tmux
```
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
```
```
chmod +x ~/.tmux/plugins/tpm/tpm 
```
```
tmux source-file ~/.tmux.conf
```
4. homwbrewパッケージのインストール
```
brew bundle --global
```
