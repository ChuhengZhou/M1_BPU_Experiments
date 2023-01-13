from operator import length_hint
import sys

def print_help():
    print("usage: python3 prepare_branches.py <branch_type> <block_size> <block_number>")
    print("\tbranch_type:\tconditional, unconditional, indirect")
    print("\tblock_size:\tpower of 2 bytes")
    exit()

def prepare_conditional_branches(block_size, block_number):
    print("void conditional_branches(unsigned long long flag){")
    print("\tasm volatile(\"mov x0, %0\"::\"r\"(flag));")
    print("\tasm volatile(\"cmp x0, 0\");")
    for i in range(0, int(block_number)):
        print("\tasm volatile(\"beq 4\");")
        for j in range(0,int(block_size)//4-1):
            print("\tasm volatile(\"nop\");")
    print("}")

def prepare_unconditional_branches(block_size, block_number):
    print("void unconditional_branches(){")
    for i in range(0, int(block_number)):
        print("\tasm volatile(\"b " + block_size + "\");")
        for j in range(0,int(block_size)//4-1):
            print("\tasm volatile(\"nop\");")
    print("}")

def prepare_indirect_branches(block_size, block_number):
    print("void func_0(void){}")
    print("void func_1(void){}")
    print("void indirect_branches(void (*func)(void)){")
    print("\tasm volatile(\"mov x1, x30\");")
    print("\tasm volatile(\"mov x0, %0\"::\"r\"(func));")
    for i in range(0, int(block_number)):
        print("\tasm volatile(\"blr x0\");")
        for j in range(0, int(block_size)//4 - 1):
            print("\tasm volatile(\"nop\");")
    print("\tasm(\"mov x30, x1\");")
    print("}")
    
para_number = len(sys.argv)

if "--help" in sys.argv and len(sys.argv) == 2:
    print_help()
elif len(sys.argv) != 4:
    print_help()
else:
    type = sys.argv[1]
    block_size = sys.argv[2]
    block_number = sys.argv[3]

    if type == "conditional":
        prepare_conditional_branches(block_size, block_number)
    elif type == "unconditional":
        prepare_unconditional_branches(block_size, block_number)
    elif type == "indirect":
        prepare_indirect_branches(block_size, block_number)
    else:
        print_help()



 

