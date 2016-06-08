#include "options.h"
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include "field.h"
using namespace std;

void default_field(){
/*
Create field with default size of 20x10
*/
	Field field(20, 10);
	field.display();
}

void options(){
/* 
Ask user to open data file or enter dimensions
*/
	cout << "Enter data filepath or field dimensions\n";
	cout << "dimensions: <width> <height>\n";
	cout << "> ";
	string input;
	int row, col; 
	cin >> row >> col;
	cout << "row = " << row;
	cout << "\ncol = " << col << "\n";
	Field f(row, col);
	f.display();
}

void process_file(){
// Process text file to get field object
}

void input_field(){
/*
Open text file and create field based on it
task: read data from file after opening
*/
	Field field(20, 10);
	ifstream input;
	input.open("input_field");
	input.close();
}
