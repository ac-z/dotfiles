FROM greyltc/archlinux-aur:latest

# Restore man pages: Comment out NoExtract, install man-db, and reinstall existing packages
RUN sed -i 's/^NoExtract/#NoExtract/g' /etc/pacman.conf && \
    pacman -Ql | grep '/usr/share/man/' | cut -d' ' -f1 | sort -u | grep -v "paru" | \
    sudo pacman -Syu --noconfirm man-db man-pages -

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

RUN mkdir -p /etc/skel/.config && \
    printf "\
[Default Applications]\n\
text/html=firefox.desktop\n\
x-scheme-handler/http=firefox.desktop\n\
x-scheme-handler/https=firefox.desktop\n\
" > /etc/skel/.config/mimeapps.list

# Add main dotfiles
COPY main/ /etc/skel

# Runs an internal dbus session so programs don't need access to the host dbus
ENTRYPOINT ["/usr/bin/dbus-run-session"]

# Container exits when tmux exits
CMD ["/usr/bin/tmux"]

