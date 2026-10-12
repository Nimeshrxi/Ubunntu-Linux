#!/bin/bash

exec > >(tee -a health.log)

echo "====== Linux Health Check ======"
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "User: $USER"

check_disk() {
echo
echo "====== Disk Usage ======"

disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk Usage: $disk_usage%"

if [ "$disk_usage" -ge 80 ]; then
echo "Status: WARNING - Disk usage is high!"
else
echo "Status: OK"
fi
}

check_memory() {
echo
echo "====== Memory Usage ======"

memory_usage=$(free | awk 'NR==2 {printf "%.0f", $3/$2*100}')

echo "Memory Usage: $memory_usage%"

if [ "$memory_usage" -ge 80 ]; then
echo "Status: WARNING - Memory usage is high!"
else
echo "Status: OK"
fi
}

check_network() {
echo
echo "====== Network Status ======"

ping -c 1 google.com > /dev/null 2>&1

if [ $? -eq 0 ]; then
echo "Network: OK"
else
echo "Network: DOWN"
fi
}

check_status() {
echo
echo "====== SSH Status ======"

systemctl is-active --quiet ssh

if [ $? -eq 0 ]; then
echo "SSH: OK"
else
echo "SSH: DOWN"
fi
}

if [ $# -eq 0 ]; then

check_disk
check_memory
check_network
check_status

else

case "$1" in
disk)
check_disk
;;
memory)
check_memory
;;
network)
check_network
;;
*)
echo "Unknown option: $1"
echo "Use: disk | memory | network | ssh"
;;

esac
fi
