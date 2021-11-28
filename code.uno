int vcc2 = 2;


int red_light_pin= 3;
int green_light_pin = 5;
int blue_light_pin = 6;

//include servo
#include <Servo.h>
Servo myservo;
int pos = 0;

#include <Stepper.h>
 
#define STEPS 30
 
#define IN1  8
#define IN2  9
#define IN3  10
#define IN4  11
 


Stepper stepper(STEPS, 8, 10, 9, 11);


#define joystick  A0
#define joystick2  A1


void setup()
{
  
  myservo.attach(12); 
  Serial.begin (9600);
  pinMode(red_light_pin, OUTPUT);
  pinMode(green_light_pin, OUTPUT);
  pinMode(blue_light_pin, OUTPUT);
  pinMode(vcc2, OUTPUT);
  digitalWrite(vcc2, HIGH);
  }
void RGB_color(int red_light_value, int green_light_value, int blue_light_value)
 {
  analogWrite(red_light_pin, red_light_value);
  analogWrite(green_light_pin, green_light_value);
  analogWrite(blue_light_pin, blue_light_value);
}


void loop()
{
  
  
  int val = analogRead(joystick);
  int joystickXVal = analogRead(joystick2) ;
 
 
  if(  (val > 497) && (val < 523) )
  {
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, LOW);
    digitalWrite(IN3, LOW);
    digitalWrite(IN4, LOW);
    RGB_color(0, 0, 0);
    
  }
 
  else
  {
   
    while (val >= 523)
    {
      
     int speed_ = map(val, 523, 1023, 5, 500);
      //int speed_ = map(val, 523, 1023, 5, 10);
         Serial.print(val);
       Serial.print("uuuuuu");
       Serial.println(speed_);
        
     RGB_color(21, 204, 0); // RED
      
      stepper.setSpeed(speed_);
 
      
      stepper.step(30);
 
      val = analogRead(joystick);
    }
 
   
    while (val <= 500)
    {
      
      int speed_ = map(val, 500, 0, 5, 500);
     
       Serial.print(val);
       Serial.print("****");
       Serial.println(speed_);
       Serial.println(speed_);
      // set motor speed
      stepper.setSpeed(speed_);
      
      RGB_color(255, 255, 255); // Bleu
  
      stepper.step(-30);
     
      val = analogRead(joystick);
    }
 
  }
 delay(20);                    
  //read joystick input on pin A1
 if (joystickXVal >= 220)
 {
 Serial.print(joystickXVal);                //print the value from A1
 Serial.println(" = input from joystick");  //print "=input from joystick" next to the value
 Serial.print((joystickXVal+520)/10.29);       //print a from A1 calculated, scaled value
 Serial.println(" = output to servo");      //print "=output to servo" next to the value
 Serial.println() ;
 myservo.write((joystickXVal+520)/10.29);      //write the calculated value to the servo  
}
 if (joystickXVal >= 523)
 {
  RGB_color(0, 123, 73);
  }      
  if (joystickXVal <= 523)
 {
  RGB_color(0, 2, 145);
  }      
 }          
