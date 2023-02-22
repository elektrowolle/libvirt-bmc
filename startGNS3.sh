#!/bin/bash
declare HOST="qemu:///system"  #avoid using user space libvirt
declare VM="GNS3-BMC-test"
declare CACHE="./cache"

echo VM: $VM for Host: $HOST

#Remove previous installation
virsh -c $HOST destroy $VM
virsh -c $HOST undefine $VM

#Install the new vm.
virt-install -n $VM \
    --connect $HOST \
    --vcpus 4 \
    --memory 8096 \
    --disk $CACHE/GNS3\ VM-disk001.qcow2,device=disk,format=qcow2 \
    --disk $CACHE/GNS3\ VM-disk002.qcow2,device=disk,format=qcow2 \
    --os-variant=debian11 \
    --import \
    --autoconsole none
