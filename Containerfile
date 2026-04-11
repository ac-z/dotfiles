FROM greyltc/archlinux-aur:latest

# Restore man pages: Comment out NoExtract, install man-db, and reinstall existing packages
RUN sed -i 's/^NoExtract = /#NoExtract = /g' /etc/pacman.conf && \
    pacman -Ql | grep '/usr/share/man/' | cut -d' ' -f1 | sort -u | grep -v "paru" | \
    sudo pacman -Syu --noconfirm -

RUN pacman -Syu --noconfirm \
  git \
  git-lfs \
  rsync \
  rclone \
  stow \
  zip \
  unzip \
  ncdu \
  tree \
  htop \
  tmux \
  screen \
  bash-completion \
  shellcheck \
  wget \
  openssh \
  base-devel \
  python-pip \
  python-pipx \
  npm \
  deno \
  rustup \
  xdg-utils \
  ripgrep \
  fd \
  jq \
  fzf \
  neovim \
  wl-clipboard \
  firefox \
  foot \
  foot-terminfo \
  ttf-hack-nerd \
  adobe-source-code-pro-fonts

ENV XDG_RUNTIME_DIR=/tmp
ENV WAYLAND_DISPLAY=wayland-0
ENV MOZ_ENABLE_WAYLAND=1
ENV BROWSER=firefox

COPY main/ /etc/skel/
COPY private/ /etc/skel/

RUN useradd -m -u 1000 dev && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dev
RUN mkdir -p /home/dev/.config && \
    printf "[Default Applications]\ntext/html=firefox.desktop\nx-scheme-handler/http=firefox.desktop\nx-scheme-handler/https=firefox.desktop" > /home/dev/.config/mimeapps.list

WORKDIR /home/dev
CMD ["/usr/bin/bash"]

