CC = g++
# for gcc
#CFLAGS = -g -O2
# for clang
CFLAGS = 

OBJECTS = main.o options.o
TARGET = main
main : $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o main

%.o : %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	$(RM) $(TARGET)
	$(RM) $(OBJECTS)
