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
## @deftypefn {Function File} {@var{y} =} is_row_vector (@var{x})
##
## Return true if @var{x} is a non-empty row vector, and return
## false otherwise.
##
## Examples:
## @verbatim
##     is_row_vector([])         ==> false
##     is_row_vector([1 2 3])    ==> true
##     is_row_vector([1; 2; 3])  ==> false
## @end verbatim
##
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy private parameter-test
## Directory:     fuzzy-logic-toolkit/inst/private/
## Filename:      is_row_vector.m
## Last-Modified: 31 Aug 2024

function y = is_row_vector (x)

  y = isvector (x) && (rows (x) == 1);

endfunction

## Tests corresponding to examples in the comment at the top of this file.
%!assert(is_row_vector([]), false)
%!assert(is_row_vector([1 2 3]), true)
%!assert(is_row_vector([1; 2; 3]), false)
