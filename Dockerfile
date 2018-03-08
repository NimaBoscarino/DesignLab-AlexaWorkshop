# MIT License
#
# Copyright (c) 2018 Design Lab Live
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM ubuntu:16.04

# Install base ubuntu dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    iputils-ping \
    net-tools \
    nodejs \
    npm \
    openssh-server \
    tmux \
    tree \
    vim \
    wget

# Upgrade node, npm, and essential node modules
RUN npm install -g n && n 8.9.0 && \
    npm install -g npm@latest && \
    npm install -g ask-cli alexa-sdk aws-sdk

RUN mv /usr/bin/npm /root/ && ln -s /usr/local/bin/npm /usr/bin/npm

# Fetch github code repos
WORKDIR /root/workspace
RUN git clone --depth=1 https://github.com/amix/vimrc.git /root/.vim_runtime && \
    git clone https://github.com/tomasr/molokai.git && \

    git clone https://github.com/alexa/skill-sample-nodejs-fact.git && \
    git clone https://github.com/alexa/skill-sample-nodejs-howto.git && \
    git clone https://github.com/alexa/skill-sample-nodejs-team-lookup.git && \
    git clone https://github.com/alexa/skill-sample-nodejs-trivia.git && \
    git clone https://github.com/alexa/skill-sample-nodejs-quiz-game.git

# Configure VIM environment
RUN sh /root/.vim_runtime/install_awesome_vimrc.sh && \
    mkdir /root/.vim && \
    mv /root/workspace/molokai/colors /root/.vim/ && \
    rm -rf /root/workspace/molokai && \
    echo "let g:molokai_original = 1" >> /root/.vimrc
