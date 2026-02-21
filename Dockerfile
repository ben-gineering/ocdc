FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
    # Core system and CLI tools
    pacman -S --noconfirm \
      git openssh sudo bash base-devel \
      man-db man-pages which \
      zip unzip p7zip tar gzip xz \
      wget curl htop bash-completion && \
    \
    # C/C++ toolchain and utilities
    pacman -S --noconfirm \
      gcc gcc-libs clang lld \
      cmake ninja meson pkgconf \
      gdb lldb valgrind strace ccache clang-tools-extra && \
    \
    # Python development
    pacman -S --noconfirm \
      python python-pip python-virtualenv python-pynvim && \
    \
    # Neovim and editor ecosystem
    pacman -S --noconfirm \
      neovim nodejs npm ripgrep fd && \
    \
    # Embedded / PlatformIO and toolchains
    pacman -S --noconfirm \
      platformio-core platformio-core-udev \
      arm-none-eabi-gcc arm-none-eabi-gdb \
      openocd dfu-util avrdude && \
    \
    # CAD / EDA tools
    pacman -S --noconfirm \
      kicad kicad-library kicad-library-3d \
      freecad openscad && \
    pacman -Scc --noconfirm

# Create dev user with uid/gid 1000
RUN useradd -m -u 1000 -U dev && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
    chmod 440 /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev
ENV HOME=/home/dev

# Install yay AUR helper as dev user
RUN git clone https://aur.archlinux.org/yay-bin.git /home/dev/yay-bin && \
    cd /home/dev/yay-bin && \
    makepkg -si --noconfirm && \
    cd /home/dev && \
    rm -rf /home/dev/yay-bin

# Install opencode from extra/opencode
USER root
RUN pacman -S --noconfirm opencode && \
    pacman -Scc --noconfirm

# Ensure dev owns its home and config/data dirs
RUN mkdir -p /home/dev/.local/share /home/dev/.config && \
    chown -R dev:dev /home/dev

USER dev
CMD ["bash"]
