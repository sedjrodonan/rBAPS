# Known pitfalls

The following behavioral differences have been detected between the Matlab functions and their R counterparts. In order to save time, these differences will not be addressed, since they could require extensive reworking of a function. However, such differences may very well cause unexpected problems in some situations, which is why compiling this list is so important. The tables below might provide a good starting point for identifying and fixing bugs.

As general remarks, one should keep in mind that:

- For compliance with IEC 60559, the `round` in base R rounds .5 to the nearest even integer, whereas the homonym function in Matlab rounds up (or down, if negative).
- Some clobal variables have been added as a new (last) argument to the function they appear in.
- When a function is defined on Matlab with multiple outputs, as in `[y1, y2] = f(x)`, it will output only `y1` if called without assignment, as in `f(3)`, or if called with a one-length assignment, as in `a = f(3)`. In order to receive the full output, one must assign two variables to the left side of the assignment operator, as in `[a, b] = f(3)`. rBAPS Functions that might be affected by this behavior include `etsiParas`.

## Some functional differences in rBAPS functions

| Function          | Argument           | Value          | Matlab output         | R output                        |
| ----------------- | ------------------ | -------------- | --------------------- | ------------------------------- |
| `ownNum2Str`      | `number`           | `NaN`          | `'NAN'`               | error                           |
| `ownNum2Str`      | `number`           | `<vector>`     | `'<vector elements>'` | `'<vector elements>'` + warning |
| `repmat`          | `length(n)`        | `> 2`          | > 2D matrix           | 2D matrix                       |

## Some functional differences in base Matlab functions

Function | Matlab output | R output
-------- | ------------- | --------
`max` | Can handle complex numbers | Cannot handle complex numbers

# Wanna help debugging?

If you find an error, one of the first things to try is to compare the R code with its MATLAB equivalent, which you can find [here](matlab). Some common causes are as follows:

## Using `()` to subset an object in R.

R uses `[]` for that, whereas Matlab uses `()` for both function calling and object subsetting. Therefore, often objects will be mistakenly interpreted as functions by R due to improper translation.

## Improper removal of a duplicate function

Homonymous functions were found on several files with code that, upon first inspection, are deemed identical. That might not always be the case (especially for large files, where visual inspection may be especially imperfect), so errors might have emerged from calling homonymous functions that are supposed to be slightly different.
