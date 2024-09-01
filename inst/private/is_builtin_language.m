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
## @deftypefn {Function File} {@var{y} =} is_builtin_language (@var{x})
##
## Return true if @var{x} is one of the strings representing the
## built-in languages, and return false otherwise. The comparison is
## case-insensitive.
##
## is_builtin_language is a private function that localizes the test 
## for languages handled by showrule.
##
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy private parameter-test
## Directory:     fuzzy-logic-toolkit/inst/private/
## Filename:      is_builtin_language.m
## Last-Modified: 31 Aug 2024

function y = is_builtin_language (x)

  y = ischar (x) && isvector (x) && ...
      ismember (tolower (x), {'english', ...
                              'chinese', 'mandarin', 'pinyin', ...
                              'russian', 'russkij', 'pycckii', ...
                              'french', 'francais', ...
                              'spanish', 'espanol', ...
                              'german', 'deutsch'});

endfunction

%!assert(is_builtin_language(6), false)
%!assert(is_builtin_language('english'), true)
%!assert(is_builtin_language('francais'), true)
%!assert(is_builtin_language(''), false)
