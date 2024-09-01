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
## @deftypefn {Function File} {@var{y} =} is_int (@var{x})
##
## Return true if @var{x} is an integer-valued real scalar, and
## return false otherwise.
##
## is_int is a private function that localizes the test for integers.
## In Octave, integer constants such as 1 are not represented by ints
## internally: isinteger(1) returns 0.
##
## Examples:
## @verbatim
##     is_int(6)         ==> true
##     is_int(6.2)       ==> false
##     is_int(ones(2))   ==> false
##     is_int(6 + 0i)    ==> true
##     is_int(0)         ==> true
## @end verbatim
##
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy private parameter-test
## Directory:     fuzzy-logic-toolkit/inst/private/
## Filename:      is_int.m
## Last-Modified: 31 Aug 2024

function y = is_int (x)

  y = isscalar (x) && isreal (x) && (fix (x) == x);

endfunction

## Tests corresponding to examples in the comment at the top of this file.
%!assert(is_int(6), true)
%!assert(is_int(6.2), false)
%!assert(is_int(ones(2)), false)
%!assert(is_int(6 + 0i), true)
%!assert(is_int(0), true)
