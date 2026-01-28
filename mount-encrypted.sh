rclone mount pcloud_encrypted: /media/pcloud-encrypted \
    --allow-other \
    --vfs-cache-mode full \
    --cache-dir /opt/rclone-cache \
    --vfs-cache-max-size 40G \
    --vfs-cache-max-age 96h \
    --dir-cache-time 3h \
    --poll-interval 1m \
    --syslog \
    --log-level INFO
