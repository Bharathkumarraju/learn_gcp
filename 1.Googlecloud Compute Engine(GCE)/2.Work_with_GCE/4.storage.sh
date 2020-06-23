Unstructured data:
1.Block Storage:
Persistent HDDs
Persistent SSDs
Local SSDs
RAM disk

Persistent Disks Vs Local SSDs
--------------------------------->

2.Object Storage:
GCS Buckets(Google Cloud Storage Buckets)




Structured data:
OLTP: transactional processing
1.cloud SQL
2.Cloud Spanner

OLAP: Analytical Processing
1.Big Query
2.Big table



Attach the persistent disk to exisitng VM:
--------------------------------------------->

bharath@bkr2:~$ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   10G  0 disk
├─sda1    8:1    0  9.9G  0 part /
├─sda14   8:14   0    3M  0 part
└─sda15   8:15   0  124M  0 part /boot/efi
sdb       8:16   0   10G  0 disk
bharath@bkr2:~$


bharath@bkr2:~$ sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
mke2fs 1.44.5 (15-Dec-2018)
Discarding device blocks: done
Creating filesystem with 2621440 4k blocks and 655360 inodes
Filesystem UUID: f761eb46-773e-4f07-a83a-b1151ffc6aff
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

bharath@bkr2:~$


bharath@bkr2:~$ sudo mkdir -p /mnt/disks/disk-2
bharath@bkr2:~$

bharath@bkr2:~$ sudo mount -o discard,defaults /dev/sdb /mnt/disks/disk-2
bharath@bkr2:~$


bharath@bkr2:~$ sudo chmod a+w /mnt/disks/disk-2/
bharath@bkr2:~$ ls -l /mnt/disks
total 4
drwxrwxrwx 3 root root 4096 Jun 22 01:11 disk-2
bharath@bkr2:~$



bharath@bkr2:~$ sudo cp /etc/fstab /etc/fstab.backup
bharath@bkr2:~$ sudo blkid /dev/sdb
/dev/sdb: UUID="f761eb46-773e-4f07-a83a-b1151ffc6aff" TYPE="ext4"
bharath@bkr2:~$


bharath@bkr2:~$ sudo chmod a+w /etc/fstab
bharath@bkr2:~$ vim /etc/fstab
bharath@bkr2:~$ vim /etc/fstab
bharath@bkr2:~$ cat /etc/fstab
# /etc/fstab: static file system information
UUID=d7aaa5b7-1304-4582-8a5d-3f1b20f9bac9 / ext4 rw,discard,errors=remount-ro 0 0
UUID=f761eb46-773e-4f07-a83a-b1151ffc6aff / ext4 rw,discard,errors=remount-ro 0 0
UUID=6EDC-6041 /boot/efi vfat defaults 0 0
bharath@bkr2:~$

