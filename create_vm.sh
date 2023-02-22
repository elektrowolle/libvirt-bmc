butane ./labvm.butane > labvm.ign

IGNITION_CONFIG="$(pwd)/labvm.ign"
IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-37.20230122.3.0-qemu.x86_64.qcow2"
VM_NAME="bmc-libvirt"
VCPUS="2"
RAM_MB="8192"
STREAM="stable"
DISK_GB="10"

# coreos-installer download -s "${STREAM}" -p qemu -f qcow2.xz --decompress -C ~/.local/share/libvirt/images/

# For x86 / aarch64,
IGNITION_DEVICE_ARG=(--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}")

# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t ${IGNITION_CONFIG}

virsh -c qemu:///system destroy ${VM_NAME}
virsh -c qemu:///system undefine --remove-all-storage ${VM_NAME}

virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE}" \
        --network bridge=virbr0 "${IGNITION_DEVICE_ARG[@]}"
