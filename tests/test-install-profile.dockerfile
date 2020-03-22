FROM conda/miniconda3

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
        git \
        zsh \
        tmux \
        nano \
        vim \
        less \
        locales-all \
        wget \
        curl \
        ssh \
        bzip2 \
        build-essential && \
    pip install PyYAML && \
    rm -rf /var/lib/apt/lists/*

ENV HOME=/root
WORKDIR ${HOME}

COPY ./ .

RUN ${HOME}/install-profile.sh minimal

RUN ${HOME}/tests/verify-setup.sh
