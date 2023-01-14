# Makefile specific for podman, support rootless mode
# to make compatible with docker, substitute docker for podman, remove "--format docker" and "--remove-signatures" flags

IMAGES = base_2204 scipy hdf5 ce
TARGET = ce
# CE-DST must be set as an environment variable for the make push commands to work
DST=${CE-DST}

all: $(IMAGES)

$(IMAGES):
	podman build --format docker -t $@ -f $@.cf ./containerfile

push-prod:
	podman tag $(TARGET) $(DST)/$(TARGET)
	podman push --remove-signatures $(DST)/$(TARGET)

push-dev:
	podman tag $(TARGET) $(DST)/$(TARGET)-dev
	podman push --remove-signatures $(DST)/$(TARGET)-dev

prune:
	podman image prune -f
