FROM archlinux:latest

RUN pacman -Syu --noconfirm \
      git openssh sudo bash && \
    pacman -Scc --noconfirm

# Create dev user with uid/gid 1000
RUN useradd -m -u 1000 -U dev && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
    chmod 440 /etc/sudoers.d/dev

USER dev
WORKDIR /home/dev
ENV HOME=/home/dev

# Install opencode from extra/opencode
USER root
RUN pacman -Syu --noconfirm opencode && \
    pacman -Scc --noconfirm

USER dev
CMD ["bash"]
