#include "options.h"
#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
using namespace std;

void display_field(int row, int col){
// Print empty tetris field of size (row, col)
	for(int i = 0; i < row; i++){
		for(int j = 0; j < col; j++){
			cout << "*";
		}
		cout << "\n";
	}
}

void options(){
// Ask user to open data file or enter dimensions
	cout << "Enter data filepath or field dimensions\n";
	cout << "dimensions: <width> <height>\n";
	cout << "> ";
	string input;
	cin >> input;
	istringstream input_ss(input);	
	int row, col; 
	input_ss >> row >> col;		// Should parse string into 2 ints
					//  but not working
	row = 20; 			// Use dummy values for now
	col = 10;
	cout << "row = " << row;
	cout << "\ncol = " << col << "\n";
	display_field(row, col);	// Draw empty field	
}
