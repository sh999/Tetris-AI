CC = g++
CFLAGS = -g -O2
OBJECTS = main.o options.o
TARGET = main
main : $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o main

%.o : %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	$(RM) $(TARGET)
