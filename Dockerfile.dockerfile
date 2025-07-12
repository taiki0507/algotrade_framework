#
# 最新Ubuntu版での
# Dockerイメージ構築と
# 基本Pythonインストール
# 
# Python for Algorithmic Trading
# (c) Dr. Yves J. Hilpisch
# The Python Quants GmbH
#

# 最新のUbuntuバージョン
FROM ubuntu:latest  

# メンテナー情報
LABEL maintainer="yves"

# 依存パッケージのインストール
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        bzip2 gcc git htop screen vim wget ca-certificates && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Minicondaのダウンロードとインストール - バッシュシェルを明示的に使用
SHELL ["/bin/bash", "-c"]
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /root/miniconda3 && \
    rm /tmp/miniconda.sh

# condaの初期化とPATHの設定
RUN /root/miniconda3/bin/conda init bash && \
    echo 'export PATH="/root/miniconda3/bin:$PATH"' >> /root/.bashrc

# .vimrcのダウンロード（失敗してもエラーにならないように）
RUN wget -q https://hilpisch.com/.vimrc -O /root/.vimrc || echo "警告: .vimrcをダウンロードできませんでした"

# PATHを設定してcondaコマンドを使えるようにする
ENV PATH="/root/miniconda3/bin:${PATH}"

# Pythonライブラリをインストール
RUN conda install -y pandas ipython && \
    conda clean -afy

# コンテナ実行時にIPythonを起動
CMD ["ipython"]