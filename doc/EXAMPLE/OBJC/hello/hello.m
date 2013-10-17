/*
** HX-2013-10;
** An example of combining ATS and OBJC
*/

#include <objc/Object.h>

@interface Greeter:Object
{
  // no instance variable
}

- (void)greet;

@end

extern
void ATS_print_hello () ;

@implementation Greeter

- (void)greet
{
  ATS_print_hello(/*void*/) ;
}

@end

#import <Foundation/Foundation.h>

int main(void)
{
  id myGreeter;
  NSLog (@"Hello from NSLog") ;
  myGreeter=[Greeter new];
  [myGreeter greet];
  [myGreeter free];
  return 0;
}
