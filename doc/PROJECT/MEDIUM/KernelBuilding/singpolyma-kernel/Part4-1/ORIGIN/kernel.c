#include <stddef.h>

#include "versatilepb.h"
#include "asm.h"

void bwputs(char *s) {
	while(*s) {
		while(*(UART0 + UARTFR) & UARTFR_TXFF);
		*UART0 = *s;
		s++;
	}
}

void first(void) {
	bwputs("In user mode 1\n");
	syscall();
	bwputs("In user mode 2\n");
	while(1) syscall();
}

void task(void) {
	bwputs("In other task\n");
	while(1) syscall();
}

#define STACK_SIZE 256 /* Size of task stacks in words */
#define TASK_LIMIT 2   /* Max number of tasks we can handle */

unsigned int *init_task(unsigned int *stack, void (*start)(void)) {
	stack += STACK_SIZE - 16; /* End of stack, minus what we're about to push */
	stack[0] = 0x10; /* User mode, interrupts on */
	stack[1] = (unsigned int)start;
	return stack;
}

int main(void) {
	unsigned int stacks[TASK_LIMIT][STACK_SIZE];
        unsigned int *mytask ;
	unsigned int *tasks[TASK_LIMIT];
	size_t task_count = 0;
	size_t current_task = 0;

	tasks[task_count] = init_task(stacks[1], &first);
	task_count++;
	tasks[task_count] = init_task(stacks[0], &task);
	task_count++;

	while(1) {
	  mytask = tasks[current_task];
	  tasks[current_task] = activate(mytask);

          tasks[current_task] = mytask;

	  current_task++;
	  if(current_task >= task_count) current_task = 0;
	}

	return 0;
}
