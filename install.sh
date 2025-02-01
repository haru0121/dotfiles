#!/usr/bin/env bash

set -ue

function helpmsg() {
	print_default "Usage: ${BASH_SOURCE[0]:-$0} [--gui] [--arch] [--all] [--help | -h]" 0>&2
	print_default '  --all: --gui + --arch'
	print_default ""
}
print_info() {
    echo "$1"
}

function main() {
	print_info ""
	print_info "#####################################################"
	print_info "$(basename "${BASH_SOURCE[0]:-$0}") install start..."
	print_info "#####################################################"
	print_info ""

	# スクリプトの実行場所を考慮しないようにする
	cd `dirname $0`
	SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
	# SCRIPT_DIR=$(cd ../; pwd)

	# シンボリックリンクを貼る
	mkdir -p ~/.zsh

	ln -sfv $SCRIPT_DIR/.zsh/.zshrc	~/.zsh/.zshrc
	ln -sfv $SCRIPT_DIR/.zsh/.zshenv		~/.zshenv
	ln -sfv $SCRIPT_DIR/.tmux/.tmux.conf      ~/.tmux.conf

	# gitconfig
	ln -sfv $SCRIPT_DIR/.git_global/.gitignore_global	~/.gitignore_global
	ln -sfv $SCRIPT_DIR/.git_global/.gitconfig	~/.gitconfig

	print_info ""
	print_info "#####################################################"
	print_info "$(basename "${BASH_SOURCE[0]:-$0}") install finish!!!"
	print_info "#####################################################"
	print_info ""
}

main "$@"