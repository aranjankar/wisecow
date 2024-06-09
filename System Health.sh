#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Usage: $CPU_USAGE%"

# Check Memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Memory Usage: $MEMORY_USAGE%"

# Check Disk usage
DISK_USAGE=$(df -h / | grep / | awk '{ print $5 }' | sed 's/%//g')
echo "Disk Usage: $DISK_USAGE%"

# Check Running processes
PROCESS_COUNT=$(ps aux | wc -l)
echo "Running Processes: $PROCESS_COUNT"

# Alert if thresholds are exceeded
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
  echo "Alert: CPU usage is above $CPU_THRESHOLD%"
fi

if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
  echo "Alert: Memory usage is above $MEMORY_THRESHOLD%"
fi

if (( $DISK_USAGE > $DISK_THRESHOLD )); then
  echo "Alert: Disk usage is above $DISK_THRESHOLD%"
fi