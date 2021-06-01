#ifndef F_CPU
#define F_CPU 1000000UL
#endif
#define D4 eS_PORTD4
#define D5 eS_PORTD5
#define D6 eS_PORTD6
#define D7 eS_PORTD7
#define RS eS_PORTC6
#define EN eS_PORTC7

#include <avr/io.h>
#include <util/delay.h>
#include <stdlib.h>
#include <string.h>
#include "lcd.h"


int main(void)
{
    uint8_t inp_L, inp_H;
	char val[5];
	char msg[15];
	
	DDRD = 0xFF;
	DDRC = 0xFF;
	
	ADMUX = 0b01000100; //01 -> Avcc = Vref, 0 -> ADLAR right, 00100 -> ADC4
	ADCSRA = 0b10000101; //1 -> ADEN, 101 -> 32 division factor
	
	Lcd4_Init();
	Lcd4_Set_Cursor(1,1);
	Lcd4_Write_String("Loading...");
	_delay_ms(300);
	Lcd4_Clear();
	
	
    while (1) 
    {	
		ADCSRA |= (1 << ADSC);
		while(ADCSRA & (1 << ADSC)) {;}
			
		inp_L = ADCL;
		inp_H = ADCH;
		
		float f = (( (inp_H << 8) + inp_L ) * 5 )/1024.0;
		dtostrf(f, 4, 2, val);
		
		strcpy(msg, "Voltage: ");
		strcat(msg, val);
		
		Lcd4_Set_Cursor(1,1);
		Lcd4_Write_String(msg);
		_delay_ms(200);
    }
	return 0;
}