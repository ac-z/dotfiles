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
  adobe-source-code-pro-fonts \
  emacs-wayland

ENV XDG_RUNTIME_DIR=/tmp
ENV WAYLAND_DISPLAY=wayland-0
ENV MOZ_ENABLE_WAYLAND=1
ENV BROWSER=firefox

# Set $FALLBACK_SHELL to an executable's path to run that instead of emacs
COPY emacs-entrypoint.sh /usr/local/bin/emacs-entrypoint.sh
RUN chmod +x /usr/local/bin/emacs-entrypoint.sh

ENTRYPOINT ["/usr/bin/dbus-run-session", "/usr/local/bin/emacs-entrypoint.sh"]

