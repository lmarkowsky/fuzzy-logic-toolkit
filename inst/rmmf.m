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
## @deftypefn {Function File} {@var{fis} =} rmmf (@var{fis}, @var{in_or_out}, @var{var_index}, @var{mf}, @var{mf_index})
##
## Remove a membership function from an existing FIS
## structure and return the updated FIS.
##
## The types of the arguments are expected to be:
## @itemize @bullet
## @item
## @var{fis} - an FIS structure
## @item
## @var{in_or_out} - either 'input' or 'output' (case-insensitive)
## @item
## @var{var_index} - an FIS input or output variable index
## @item
## @var{mf} - the string 'mf'
## @item
## @var{mf_index} - a string
## @end itemize
##
## Note that rmmf will allow the user to delete membership functions that are
## currently in use by rules in the FIS.
##
## @seealso{addmf, rmvar}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy membership
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      rmmf.m
## Last-Modified: 2 Jun 2024

function fis = rmmf (fis, in_or_out, var_index, mf, mf_index)

  ## If the caller did not supply 5 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 5)
    error ("rmmf requires 5 arguments\n");
  elseif (!is_fis (fis))
    error ("rmmf's first argument must be an FIS structure\n");
  elseif (!(is_string(in_or_out) && ...
           ismember (tolower (in_or_out), {'input', 'output'})))
    error ("rmmf's second argument must be 'input' or 'output'\n");
  elseif (!is_var_index (fis, in_or_out, var_index))
    error ("rmmf's third argument must be a variable index\n");
  elseif (!isequal (mf, 'mf'))
    error ("rmmf's fourth argument must be the string 'mf'\n");
  elseif (!is_int (mf_index))
    error ("rmmf's fifth argument must be an integer\n");
  endif

  ## Delete the membership function struct and update the FIS structure.

  if (strcmp (tolower (in_or_out), 'input'))
    all_mfs = fis.input(var_index).mf;
    fis.input(var_index).mf = [all_mfs(1 : mf_index - 1), ...
                               all_mfs(mf_index + 1 : numel(all_mfs))];
  else
    all_mfs = fis.output(var_index).mf;
    fis.output(var_index).mf = [all_mfs(1 : mf_index - 1), ...
                                all_mfs(mf_index + 1 : numel(all_mfs))];
  endif

endfunction

%!shared fis
%! fis = readfis ('mamdani_tip_calculator.fis');

%!test
%! fis = rmmf(fis, 'input', 1, 'mf', 1);
%! assert(fis.input(1).mf.name, 'Good');

## Test input validation
%!error <rmmf requires 5 arguments>
%! rmmf()
%!error <rmmf requires 5 arguments>
%! rmmf(1)
%!error <rmmf requires 5 arguments>
%! rmmf(1, 2)
%!error <rmmf requires 5 arguments>
%! rmmf(1, 2, 3)
%!error <rmmf requires 5 arguments>
%! rmmf(1, 2, 3, 4)
%!error <rmmf: function called with too many inputs>
%! rmmf(1, 2, 3, 4, 5, 6)
%!error <rmmf's first argument must be an FIS structure>
%! rmmf(1, 2, 3, 4, 5)
%!error <rmmf's second argument must be 'input' or 'output'>
%! rmmf(fis, 2, 3, 4, 5)
%!error <rmmf's third argument must be a variable index>
%! rmmf(fis, 'input', 3, 4, 5)
%!error <rmmf's fourth argument must be the string 'mf'>
%! rmmf(fis, 'input', 1, 4, 5)
%!error <rmmf's fifth argument must be an integer>
%! rmmf(fis, 'input', 1, 'mf', 5.5)
