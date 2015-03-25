#!/bin/bash
root_dir=`pwd`
rootfs_target=$root_dir/rootfs

do_init()
{
	echo Initialize default rootfs image
	do_clean
	mkdir rootfs
	cd $rootfs_target
	sudo cpio -idvm < ../default/rootfs.cpio
}

do_make()
{
	echo Make initramfs image
	cd $rootfs_target
	find . | cpio -H newc -o > ../rootfs.cpio
}

do_clean()
{
	echo Clean
	rm rootfs.cpio
	sudo rm rootfs -rf
}

usage()
{
	echo "Usage: rootfs_make.sh [COMAND]"
	echo "[COMMAND]"
	echo "init : make rootfs directory and default files"
	echo "make : make initramfs"
	echo "clean : remove rootfs directory"
	exit
}

case $1 in
	init) do_init;;
	make) do_make;;
	clean) do_clean;;
	*) usage;;
esac
