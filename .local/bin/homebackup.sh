#!/bin/bash

sudo mkdir -p /mnt/NetworkShare

sudo mount -t cifs -o credentials=/etc/networkshare-creds //192.168.44.18/NetworkShare /mnt/NetworkShare &&

sudo rsync -rlptgoD -AXv --delete --exclude={/home/jackson/1TB_SSD/*,/home/jackson/.cache/*,/home/jackson/4TB_HDD/*,/home/jackson/Downloads/Game\ Downloads/*} /home /mnt/NetworkShare/Jackson_Backups/rsync_backups

sudo umount /mnt/NetworkShare

sudo rsync -rlptgoD -AXv --delete --exclude={/home/jackson/1TB_SSD/*,/home/jackson/.cache/*,/home/jackson/4TB_HDD/*,/home/jackson/Downloads/Game\ Downloads/*} /home /home/jackson/4TB_HDD/Storage/homebackups
