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
#include "lcd.h"


int main(void)
{
    ///uint8_t inp_L, inp_H;
	//unsigned char res;
	
	DDRD = 0xFF;
	DDRC = 0xFF;
	
	ADMUX = 0b01000100;
	ADCSRA = 0b10000101;
	
	Lcd4_Init();
	Lcd4_Set_Cursor(1,1);
	Lcd4_Write_String("Loading...");
	_delay_ms(500);
	
	
    while (1) 
    {		
		//Lcd4_Set_Cursor(1,1);
		Lcd4_Clear();
		Lcd4_Write_String("hehe");
		_delay_ms(200);
		
		ADCSRA |= (1 << ADSC);
		while(ADCSRA & (1 << ADSC)) {;}
			
		//res = ADCL;
		//res = ADCH;
		
		Lcd4_Clear();
		//Lcd4_Set_Cursor(1,1);
		Lcd4_Write_String("vodox");
		
		_delay_ms(200);
    }
	return 0;
}