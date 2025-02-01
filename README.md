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
3. シンボリックリンクを貼る
gitconfig.templateをコピーしてgitユーザー設定を記入

```
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
4. homwbrewパッケージのインストール
```
brew bundle --global
```