#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

//#define SIM

// LED Peripheral
#define REG_DATA_OFFSET 1

int main(void){
  unsigned int led = 0;
  volatile unsigned int *p_led = (unsigned int *) PERIPHERAL_LED_0_BASE;
  volatile unsigned int *p_hc  = (unsigned int *) HC_SR04_0_BASE;
  volatile int i = 0;
  volatile int reg_config;

#ifndef SIM
  printf("Embarcados++ \n");
#endif

  while(1){

	  *(p_hc + 0) = 1 << 0;

	  reg_config = *(p_hc + 0);

	  while(reg_config == 0){
		  reg_config = *(p_hc + 0);
	  }

	  while( reg_config == 2){
		  reg_config = *(p_hc + 0);
		  i ++;
	  }
#ifndef SIM
	  printf("iFinal: %d\n", i);
#endif
	  i = 0;
	  usleep(100000);
  }
  return 0;
};
