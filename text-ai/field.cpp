#include "field.h"
#include <iostream>
using namespace std;

Field::Field(int r, int c){
			row = r;
			c = c;
	}

void Field::display(){
	cout << "Calling field's display\n";
}