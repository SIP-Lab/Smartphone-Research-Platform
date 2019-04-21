/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: fibonacci_emxutil.h
 *
 * MATLAB Coder version            : 3.2
 * C/C++ source code generated on  : 12-Feb-2017 22:18:35
 */

#ifndef FIBONACCI_EMXUTIL_H
#define FIBONACCI_EMXUTIL_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rtwtypes.h"
#include "fibonacci_types.h"

/* Function Declarations */
extern void emxEnsureCapacity(emxArray__common *emxArray, int oldNumel, int
  elementSize);
extern void emxFree_real32_T(emxArray_real32_T **pEmxArray);
extern void emxInit_real32_T(emxArray_real32_T **pEmxArray, int numDimensions);

#endif

/*
 * File trailer for fibonacci_emxutil.h
 *
 * [EOF]
 */
