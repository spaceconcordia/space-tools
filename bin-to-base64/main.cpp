#include <stdlib.h>
#include <cstdio>


//--------------------
// readFile
//--------------------
/*
 *  Reads a whole file into an array.
 *  Returns a char*
 *  Free it yourself!.
 */
char* readFile(const char* filename){
    FILE* fd  = fopen(filename, "rb");
    
    if (fd == NULL){
        perror("Can't fopen the file");
        exit(-1);
    }

    char* buffer;
    int fileSize = 0;

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
    }

    if (fd != NULL){
        fclose(fd);
    }


    return buffer;
}


int main(int argc, char* argv[]){
    const char* filename = "a.txt";
    char* file = NULL;

    if (argc == 2){
        filename = argv[1];
    }
    
    file = readFile(filename);
    
    printf("%s\n", file);

    if (file != NULL){
        free(file);
        file = NULL;
    }

    return 0;
}
