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
## @deftypefn {Function File} {@var{retval} =} hamacher_product (@var{x})
## @deftypefnx {Function File} {@var{retval} =} hamacher_product (@var{x}, @var{y})
##
## Return the Hamacher product of the input.
## The Hamacher product of two real scalars x and y is:
## (x * y) / (x + y - x * y)
##
## For one vector argument, apply the Hamacher product to all of the elements
## of the vector. (The Hamacher product is associative.) For one
## two-dimensional matrix argument, return a vector of the Hamacher product
## of each column.
##
## For two vectors or matrices of identical dimensions, or for one scalar and
## one vector or matrix argument, return the pair-wise Hamacher product.
##
## @seealso{algebraic_product, algebraic_sum, bounded_difference, bounded_sum, drastic_product, drastic_sum, einstein_product, einstein_sum, hamacher_sum}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy hamacher_product
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      hamacher_product.m
## Last-Modified: 29 May 2024

function retval = hamacher_product (x, y = 0)
  if (nargin == 0 || nargin > 2 ||
      !is_real_matrix (x) || !is_real_matrix (y))
    error ("invalid arguments to function hamacher_product\n");

  elseif (nargin == 1)
    if (isvector (x))
      retval = vector_arg (x);
    elseif (ndims (x) == 2)
      retval = matrix_arg (x);
    else
      error ("invalid arguments to function hamacher_product\n");
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
      error ("invalid arguments to function hamacher_product\n");
    endif
  endif
endfunction

function retval = scalar_args (x, y)
  retval = (x * y) / (x + y - x * y);
endfunction

function retval = vector_arg (real_vector)
  x = 1;
  for i = 1 : length (real_vector)
    y = real_vector(i);
    if (x == 0 && y == 0)
      x = 0;
    else
      x = (x * y) / (x + y - x * y);
    endif
  endfor
  retval = x;
endfunction

function retval = matrix_arg (x)
  num_cols = columns (x);
  retval = zeros (1, num_cols);
  for i = 1 : num_cols
    retval(i) = vector_arg (x(:, i));
  endfor
endfunction

%!test
%! x = [5 3];
%! z = hamacher_product(x);
%! assert(z, -2.1429, 1e-4);

%!test
%! x = [5 2 3 6];
%! y = [-1 1 2 3];
%! z = hamacher_product(x, y);
%! assert(z, [-0.5556 2.0000 -6.0000 -2.0000], 1e-4);

## Test input validation
%!error <invalid arguments to function hamacher_product>
%! hamacher_product()
%!error <invalid arguments to function hamacher_product>
%! hamacher_product(2j)
%!error <invalid arguments to function hamacher_product>
%! hamacher_product(1, 2j)
%!error <invalid arguments to function hamacher_product>
%! hamacher_product([1 2j])
%!error <hamacher_product: function called with too many inputs>
%! hamacher_product(1, 2, 3)
%!error <invalid arguments to function hamacher_product>
%! hamacher_product([1 2], [1 2 3])
%!error <invalid arguments to function hamacher_product>
%! hamacher_product([1 2], [1 2; 3 4])
%!error <invalid arguments to function hamacher_product>
%! hamacher_product(0:100, [])

