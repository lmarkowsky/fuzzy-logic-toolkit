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
## @deftypefn {Function File} {@var{y} =} is_real (@var{x})
##
## Return true if @var{x} is an real scalar, and return false otherwise.
##
## is_real is a private function that localizes the test for real scalars.
##
## Examples:
## @verbatim
##     is_real(6)         ==> true
##     is_real(6.2)       ==> true
##     is_real(ones(2))   ==> false
##     is_real(6 + 0i)    ==> true
##     is_real(6 + i)     ==> false
##     is_real([0])       ==> true
##     is_real([0 0])     ==> false
##     is_real('h')       ==> false
## @end verbatim
##
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy private parameter-test
## Directory:     fuzzy-logic-toolkit/inst/private/
## Filename:      is_real.m
## Last-Modified: 31 Aug 2024

function y = is_real (x)

  y = isnumeric(x) && isscalar (x) && isreal (x);

endfunction

## Tests corresponding to examples in the comment at the top of this file.
%!assert(is_real(6), true)
%!assert(is_real(6.2), true)
%!assert(is_real(ones(2)), false)
%!assert(is_real(6 + 0i), true)
%!assert(is_real(6 + i), false)
%!assert(is_real([0]), true)
%!assert(is_real([0 0]), false)
%!assert(is_real('h'), false)
