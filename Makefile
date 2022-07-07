IMAGES = base_2204 scipy hdf5 ce
DST=${CE-DST}

all: $(IMAGES)

$(IMAGES):
	podman build --format docker -t $@ -f $@.cf ./containerfile

push:
	podman tag ce $(DST)/ce
	podman push --remove-signatures $(DST)/ce

prune:
	podman image prune -f

