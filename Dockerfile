FROM fedora:38

# Needed for fdk-aac-devel
RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# We want same setup as in our host, so start installing pipewire
RUN dnf install -y pipewire
# install pipewire build deps
RUN dnf install -y systemd-devel ncurses-devel readline-devel alsa-lib-devel dbus-devel libsndfile-devel libcanberra-devel libunwind-devel gcc gcc-c++ gettext libusb1-devel bluez-libs-devel libldac-devel sbc-devel glib2-devel meson webrtc-audio-processing-devel pkgconf-pkg-config pulseaudio-libs-devel fdk-aac-devel which meson
RUN dnf install -y git make

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ARG BUILD_PATH
RUN mkdir -p ${BUILD_PATH}
WORKDIR ${BUILD_PATH}

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
