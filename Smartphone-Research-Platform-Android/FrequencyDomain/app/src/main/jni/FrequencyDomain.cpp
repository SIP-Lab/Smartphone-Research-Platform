#include <jni.h>
#include <stdlib.h>
#include <SuperpoweredFrequencyDomain.h>
#include <AndroidIO/SuperpoweredAndroidAudioIO.h>
#include <SuperpoweredSimple.h>
#include <SuperpoweredCPU.h>
#include <SLES/OpenSLES.h>
#include <SLES/OpenSLES_AndroidConfiguration.h>

// To Call C functions
extern "C" {
#include "FIR.h"
}


// Globally declared audio buffers
static float *inputBufferFloat, *leftInputBuffer, *rightInputBuffer, *leftOutputBuffer, *rightOutputBuffer;

// This is called periodically by the media server.
static bool audioProcessing(void * __unused clientdata, short int *audioInputOutput, int numberOfSamples, int __unused samplerate) {

    SuperpoweredShortIntToFloat(audioInputOutput, inputBufferFloat,numberOfSamples, 2);
    SuperpoweredDeInterleave(inputBufferFloat, leftInputBuffer, rightInputBuffer, numberOfSamples);
    FIR(leftInputBuffer, leftOutputBuffer, numberOfSamples);
    FIR(rightInputBuffer, rightOutputBuffer, numberOfSamples);
    SuperpoweredFloatToShortIntInterleave(leftOutputBuffer, rightOutputBuffer, audioInputOutput, numberOfSamples);


    return true;
}

extern "C" JNIEXPORT void Java_com_superpowered_frequencydomain_MainActivity_FrequencyDomain(JNIEnv * __unused javaEnvironment, jobject __unused obj, jint samplerate, jint buffersize) {


    inputBufferFloat = (float *)malloc(buffersize * sizeof(float) * 2 + 128);
    leftInputBuffer = (float *)malloc(buffersize * sizeof(float) + 128);
    rightInputBuffer = (float *)malloc(buffersize * sizeof(float) + 128);
    leftOutputBuffer = (float *)malloc(buffersize * sizeof(float) + 128);
    rightOutputBuffer = (float *)malloc(buffersize * sizeof(float) + 128);

    SuperpoweredCPU::setSustainedPerformanceMode(true);
    new SuperpoweredAndroidAudioIO(samplerate, buffersize, true, true, audioProcessing, NULL, -1, SL_ANDROID_STREAM_MEDIA, buffersize * 2); // Start audio input/output.
}
