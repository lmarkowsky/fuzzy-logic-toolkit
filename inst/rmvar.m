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
## @deftypefn {Function File} {@var{fis} =} rmvar (@var{fis}, @var{in_or_out}, @var{var_index})
##
## Remove an input or output variable from an existing FIS
## structure and return the updated FIS.
##
## The types/values of the arguments are expected to be:
##
## @multitable @columnfractions .35 .40
## @headitem Argument @tab Expected Type or Value
## @item @var{fis}
## @tab  an FIS structure
## @item @var{in_or_out}
## @tab  either 'input' or 'output' (case-insensitive)
## @item @var{var_index}
## @tab  an FIS input or output variable index
## @end multitable
## @sp 1
## Note that rmvar will allow the user to delete an input or output variable
## that is currently in use by rules in the FIS.
##
## @seealso{addvar, rmmf}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy variable
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      rmvar.m
## Last-Modified: 13 Jun 2024

function fis = rmvar (fis, in_or_out, var_index)

  ## If the caller did not supply 3 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 3)
    error ("rmvar requires 3 arguments\n");
  elseif (!is_fis (fis))
    error ("rmvar's first argument must be an FIS structure\n");
  elseif (!(is_string (in_or_out) && ...
           ismember (tolower (in_or_out), {'input', 'output'})))
    error ("rmvar's second argument must be 'input' or 'output'\n");
  elseif (!is_var_index (fis, in_or_out, var_index))
    error ("rmvar's third argument must be a variable index\n");
  endif

  ## Delete the variable struct and update the FIS structure.

  if (strcmp (tolower (in_or_out), 'input'))
    all_vars = fis.input;
    fis.input = [all_vars(1 : var_index - 1), ...
                 all_vars(var_index + 1 : numel (all_vars))];
  else
    all_vars = fis.output;
    fis.output = [all_vars(1 : var_index - 1), ...
                  all_vars(var_index + 1 : numel (all_vars))];
  endif

endfunction

%!shared fis
%! fis = readfis ('mamdani_tip_calculator.fis');

%!test
%! fis = rmvar(fis, 'input', 1);
%! assert(fis.input.name, 'Service');

## Test input validation
%!error <rmvar requires 3 arguments>
%! rmvar()
%!error <rmvar requires 3 arguments>
%! rmvar(1)
%!error <rmvar requires 3 arguments>
%! rmvar(1, 2)
%!error <rmvar: function called with too many inputs>
%! rmvar(1, 2, 3, 4)
%!error <rmvar's first argument must be an FIS structure>
%! rmvar(1, 2, 3)
%!error <rmvar's second argument must be 'input' or 'output'>
%! rmvar(fis, 2, 3)
%!error <rmvar's third argument must be a variable index>
%! rmvar(fis, 'input', 3)
