#define _GNU_SOURCE
#include <stdio.h>
#include <sched.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include "m1_pmu_setup.h"
#include "branches.h"

void main(){
    uint64_t misprediction;

    enable_all_counters();
    

    // Test conditional branches
    for (size_t i = 0; i < 10000; i++)
    {
        conditional_branches(1);
    }
    
    set_event_id(0xc5);
    
    clear_all_counters();

    isb();
    conditional_branches(0);
    isb();

    // Test indirect branches
    // set_event_id(0xc6);

    // indirect_branches(func_0);
    
    // clear_all_counters();

    // isb();
    // indirect_branches(func_0);
    // isb();

    read_system_register(PMC5, misprediction);
    printf("misprediction = %lld\n", misprediction);
    
    disable_all_counters();
}



