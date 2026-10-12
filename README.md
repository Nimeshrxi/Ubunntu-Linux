Linux Health Monitor

A Bash script that checks the basic health of a Linux machine and logs every run.

Checks
Disk usage (warning at 80% or more)
Memory usage (warning at 80% or more)
Network connectivity (ping)
SSH service status
Usage
bash
chmod +x health_check.sh
./health_check.sh            # run all checks
./health_check.sh disk       # or: memory | network | ssh
Sample output
====== Disk Usage ======
Disk Usage: 1%
Status: OK

====== Memory Usage ======
Memory Usage: 15%
Status: OK

====== Network Status ======
Network: OK

====== SSH Status ======
SSH: DOWN

All output is also appended to health.log.

Requirements

Bash on Ubuntu or another Linux distribution (uses df, free, awk, ping, systemctl).

Author

Nimesh, @NimeshRxi
