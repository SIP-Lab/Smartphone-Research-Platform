//
// Created by Abhishek Sehgal on 2/23/17.
//

#include "FIR.h"
void FIR(float* input, float* output, int nSamples) {
    int i = 0;

    static float endSamples[2] = {0,0};

    for (i = nSamples - 1; i > 1; i--) {
        output[i] = (input[i] + input[i - 1] + input[i - 2])/3;
    }

    output[1] = (input[1] + input[0] + endSamples[1])/3;
    output[0] = (input[0] + endSamples[1] + endSamples[0])/3;

    endSamples[1] = input[nSamples - 1];
    endSamples[0] = input[nSamples - 2];

}