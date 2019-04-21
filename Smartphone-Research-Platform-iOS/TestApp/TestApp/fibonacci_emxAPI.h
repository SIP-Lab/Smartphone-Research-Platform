/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: fibonacci_emxAPI.h
 *
 * MATLAB Coder version            : 3.2
 * C/C++ source code generated on  : 12-Feb-2017 22:18:35
 */

#ifndef FIBONACCI_EMXAPI_H
#define FIBONACCI_EMXAPI_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rtwtypes.h"
#include "fibonacci_types.h"

/* Function Declarations */
extern emxArray_real32_T *emxCreateND_real32_T(int numDimensions, int *size);
extern emxArray_real32_T *emxCreateWrapperND_real32_T(float *data, int
  numDimensions, int *size);
extern emxArray_real32_T *emxCreateWrapper_real32_T(float *data, int rows, int
  cols);
extern emxArray_real32_T *emxCreate_real32_T(int rows, int cols);
extern void emxDestroyArray_real32_T(emxArray_real32_T *emxArray);
extern void emxInitArray_real32_T(emxArray_real32_T **pEmxArray, int
  numDimensions);

#endif

/*
 * File trailer for fibonacci_emxAPI.h
 *
 * [EOF]
 */
