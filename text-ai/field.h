#ifndef field_h
#define field_h
class Field{
public:
	int row, col;		// Field dimensions
	Field(int r, int c);	// Default constructor
	void display();		// Print field
};
#endif
