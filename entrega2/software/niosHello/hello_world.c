#include <stdio.h>
#include <system.h>
#include <alt_types.h>
#include "altera_avalon_pio_regs.h"
#include <io.h> /* Leiutura e escrita no Avalon */

//#define PIO_1_BASE 0x81000

volatile alt_u32 butsw;

/* A variable to hold the value of any pio edge capture register. */
volatile int edge_capture;

int delay(int n){
	  unsigned int delay = 0 ;
	  while(delay < n){
		  delay++;
	  }
}

int main(void){
  unsigned int led = 0;
  printf("Embarcados++ \n");

  init_pio();
  while(1){
	  if (led <= 5){
		  IOWR_32DIRECT(PIO_0_BASE, 0, 0x01 << led++);
		  usleep(50000);
	  }
	  else{
		  led = 0;
	  }
  };

  return 0;
}

//0: Botao pressionado
//1: CHaves 0 e botao normal
//Outros - 1: BInario resultante de qual chave ta ativada

void handle_button_interrupts(void* context, alt_u32 id){
	/* Cast context to edge_capture's type. It is important that this be
     * declared volatile to avoid unwanted compiler optimization.
	*/
	printf("Button or SW interruption \n");
	volatile int* edge_capture_ptr = (volatile int*) context;
	/* Store the value in the Button's edge capture register in *context. */
	*edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE);
	butsw = IORD_32DIRECT(PIO_1_BASE, 0);
	printf("butsw: %d \n", butsw);
	/* Reset the Button's edge capture register. */
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0);
}

void init_pio(){
	/* Recast the edge_capture pointer to match the alt_irq_register() function
	* prototype. */
	void* edge_capture_ptr = (void*) &edge_capture;
	/* Enable first four interrupts. */
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_1_BASE, 0xf);
	/* Reset the edge capture register. */
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0x0);
	/* Register the interrupt handler. */
	alt_irq_register( PIO_1_IRQ, edge_capture_ptr,
				   handle_button_interrupts );
}
