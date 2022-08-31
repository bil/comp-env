IMAGES = base_2204 scipy hdf5 ce
TARGET = ce
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

