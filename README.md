# pcloud-utils

`pcloud_sync`: safe one-way backup of a local disk to an encrypted pCloud rclone remote.

- Syncs `SOURCE_ROOT` to `DEST_ROOT` with `rclone sync`; deleted/changed files go to an archive folder, not straight to oblivion.
- Aborts if more than `MAX_DELETES` deletions are pending (rclone then exits 7, "Fatal error").
- Pre-flight source health checks: mount marker, read-only remount, readability, kernel I/O errors (24h), SMART. Failure = CRITICAL email, no sync.
- Writes `last_sync_status`, `history.csv`, `diff.log`; emails a report (via `msmtp`).

## Setup

```sh
cp pcloud_sync.conf.sample pcloud_sync.conf   # edit paths, email, limits
touch /path/to/source/.drive_is_mounted       # marker so an unmounted disk is never synced
```

Needs: `rclone` (remote configured, e.g. `pcloud_encrypted:`), `smartctl`, `msmtp`, root.

## Usage

```
pcloud_sync [-c] [-n] [-d] [-v] [-b] [-h] [subfolder]

-c  check only: report/email, no sync
-n  dry run
-d  delete permanently instead of archiving
-v  after sync, hash-verify random files
-b  bandwidth schedule (throttled 09-23h)
-h  help
```

```sh
pcloud_sync -n Photos/   # dry run one folder
pcloud_sync -bv Music/   # throttled, verified
pcloud_sync              # default SUBFOLDER from config
```
