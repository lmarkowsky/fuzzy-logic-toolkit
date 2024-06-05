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
## @deftypefn {Function File} {@var{retval} =} bounded_difference (@var{x})
## @deftypefnx {Function File} {@var{retval} =} bounded_difference (@var{x}, @var{y})
##
## Return the bounded difference of the input.
## The bounded difference of two real scalars x and y is: max (0, x + y - 1)
##
## For one vector argument, apply the bounded difference to all of the elements
## of the vector. (The bounded difference is associative.) For one
## two-dimensional matrix argument, return a vector of the bounded difference
## of each column.
##
## For two vectors or matrices of identical dimensions, or for one scalar and
## one vector or matrix argument, return the pair-wise bounded difference.
##
## @seealso{algebraic_product, algebraic_sum, bounded_sum, drastic_product, drastic_sum, einstein_product, einstein_sum, hamacher_product, hamacher_sum}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy bounded_difference
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      bounded_difference.m
## Last-Modified: 29 May 2024

function retval = bounded_difference (x, y = 0)
  if ((nargin != 1) && (nargin != 2))
    error ("bounded_difference requires 1 or 2 arguments\n");
  elseif (!(isreal (x) && isreal (y)))
    error ("bounded_difference requires real scalar or matrix arguments\n");
  elseif (nargin == 2 && ...
          (isscalar (x) || isscalar (y) || ...
           isequal (size (x), size (y))))
    retval = max (0, (x + y - 1));
  elseif (nargin == 1 && isvector (x))
    retval = bounded_difference_of_vector (x);
  elseif (nargin == 1 && ndims (x) == 2)
    num_cols = columns (x);
    retval = zeros (1, num_cols);
    for i = 1 : num_cols
      retval(i) = bounded_difference_of_vector (x(:, i));
    endfor
  else
    error ("invalid arguments to function bounded_difference\n");
  endif
endfunction

function retval = bounded_difference_of_vector (real_vector)
  x = 1;
  for i = 1 : length (real_vector)
    y = real_vector(i);
    x = max (0, (x + y - 1));
  endfor
  retval = x;
endfunction

%!test
%! x = [5 2];
%! z = bounded_difference(x);
%! assert(z, 6);

%!test
%! x = [5 2 3 -6];
%! y = [-1 0 2 3];
%! z = bounded_difference(x, y);
%! assert(z, [3 1 4 0]);

## Test input validation
%!error <bounded_difference requires 1 or 2 arguments>
%! bounded_difference()
%!error <bounded_difference: function called with too many inputs>
%! bounded_difference(1, 2, 3)
%!error <bounded_difference requires real scalar or matrix arguments>
%! bounded_difference(2j)
%!error <bounded_difference requires real scalar or matrix arguments>
%! bounded_difference(1, 2j)
%!error <bounded_difference requires real scalar or matrix arguments>
%! bounded_difference([1 2j])
%!error <invalid arguments to function bounded_difference>
%! bounded_difference([1 2], [1 2 3])
%!error <invalid arguments to function bounded_difference>
%! bounded_difference([1 2], [1 2; 3 4])
%!error <invalid arguments to function bounded_difference>
%! bounded_difference(0:100, [])

