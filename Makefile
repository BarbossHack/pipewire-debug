.PHONY=image build clean run restart
BUILD_PATH="$$PWD/volume"

all: build

image:
	@podman build --build-arg=BUILD_PATH=$(BUILD_PATH) -t pipewire:latest .

build: clean image
	@mkdir -p ./volume
	@podman run -it --rm -v $$PWD/volume:/$(BUILD_PATH):Z pipewire:latest

run:
	@systemctl --user stop pipewire.service pipewire.socket pipewire-pulse.service pipewire-pulse.socket wireplumber.service
	@WIREPLUMBER_DEBUG="4:spa.bluez5*" make -C volume/pipewire/ run > pipewire.log 2>&1

clean:
	@-podman stop -t 0 pipewire 2>/dev/null
	@-podman rm -f pipewire 2>/dev/null
	@podman unshare rm -rf ./volume

restart:
	@systemctl --user restart pipewire.service pipewire.socket pipewire-pulse.service pipewire-pulse.socket wireplumber.service
