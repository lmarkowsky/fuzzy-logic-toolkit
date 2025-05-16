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
## @deftypefn {Function File} {@var{retval} =} algebraic_product (@var{x})
## @deftypefnx {Function File} {@var{retval} =} algebraic_product (@var{x}, @var{y})
##
## Return the algebraic product of the input.
## The algebraic product of two real scalars x and y is: x * y
##
## For one vector argument, apply the algebraic product to all of elements of
## the vector. (The algebraic product is associative.) For one two-dimensional
## matrix argument, return a vector of the algebraic product of each column.
##
## For two vectors or matrices of identical dimensions, or for one scalar and
## one vector or matrix argument, return the pairwise product.
##
## @seealso{algebraic_sum, bounded_difference, bounded_sum, drastic_product, drastic_sum, einstein_product, einstein_sum, hamacher_product, hamacher_sum}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy algebraic_product
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      algebraic_product.m
## Last-Modified: 26 Jul 2024

function retval = algebraic_product (x, y = 0)
  if ((nargin != 1) && (nargin != 2))
    error ("algebraic_product requires 1 or 2 arguments\n");
  elseif (!(isreal (x) && isreal (y)))
    error ("arguments to algebraic_product must be real scalars or matrices\n");
  elseif (nargin == 2 && ...
          (isscalar (x) || isscalar (y) || ...
           isequal (size (x), size (y))))
    retval = x .* y;
  elseif (nargin == 1 && ndims (x) <= 2)
    retval = prod (x);
  else
    error ("invalid arguments to function algebraic_product\n");
  endif
endfunction

%!test
%! x = [5 2 3 6];
%! z = algebraic_product(x);
%! assert(z, 180);

%!test
%! x = [5 2 3 6];
%! y = [-1 0 2 3];
%! z = algebraic_product(x, y);
%! assert(z, [-5 0 6 18]);

## Test input validation
%!error <algebraic_product requires 1 or 2 arguments>
%! algebraic_product()
%!error <algebraic_product: function called with too many inputs>
%! algebraic_product(1, 2, 3)
%!error <arguments to algebraic_product must be real scalars or matrices>
%! algebraic_product(2j)
%!error <arguments to algebraic_product must be real scalars or matrices>
%! algebraic_product(1, 2j)
%!error <arguments to algebraic_product must be real scalars or matrices>
%! algebraic_product([1 2j])
%!error <invalid arguments to function algebraic_product>
%! algebraic_product([1 2], [1 2 3])
%!error <invalid arguments to function algebraic_product>
%! algebraic_product([1 2], [1 2; 3 4])
%!error <invalid arguments to function algebraic_product>
%! algebraic_product(0:100, [])
