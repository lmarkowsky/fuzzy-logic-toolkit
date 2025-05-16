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
## @deftypefn {Function File} {@var{retval} =} einstein_product (@var{x})
## @deftypefnx {Function File} {@var{retval} =} einstein_product (@var{x}, @var{y})
##
## Return the Einstein product of the input.
## The Einstein product of two real scalars x and y is:
## (x * y) / (2 - (x + y - x * y))
##
## For one vector argument, apply the Einstein product to all of the elements
## of the vector. (The Einstein product is associative.) For one
## two-dimensional matrix argument, return a vector of the Einstein product
## of each column.
##
## For two vectors or matrices of identical dimensions, or for one scalar and
## one vector or matrix argument, return the pairwise Einstein product.
##
## @seealso{algebraic_product, algebraic_sum, bounded_difference, bounded_sum, drastic_product, drastic_sum, einstein_sum, hamacher_product, hamacher_sum}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy einstein_product
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      einstein_product.m
## Last-Modified: 26 Jul 2024

function retval = einstein_product (x, y = 0)
  if (nargin == 0 || nargin > 2 ||
      !is_real_matrix (x) || !is_real_matrix (y))
    error ("invalid arguments to function einstein_product\n");

  elseif (nargin == 1)
    if (isvector (x))
      retval = vector_arg (x);
    elseif (ndims (x) == 2)
      retval = matrix_arg (x);
    else
      error ("invalid arguments to function einstein_product\n");
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
      error ("invalid arguments to function einstein_product\n");
    endif
  endif
endfunction

function retval = scalar_args (x, y)
  retval = (x * y) / (2 - (x + y - x * y));
endfunction

function retval = vector_arg (real_vector)
  x = 1;
  for i = 1 : length (real_vector)
    y = real_vector(i);
    x = (x * y) / (2 - (x + y - x * y));
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
%! z = einstein_product(x);
%! assert(z, 1.6667, 1e-3);

%!test
%! x = [5 2 3 6];
%! y = [-1 1 2 3];
%! z = einstein_product(x, y);
%! assert(z, [0.7134 2.0000 2.0000 1.6364], 1e-3);

## Test input validation
%!error <invalid arguments to function einstein_product>
%! einstein_product()
%!error <invalid arguments to function einstein_product>
%! einstein_product(2j)
%!error <invalid arguments to function einstein_product>
%! einstein_product(1, 2j)
%!error <invalid arguments to function einstein_product>
%! einstein_product([1 2j])
%!error <einstein_product: function called with too many inputs>
%! einstein_product(1, 2, 3)
%!error <invalid arguments to function einstein_product>
%! einstein_product([1 2], [1 2 3])
%!error <invalid arguments to function einstein_product>
%! einstein_product([1 2], [1 2; 3 4])
%!error <invalid arguments to function einstein_product>
%! einstein_product(0:100, [])

