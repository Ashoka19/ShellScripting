# ShellScripting
Follow this step to install percona
- yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
- yum -x Percona-Server-57* install percona-xtrabackup-24

- Full Backup : xtrabackup --user=root --password='xyz'  --backup --target-dir=/home/ashoka/backups/base --datadir=/data/backups/base

- Incremental: xtrabackup --user=root --password='xyz'  --backup --target-dir=/home/ashoka/backups/inc1 --incremental-basedir=/home/ashoka/backups/base --datadir=/data/backups/base

- Incremental 2: xtrabackup --user=root --password='xyz' --backup --target-dir=/home/ashoka/backups/inc2 --incremental-basedir=/home/ashoka/backups/inc1 --datadir=/data/backups/base

Prepare(Restore step): 

- xtrabackup --user=root --password='xyz' --prepare --apply-log-only --target-dir=/home/ashoka/backups/base
- Incremental: xtrabackup --user=root --password='xyz' --prepare --apply-log-only --target-dir=/home/ashoka/backups/base --incremental-dir=/home/ashoka/backups/inc1
- Incremental 2 xtrabackup --user=root --password='xyz' --prepare --apply-log-only --target-dir=/home/ashoka/backups/base --incremental-dir=/home/ashoka/backups/inc2

Now stop the mysql change the data dir path in my.cnf then start the service and bingo.
