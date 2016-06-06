#include "field.h"
#include <iostream>
using namespace std;

Field::Field(int r, int c){
			row = r;
			col = c;
	}

void Field::display(){
/*
	Print field with asterisks
*/
	cout << "Calling field's display\n";
	for(int i = 0; i < row; i++){
		for(int j = 0; j < col; j++){
			cout << "*";
		}
		cout << "\n";
	}
}
