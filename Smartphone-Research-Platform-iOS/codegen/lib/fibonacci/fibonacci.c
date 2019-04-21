/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: fibonacci.c
 *
 * MATLAB Coder version            : 3.2
 * C/C++ source code generated on  : 12-Feb-2017 22:18:35
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "fibonacci.h"
#include "fibonacci_emxutil.h"

/* Function Definitions */

/*
 * Arguments    : float n
 *                float t1
 *                float t2
 *                emxArray_real32_T *fib_sequence
 * Return Type  : void
 */
void fibonacci(float n, float t1, float t2, emxArray_real32_T *fib_sequence)
{
  int i;
  int loop_ub;
  i = fib_sequence->size[0] * fib_sequence->size[1];
  fib_sequence->size[0] = 1;
  fib_sequence->size[1] = (int)n;
  emxEnsureCapacity((emxArray__common *)fib_sequence, i, (int)sizeof(float));
  loop_ub = (int)n;
  for (i = 0; i < loop_ub; i++) {
    fib_sequence->data[i] = 0.0F;
  }

  fib_sequence->data[0] = t1;
  fib_sequence->data[1] = t2;
  for (i = 0; i < (int)(n + -2.0F); i++) {
    fib_sequence->data[(int)(3.0F + (float)i) - 1] = fib_sequence->data[(int)
      ((3.0F + (float)i) - 1.0F) - 1] + fib_sequence->data[(int)((3.0F + (float)
      i) - 2.0F) - 1];
  }
}

/*
 * File trailer for fibonacci.c
 *
 * [EOF]
 */
