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
## @deftypefn {Function File} {@var{y} =} is_string (@var{x})
##
## Return true if @var{x} is a character vector, and return false otherwise.
##
## is_string is a private function that localizes the test for valid Octave
## strings, which may need to be changed in the future. Octave 3.2.4 implements
## strings as character vectors. In subsequent versions of Octave, the internal
## implementation of strings may change, or a built-in Octave test 'isstring'
## may be implemented. 
##
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy private parameter-test
## Directory:     fuzzy-logic-toolkit/inst/private/
## Filename:      is_string.m
## Last-Modified: 10 Jun 2024

function y = is_string (x)

  y = ischar (x) && isvector (x);

endfunction
