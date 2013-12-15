#include <stdlib.h>
#include <cstdio>
#include "base64.h"
#include <iostream>
#include <fstream>

using namespace std;
//--------------------
// readFile
//--------------------
/*
 *  Reads a whole file into an array.
 *  Returns a string*
 *  Free it yourself!.
 */
string* readFile(const char* filename){
    FILE* fd  = fopen(filename, "rb");
    
    if (fd == NULL){
        perror("Can't fopen the file");
        exit(-1);
    }

    char* buffer;
    unsigned int fileSize = 0;

    fseek(fd, 0, SEEK_END);
    fileSize = ftell(fd);
    rewind(fd);

    
    buffer = (char*)calloc(1, fileSize + 1);

    if (buffer == NULL){
        perror("Memory allocation failed.");
        fclose(fd);
        exit(-1);
    }

    if (fread(buffer, fileSize, 1, fd) != 1){
        perror("Can't fread the file");
        fclose(fd);
        free(buffer);    
        buffer = NULL;
        return NULL;
    }

    printf("Filesize: %lld \n", (long long) fileSize);
    printf("Buffer: %s \n", buffer);


    string s = buffer;
    string* encoded = new string(base64_encode(reinterpret_cast<const unsigned char*>(s.c_str()), s.length()));

    if (fd != NULL){
        fclose(fd);
    }

   if (buffer != NULL) {
        free(buffer);
        buffer = NULL;
    }

    return encoded;
}


int main(int argc, char* argv[]){
    const char* filename = "a.txt";
    string* file = NULL;

    if (argc == 2){
        filename = argv[1];
    }
    
    file = readFile(filename);
    

    if (file != NULL) {
        cout << "Base64:: " << *file << endl;
        ofstream fstream;
        fstream.open ("output");
        fstream << *file;
        fstream.close();
        
        delete file;
        file = NULL;
    }

    return 0;
}
