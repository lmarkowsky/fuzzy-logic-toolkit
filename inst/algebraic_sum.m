## Copyright (C) 2011-2024 L. Markowsky <lmarkov@users.sourceforge.net>
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
## @deftypefn {Function File} {@var{retval} =} algebraic_sum (@var{x, y})
## @deftypefnx {Function File} {@var{retval} =} algebraic_sum (@var{x, y})
##
## Return the algebraic sum of the input.
## The algebraic sum of two real scalars x and y is: x + y - x * y
##
## For one vector argument, apply the algebraic sum to all of elements of
## the vector. (The algebraic sum is associative.) For one two-dimensional
## matrix argument, return a vector of the algebraic sum of each column.
##
## For two vectors or matrices of identical dimensions, or for one scalar and
## one vector or matrix argument, return the pairwise algebraic sum.
##
## @seealso{algebraic_product, bounded_difference, bounded_sum, drastic_product, drastic_sum, einstein_product, einstein_sum, hamacher_product, hamacher_sum}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy algebraic_sum
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      algebraic_sum.m
## Last-Modified: 26 Jul 2024

function retval = algebraic_sum (x, y = 0)
  if ((nargin != 1) && (nargin != 2))
    error ("algebraic_sum requires 1 or 2 arguments\n");
  elseif (!(isreal (x) && isreal (y)))
    error ("algebraic_sum requires real scalar or matrix arguments\n");
  elseif (nargin == 2 && ...
          (isscalar (x) || isscalar (y) || ...
           isequal (size (x), size (y))))
    retval = x + y - x .* y;
  elseif (nargin == 1 && isvector (x))
    retval = algebraic_sum_of_vector (x);
  elseif (nargin == 1 && ndims (x) == 2)
    num_cols = columns (x);
    retval = zeros (1, num_cols);
    for i = 1 : num_cols
      retval(i) = algebraic_sum_of_vector (x(:, i));
    endfor
  else
    error ("invalid arguments to function algebraic_sum\n");
  endif
endfunction

function retval = algebraic_sum_of_vector (real_vector)
  x = 0;
  for i = 1 : length (real_vector)
    y = real_vector(i);
    x = x + y - x * y;
  endfor
  retval = x;
endfunction

%!test
%! x = [5 2];
%! z = algebraic_sum(x);
%! assert(z, -3);

%!test
%! x = [5 2 3 6];
%! y = [-1 0 2 3];
%! z = algebraic_sum(x, y);
%! assert(z, [9 2 -1 -9]);

## Test input validation
%!error <algebraic_sum requires 1 or 2 arguments>
%! algebraic_sum()
%!error <algebraic_sum: function called with too many inputs>
%! algebraic_sum(1, 2, 3)
%!error <algebraic_sum requires real scalar or matrix arguments>
%! algebraic_sum(2j)
%!error <algebraic_sum requires real scalar or matrix arguments>
%! algebraic_sum(1, 2j)
%!error <algebraic_sum requires real scalar or matrix arguments>
%! algebraic_sum([1 2j])
%!error <invalid arguments to function algebraic_sum>
%! algebraic_sum([1 2], [1 2 3])
%!error <invalid arguments to function algebraic_sum>
%! algebraic_sum([1 2], [1 2; 3 4])
%!error <invalid arguments to function algebraic_sum>
%! algebraic_sum(0:100, [])

