CC=g++
CFLAGS=-Wall
DEBUGFLAGS=-ggdb -g -gdwarf-2 -g3 #gdwarf-2 + g3 provides macro info to gdb
INCPATH=-I./include/
LIBPATH=-L./lib/

buildPC:
	        $(CC) $(CFLAGS) $(INCPATH) $(LIBPATH) $(DEBUGFLAGS) -DPC src/*.cpp -o bin/bin-to-base64
