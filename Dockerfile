FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]
RUN apt update &&\
    DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
    locales software-properties-common tzdata &&\
    locale-gen ja_JP ja_JP.UTF-8 &&\
    update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 &&\
    add-apt-repository universe

ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y curl sudo wget nano vim tig gh gnupg gnupg2 lsb-release texlive-full

ARG UID
ARG GID
ARG USER_NAME
ARG GROUP_NAME

RUN groupadd -g ${GID} ${GROUP_NAME} &&\
    useradd -m -s /bin/bash -u ${UID} -g ${GID} -G sudo ${USER_NAME} &&\
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers &&\
    echo "PS1='\[\033[42;37m\]LaTeX\[\033[0m\]@\[\033[32m\]\u\[\033[0m\]:\[\033[1;33m\]\w\[\033[0m\]\ $ '" >> /home/${USER_NAME}/.bashrc &&\
    usermod -aG dialout ${USER_NAME} &&\
    mkdir -p /home/${USER_NAME}/texworks && chmod -R 777 /home/${USER_NAME}/texworks

USER ${USER_NAME}

WORKDIR /home/${USER_NAME}/texworks
