/*
 * 4-bit LED.c
 *
 * Created: 05-Apr-21 2:49:00 PM
 * Author : USER
 */ 


#define F_CPU 1000000 // 1 MHz clock speed


#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	  DDRB = 0b00001111; //outputs
	  DDRA = 0b00000001; //zero bit
	  DDRD = 0b00000000; //inputs
	  unsigned int count = 0;
	  PORTB = 0;
	  PORTA = 1;
	  unsigned int input;
	  while(1)
	  {
		input = PIND;
		if(input == 1)
		{
			count++;
			if(count == 16) count = 0;
		}
		else if(input == 2)
		{
			if(count == 0) count = 15;
			else count--;
			
		}
		else if(input == 4)
		{
			count = 0;
		}
		PORTB = count;
		if(count == 0) PORTA = 1;
		else PORTA = 0;
		_delay_ms(350);
	  }
}