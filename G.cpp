#include <iostream>
#include  <stdio.h>
#include  <stdlib.h>
#include <dlfcn.h>
#include <string.h>
#include<map>
using namespace std;

struct handle
{
    string typ;     // typ
    void * handle1; // biblioteka
};

int main()
{
    map<string, handle > funkcje;
    string in;
    string liblary;
    char** tab;
    string nazwa;
    string typ;
    const char * info = "info";
    while(true) {

        cin >> in;

        if( in == "load")
        {
            cin >> liblary;
            char * liblary1 = new char[ liblary.size()+1];
            strcpy(liblary1, liblary.c_str());

            void* handle2 = dlopen( liblary1, RTLD_LAZY);   // otwieranie bilbioteki

            if(!handle2) {
                cout << "File not found!" << endl;
            }
            else {

               char** (*function1)();

               function1 = (char** (*)())dlsym(handle2 , info );    // wywolanie info

                tab = function1();

                int licznik = 0;

                while ( tab[licznik]!= NULL) {   // przypisanie do mapy funkcji

                    nazwa = tab[licznik];
                    typ = tab[licznik+1];

                    struct handle A;
                    A.typ = typ;
                    A.handle1 = handle2;
                    funkcje[nazwa] = A;

                    licznik += 2;
                }
            }

        }
        else
        {
            if( in == "end") break;

            else
            {

                if(funkcje[in].typ!="") { // sprawdzenie czy funckja istnieje

                    if (funkcje[in].typ == "int") {  // typ int

                        int  case1;
                        cin >> case1;
                        void (*function1)(int);

                        char * nazwa2 = new char[ in.size()+1];
                        strcpy(nazwa2, in.c_str());

                        function1 = (void (*)(int))dlsym(funkcje[in].handle1,nazwa2);
                        function1(case1);

                    }

                        if (funkcje[in].typ == "float") { // typ float

                            float  case1;
                            cin >> case1;

                            void (*function1)(float);

                            char * nazwa2 = new char[ in.size()+1];
                            strcpy(nazwa2, in.c_str());

                            function1 = (void (*)(float))dlsym(funkcje[in].handle1,nazwa2);
                            function1(case1);
                        }

                        if (funkcje[in].typ == "int[]") { // typ float

                            int  n;
                            cin >> n;

                            int *tab1 = new int[n];

                            for ( int i =0; i<n; i++) {
                                cin >> tab1[i];
                            }

                            void (*function1)(int, int*);

                            char * nazwa2 = new char[ in.size()+1];
                            strcpy(nazwa2, in.c_str());

                            function1 = (void (*)(int, int*))dlsym(funkcje[in].handle1,nazwa2);
                            function1(n,tab1);
                        }
                          if (funkcje[in].typ == "float[]") { // typ float

                            int  n;
                            cin >> n;

                            float *tab1 = new float[n];

                            for ( int i =0; i<n; i++) {
                                cin >> tab1[i];
                            }

                            void (*function1)(int, float*);

                            char * nazwa2 = new char[ in.size()+1];
                            strcpy(nazwa2, in.c_str());

                            function1 = (void (*)(int, float*))dlsym(funkcje[in].handle1,nazwa2);
                            function1(n,tab1);
                        }
                    }
                    else {
                    cout << "Function not found!" << endl;
                    }

                }
        }
    }

    return 0;
}

// Łukasz Wroński
