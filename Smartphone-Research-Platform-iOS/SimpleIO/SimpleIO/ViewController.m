//
//  ViewController.m
//  SimpleIO
//
//  Created by Abhishek Sehgal on 2/14/17.
//  Copyright © 2017 default. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioUnit/AudioUnit.h>
#import "FIR.h"

#define kOutputBus 0
#define kInputBus 1
#define SHORT2FLOAT 1/32768.0
#define FLOAT2SHORT 32768.0;

#define FRAMESIZE 512
#define SAMPLINGFREQUENCY 48000

#ifndef min
#define min( a, b ) ( ((a) < (b)) ? (a) : (b) )
#endif

AudioUnit au;
AudioBuffer tempBuffer;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: NULL];
    [[AVAudioSession sharedInstance] setMode: AVAudioSessionModeMeasurement error:NULL];
    [[AVAudioSession sharedInstance] setPreferredSampleRate:SAMPLINGFREQUENCY error:NULL];
    [[AVAudioSession sharedInstance] setPreferredIOBufferDuration:(float)FRAMESIZE/(float)SAMPLINGFREQUENCY error:NULL];
    
    AudioComponentDescription desc;
    desc.componentType = kAudioUnitType_Output;
    desc.componentSubType = kAudioUnitSubType_RemoteIO;
    desc.componentFlags = 0;
    desc.componentFlagsMask = 0;
    desc.componentManufacturer = kAudioUnitManufacturer_Apple;
    AudioComponent component = AudioComponentFindNext(NULL, &desc);
    if (AudioComponentInstanceNew(component, &au) != 0) abort();
    
    
    UInt32 value = 1;
    if (AudioUnitSetProperty(au, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, 0, &value, sizeof(value))) abort();
    value = 1;
    if (AudioUnitSetProperty(au, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input, 1, &value, sizeof(value))) abort();
    
    AudioStreamBasicDescription format;
    format.mSampleRate  = 0;
    format.mFormatID = kAudioFormatLinearPCM;
    format.mFormatFlags = kAudioFormatFlagIsSignedInteger;
    format.mFramesPerPacket = 1;
    format.mChannelsPerFrame	   = 1;
    format.mBitsPerChannel	   = 16;
    format.mBytesPerPacket	   = 2;
    format.mBytesPerFrame	   = 2;
    if (AudioUnitSetProperty(au, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &format, sizeof(format))) abort();
    if (AudioUnitSetProperty(au, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, 1, &format, sizeof(format))) abort();
    
    // Set input callback
    AURenderCallbackStruct callbackStruct;
    callbackStruct.inputProc = recordingCallback;
    callbackStruct.inputProcRefCon = (__bridge void *)(self);
    AudioUnitSetProperty(au,
                         kAudioOutputUnitProperty_SetInputCallback,
                         kAudioUnitScope_Global,
                         kInputBus,
                         &callbackStruct,
                         sizeof(callbackStruct));
    
    // Set output callback
    callbackStruct.inputProc = playbackCallback;
    callbackStruct.inputProcRefCon = (__bridge void *)(self);
    AudioUnitSetProperty(au,
                         kAudioUnitProperty_SetRenderCallback,
                         kAudioUnitScope_Global,
                         kOutputBus,
                         &callbackStruct,
                         sizeof(callbackStruct));
    tempBuffer.mNumberChannels = 1;
    tempBuffer.mDataByteSize = FRAMESIZE * 2;
    tempBuffer.mData = malloc( FRAMESIZE * 2 );
    
    
    AudioUnitInitialize(au);
    
    AudioOutputUnitStart(au);
}

static OSStatus playbackCallback(void *inRefCon,
                                 AudioUnitRenderActionFlags *ioActionFlags,
                                 const AudioTimeStamp *inTimeStamp,
                                 UInt32 inBusNumber,
                                 UInt32 inNumberFrames,
                                 AudioBufferList *ioData) {
    
    for (int i=0; i < ioData->mNumberBuffers; i++) {
        AudioBuffer buffer = ioData->mBuffers[i];
        UInt32 size = min(buffer.mDataByteSize, tempBuffer.mDataByteSize);
        memcpy(buffer.mData, tempBuffer.mData, size);
        buffer.mDataByteSize = size;
    }
    return noErr;
}

static OSStatus recordingCallback(void *inRefCon,
                                  AudioUnitRenderActionFlags *ioActionFlags,
                                  const AudioTimeStamp *inTimeStamp,
                                  UInt32 inBusNumber,
                                  UInt32 inNumberFrames,
                                  AudioBufferList *ioData) {
    
    AudioBuffer buffer;
    ViewController* view = (__bridge ViewController *)(inRefCon);
    
    buffer.mNumberChannels = 1;
    buffer.mDataByteSize = inNumberFrames * 2;
    buffer.mData = malloc( inNumberFrames * 2 );
    
    // Put buffer in a AudioBufferList
    AudioBufferList bufferList;
    bufferList.mNumberBuffers = 1;
    bufferList.mBuffers[0] = buffer;
    
    AudioUnitRender(au,
                    ioActionFlags,
                    inTimeStamp,
                    inBusNumber,
                    inNumberFrames,
                    &bufferList);
    
    [view processAudio:&bufferList];
    
    
    return noErr;
}


- (void) processAudio: (AudioBufferList*) bufferList{
    
    AudioBuffer sourceBuffer = bufferList->mBuffers[0];
    short *buffer = (short*)malloc(sourceBuffer.mDataByteSize), *output = (short*)malloc(sourceBuffer.mDataByteSize);
    float *input = (float*)malloc(sizeof(float*) * 512), *float_output = (float*)malloc(sizeof(float*) * 512);
    
    memcpy(buffer, bufferList->mBuffers[0].mData, bufferList->mBuffers[0].mDataByteSize);
    
    
    for (int i = 0; i < 512; i++) {
        input[i] = buffer[i] * SHORT2FLOAT;
    }
    
    FIR(input, float_output, FRAMESIZE);
    
    for (int i = 0; i < 512; i++) {
        output[i] = float_output[i] * FLOAT2SHORT;
    }
    
    if (tempBuffer.mDataByteSize != sourceBuffer.mDataByteSize) {
        free(tempBuffer.mData);
        tempBuffer.mDataByteSize = sourceBuffer.mDataByteSize;
        tempBuffer.mData = malloc(sourceBuffer.mDataByteSize);
    }
    
    memcpy(tempBuffer.mData, output, bufferList->mBuffers[0].mDataByteSize);
    free(buffer);
    free(output);
    free(float_output);
    free(input);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
