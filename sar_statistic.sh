#!/bin/bash
#
# Script to get sar statistics#
## sar_stats.sh ##
echo "Enter the number of intervals (seconds) for the sar statistics:"
read int
echo "enter the number of output lines (count) to process:"
read cnt
while :
do
clear
echo "*******************************"
echo "* Choose from the following: *"
echo "*******************************"
echo "* [1] To view process creation statistics *"
echo "* [2] To view I/O and transfer rate statistics *"
echo "* [3] To view paging statistics *"
echo "* [4] To view block device statistics *"
echo "* [5] To view statistics for all interrupt statistics *"
echo "* [6] To view device specific network statistics *"
echo "* [7] To view extended network statistics *"
echo "* [8] To view CPU specific statistics *"
echo "* [9] To view Only 1st CPU stats *"
echo "* [10] To view queue length and load averages statistics *"
echo "* [11] To view memory and swap space utilization statistics *"
echo "* [12] To view inode, file and other kernel tables statistics*"
echo "* [13] To view system switching activity statistics *"
echo "* [14] To view swapping statistics *"
echo "* [15] To view statistics for a given process ( Example: a process called Apache with PID # 3256) *"
echo "* [0] Exit *"
echo "************************"
echo -n "Enter your menu choice [0-15]: "
D=`/bin/date '+%B.%d'`
INT=$int
CNT=$cnt
read mychoice
case $mychoice in
1) echo "process creation statistics";
sar -c $INT $CNT |tee /tmp/sar_proc_stat_$D
echo "This file will be saved to /tmp/sar_pc_stat_$D"
sleep 3 ;;
2) echo "I/O and transfer rate statistics"
sar -b $INT $CNT |tee /tmp/sar_IO_TR_stat_$D
echo "This file will be saved to /tmp/sar_IO_TR_stat_$D"
sleep 3 ;;
3) echo "paging statistics"
sar -B $INT $CNT |tee /tmp/sar_pag_stat_$D
echo "This file will be saved to /tmp/sar_pag_stat_$D"
sleep 3 ;;
4) echo "block device statistics"
sar -d $INT $CNT |tee /tmp/sar_block_stat_$D
echo "This file will be saved to /tmp/sar_block_stat_$D"
sleep 3 ;;
5) echo "all interrupt statistics statistics"
sar -I XALL $INT $CNT |tee /tmp/sar_Intr_stat_$D
echo "This file will be saved to /tmp/sar_Intr_stat_$D"
sleep 3 ;;
6) echo "specific network statistics"
sar -n DEV $INT $CNT |tee /tmp/sar_Net_stat_$D
echo "This file will be saved to /tmp/sar_Net_stat_$D"
sleep 3 ;;
7) echo "Extended network statistics"
sar -n EDEV $INT $CNT |tee /tmp/sar_ENet_stat_$D
echo "This file will be saved to /tmp/sar_ENet_stat_$D"
sleep 3 ;;
8) echo "CPU specific statistics"
sar -P ALL $INT $CNT |tee /tmp/sar_CPU_stat_$D
echo "This file will be saved to /tmp/sar_CPU_stat_$D"
sleep 3 ;;
9) echo "1st CPU statistics"
sar -P 1 $INT $CNT |tee /tmp/sar_1CPU_stat_$D
echo "This file will be saved to /tmp/sar_1CPU_stat_$D"
sleep 3 ;;
10) echo "queue length and load averages statistics"
sar -q $INT $CNT |tee /tmp/sar_queue_stat_$D
echo "This file will be saved to /tmp/sar_queue_stat_$D"
sleep 3 ;;
11) echo "memory and swap space utilization statistics"
sar -r $INT $CNT |tee /tmp/sar_mem-swap_stat_$D
echo "This file will be saved to /tmp/sar_mem-swap_stat_$D"
sleep 3 ;;
12) echo "inode, file and other kernel tables statistics"
sar -v $INT $CNT |tee /tmp/sar_kern_stat_$D
echo "This file will be saved to /tmp/sar_kern_stat_$D"
sleep 3 ;;
13) echo "system switching activity statistics"
sar -w $INT $CNT |tee /tmp/sar_switch_stat_$D
echo "This file will be saved to /tmp/sar_switch_stat_$D"
sleep 3 ;;
14) echo "swapping statistics"
sar -W $INT $CNT |tee /tmp/sar_swap_stat_$D
echo "This file will be saved to /tmp/sar_swap_stat_$D"
sleep 3 ;;
15) echo "statistics for a given process (Example: PID # 3256)"
echo "Enter the proccess number you want to check:"
read PROC
sar -x $PROC $INT $CNT |tee /tmp/sar_proc_stat_$D
echo "This file will be saved to /tmp/sar_proc_stat_$D"
sleep 3 ;;
0) exit 0;;
*) echo "BAD CHOICE!!! Please select choice 1,2,3,4,5,6 ........ ";
echo "Press Enter to continue. . ." ; read ;;
esac
done

