#!/bin/bash
#
# Linux システムツールと
# 基本的なPythonコンポーネントの
# インストールスクリプト
#
# Python for Algorithmic Trading
# (c) Dr. Yves J. Hilpisch
# The Python Quants GmbH
#

set -e  # エラー時は終了

# 一般的なLinuxパッケージ
apt-get update
apt-get upgrade -y
apt-get install -y bzip2 gcc git
apt-get install -y htop screen vim wget
apt-get upgrade -y bash
apt-get clean

# --- Miniconda（CPUアーキテクチャを検出して自動選択）-----------------
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    MINICONDA=Miniconda3-latest-Linux-x86_64.sh
else
    MINICONDA=Miniconda3-latest-Linux-aarch64.sh
fi

echo "アーキテクチャ $ARCH 用のMinicondaをダウンロード中..."
wget -q https://repo.anaconda.com/miniconda/$MINICONDA -O Miniconda.sh
bash Miniconda.sh -b -p /root/miniconda3
rm -f Miniconda.sh

# condaを初期化
export PATH="/root/miniconda3/bin:$PATH"
/root/miniconda3/bin/conda init bash

# --- .vimrc（失敗してもビルドを止めない）--------------------
wget -q https://hilpisch.com/.vimrc -O /root/.vimrc || echo "警告: .vimrcをダウンロードできませんでした"

# Pythonライブラリのインストール
echo "Pythonライブラリをインストール中..."
conda install -y pandas
conda install -y ipython

echo "インストールが正常に完了しました！"