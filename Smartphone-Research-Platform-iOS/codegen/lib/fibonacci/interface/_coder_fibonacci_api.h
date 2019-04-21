/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_fibonacci_api.h
 *
 * MATLAB Coder version            : 3.2
 * C/C++ source code generated on  : 12-Feb-2017 22:18:35
 */

#ifndef _CODER_FIBONACCI_API_H
#define _CODER_FIBONACCI_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_fibonacci_api.h"

/* Type Definitions */
#ifndef struct_emxArray_real32_T
#define struct_emxArray_real32_T

struct emxArray_real32_T
{
  real32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real32_T*/

#ifndef typedef_emxArray_real32_T
#define typedef_emxArray_real32_T

typedef struct emxArray_real32_T emxArray_real32_T;

#endif                                 /*typedef_emxArray_real32_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void fibonacci(real32_T n, real32_T t1, real32_T t2, emxArray_real32_T
                      *fib_sequence);
extern void fibonacci_api(const mxArray * const prhs[3], const mxArray *plhs[1]);
extern void fibonacci_atexit(void);
extern void fibonacci_initialize(void);
extern void fibonacci_terminate(void);
extern void fibonacci_xil_terminate(void);

#endif

/*
 * File trailer for _coder_fibonacci_api.h
 *
 * [EOF]
 */
