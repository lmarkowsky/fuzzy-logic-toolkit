## Copyright (C) 2011-2025 L. Markowsky <lmarkowsky@gmail.com>
##
## This file is part of the fuzzy-logic-toolkit.
##
## The fuzzy-logic-toolkit is free software; you can redistribute it
## and/or modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; either version 3 of
## the License, or (at your option) any later version.
##
## The fuzzy-logic-toolkit is distributed in the hope that it will be
## useful, but WITHOUT ANY WARRANTY; without even the implied warranty
## of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with the fuzzy-logic-toolkit; see the file COPYING.  If not,
## see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} drastic_sum (@var{x})
## @deftypefnx {Function File} {@var{retval} =} drastic_sum (@var{x}, @var{y})
##
## Return the drastic sum of the input.
##
## The drastic sum of two real scalars x and y is:
##
## @verbatim
##     max (x, y)     if min (x, y) == 0
##     1              otherwise
## @end verbatim
##
## For one vector argument, apply the drastic sum to all of the elements
## of the vector. (The drastic sum is associative.) For one
## two-dimensional matrix argument, return a vector of the drastic sum
## of each column.
##
## For two vectors or matrices of identical dimensions, or for one scalar and
## one vector or matrix argument, return the pairwise drastic sum.
##
## @seealso{algebraic_product, algebraic_sum, bounded_difference, bounded_sum, drastic_product, einstein_product, einstein_sum, hamacher_product, hamacher_sum}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy drastic_sum
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      drastic_sum.m
## Last-Modified: 26 Jul 2024

function retval = drastic_sum  (x, y = 0)
  if (nargin == 0 || nargin > 2 ||
      !is_real_matrix (x) || !is_real_matrix (y))
    error ("invalid arguments to function drastic_sum\n");

  elseif (nargin == 1)
    if (isvector (x))
      retval = vector_arg (x);
    elseif (ndims (x) == 2)
      retval = matrix_arg (x);
    else
      error ("invalid arguments to function drastic_sum\n");
    endif

  elseif (nargin == 2)
    if (isequal (size (x), size (y)))
      retval = arrayfun (@scalar_args, x, y);
    elseif (isscalar (x) && ismatrix (y))
      x = x * ones (size (y));
      retval = arrayfun (@scalar_args, x, y);
    elseif (ismatrix (x) && isscalar (y))
      y = y * ones (size (x));
      retval = arrayfun (@scalar_args, x, y);
    else
      error ("invalid arguments to function drastic_sum\n");
    endif
  endif
endfunction

function retval = scalar_args (x, y)
  if (min (x, y) == 0)
    retval = max (x, y);
  else
    retval = 1;
  endif
endfunction

function retval = vector_arg (x)
  if (isempty (x))
    retval = 0;
  elseif (min (x) == 0)
    retval = max (x);
  else
    retval = 1;
  endif
endfunction

function retval = matrix_arg (x)
  num_cols = columns (x);
  retval = zeros (1, num_cols);
  for i = 1 : num_cols
    retval(i) = vector_arg (x(:, i));
  endfor
endfunction

%!test
%! x = [0.5 0.2];
%! z = drastic_sum(x);
%! assert(z, 1);

%!test
%! x = [0.5 0.2 0.3 1];
%! y = [1 0 0.2 0.3];
%! z = drastic_sum(x, y);
%! assert(z, [1 0.2 1 1]);

## Test input validation
%!error <invalid arguments to function drastic_sum>
%! drastic_sum()
%!error <drastic_sum: function called with too many inputs>
%! drastic_sum(1, 2, 3)
%!error <invalid arguments to function drastic_sum>
%! drastic_sum(2j)
%!error <invalid arguments to function drastic_sum>
%! drastic_sum(1, 2j)
%!error <invalid arguments to function drastic_sum>
%! drastic_sum([1 2j])
%!error <invalid arguments to function drastic_sum>
%! drastic_sum([1 2], [1 2 3])
%!error <invalid arguments to function drastic_sum>
%! drastic_sum([1 2], [1 2; 3 4])
%!error <invalid arguments to function drastic_sum>
%! drastic_sum(0:100, [])

