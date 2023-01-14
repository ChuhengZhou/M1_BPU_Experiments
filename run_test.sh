export branch_interval=4
export cpu_affinity=2
export branch_type=conditional

python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 64 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 128 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 256 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 512 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 1024 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 2048 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 4096 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 8192 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 16384 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 32768 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 65536 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 131072 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 262144 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 524288 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 1048576 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 2097152 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 4194304 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
python3 prepare_branches.py `echo $branch_type` `echo $branch_interval` 8388608 > branches.h
gcc main.c -o main
taskset -c `echo $cpu_affinity` ./main
