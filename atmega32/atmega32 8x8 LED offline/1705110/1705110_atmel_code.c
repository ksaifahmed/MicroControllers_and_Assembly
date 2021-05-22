/*
 * 8x8 LED Atmel.c
 *
 * Created: 12-Apr-21 8:59:30 PM
 * Author : USER
 */ 
#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

volatile uint8_t mode = 0;

ISR(INT2_vect)
{
	if(mode) mode = 0;
	else mode = 1;
}

int main(void)
{
    DDRC = 0xFF;
	DDRD = 0xFF;

	unsigned int row[2][8] = {
		{0b10111101, 0b11011110, 0b01101111, 0b10110111, 0b11011011, 0b11101101, 0b11110110, 0b01111011},
		{0b10000001, 0b11000000, 0b01100000, 0b00110000, 0b00011000, 0b00001100, 0b00000110, 0b00000011}
	};
	unsigned int idx =  0, j = 0;
	
	MCUCSR = (1<<JTD);
	MCUCSR = (1<<JTD);
	
	//interrupt
	GICR = (1<<INT2); //or 0b00100000
	MCUCSR &= 0b10111111;
	sei();
	
    while (1) 
    {
		for(j = 0; j < 30; j++)
		{
			PORTC = 4;
			PORTD = row[0][idx];
			_delay_ms(2);

			PORTC = 8;
			PORTD = row[1][idx];
			_delay_ms(2);
					
			PORTC = 16;
			PORTD = row[1][idx];
			_delay_ms(2);
					
			PORTC = 32;
			PORTD = row[0][idx];
			_delay_ms(2);
		}
		
		if(mode)
		{
			idx++;
			if(idx == 8) idx = 0;
		}
		_delay_ms(10);	
	}
}

