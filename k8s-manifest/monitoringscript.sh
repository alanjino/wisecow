#!/bin/bash

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
LOG_FILE="system_health.log"

echo "System Health Check - $(date)"

# CPU usage
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}')
cpu_int=${cpu%.*}
if [ $cpu_int -gt $CPU_THRESHOLD ]; then
  echo "High CPU usage detected: $cpu%" | tee -a $LOG_FILE
fi

# Memory usage
mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
mem_int=${mem%.*}
if [ $mem_int -gt $MEM_THRESHOLD ]; then
  echo "High Memory usage detected: $mem%" | tee -a $LOG_FILE
fi

# Disk usage
disk=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ $disk -gt $DISK_THRESHOLD ]; then
  echo "High Disk usage detected: $disk%" | tee -a $LOG_FILE
fi

# Top 5 CPU consuming processes
echo "Top 5 CPU-consuming processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

