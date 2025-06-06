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
## @deftypefn {Function File} {@var{fis} =} addmf (@var{fis}, @var{in_or_out}, @var{var_index}, @var{mf_name}, @var{mf_type}, @var{mf_params})
##
## Add a membership function to an existing FIS 
## structure and return the updated FIS.
##
## The types/values of the arguments are expected to be:
##
## @multitable @columnfractions .35 .65
## @headitem Argument @tab Expected Type or Value
## @item @var{fis}
## @tab  an FIS structure
## @item @var{in_or_out}
## @tab  'input' or 'output' (case-insensitive)
## @item @var{var_index}
## @tab  valid index of an FIS input/output variable
## @item @var{mf_name}
## @tab  a string
## @item @var{mf_type}
## @tab  a string
## @item @var{mf_params}
## @tab  a vector
## @end multitable
## @sp 1
## If @var{mf_type} is one of the built-in membership functions, then the
## number and values of the parameters must satisfy the membership function
## requirements for the specified @var{mf_type}.
##
## Note that addmf will allow the user to add membership functions or 
## membership function names for a given input or output variable that
## duplicate mfs or mf names already entered.
##
## Also, constant and linear membership functions are not restricted to FIS
## structure outputs or to Sugeno-type FIS structures, and the result of using
## them for FIS inputs or Mamdani-type FIS outputs has not yet been tested.
##
## To run the demonstration code, type "@t{demo addmf}" (without the quotation
## marks) at the Octave prompt.
## This demo creates two FIS input variables and associated membership functions
## and then produces two figures showing the term sets for the two FIS inputs.
##
## @seealso{rmmf, setfis}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy membership
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      addmf.m
## Note:          The demo code is based on an assignment written by
##                Dr. Bruce Segee (University of Maine Dept. of ECE).
## Last-Modified: 12 Jun 2024

function fis = addmf (fis, in_or_out, var_index, mf_name, mf_type, ...
                      mf_params)

  ## If the caller did not supply 6 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 6)
    error ("addmf requires 6 arguments\n");
  elseif (!is_fis (fis))
    error ("addmf's first argument must be an FIS structure\n");
  elseif (!(is_string (in_or_out) && ...
          ismember (tolower (in_or_out), {'input', 'output'})))
    error ("addmf's second argument must be 'input' or 'output'\n");
  elseif (!is_var_index (fis, in_or_out, var_index))
    error ("addmf's third argument must be a variable index\n");
  elseif (!(is_string (mf_name) && is_string (mf_type)))
    error ("addmf's fourth and fifth arguments must be strings\n");
  elseif (!are_mf_params (mf_type, mf_params))
    error ("addmf's sixth argument must be a vector of parameters\n");
  endif

  ## Create a new membership function struct and update the
  ## FIS structure.

  new_mf = struct ('name', mf_name, 'type', mf_type, 'params', ...
                   mf_params);
  if (strcmp (tolower (in_or_out), 'input'))
    if (length (fis.input(var_index).mf) == 0)
      fis.input(var_index).mf = new_mf;
    else
      fis.input(var_index).mf = [fis.input(var_index).mf, new_mf];
    endif
  else
    if (length (fis.output(var_index).mf) == 0)
      fis.output(var_index).mf = new_mf;
    else
      fis.output(var_index).mf = [fis.output(var_index).mf, new_mf];
    endif
  endif

endfunction

%!demo
%! ## Create new FIS.
%! a = newfis ('Heart-Disease-Risk', 'sugeno', ...
%!             'min', 'max', 'min', 'max', 'wtaver');
%! 
%! ## Add two inputs and their membership functions.
%! a = addvar (a, 'input', 'LDL-Level', [0 300]);
%! a = addmf (a, 'input', 1, 'Low', 'trapmf', [-1 0 90 110]);
%! a = addmf (a, 'input', 1, 'Low-Borderline', 'trapmf', ...
%!            [90 110 120 140]);
%! a = addmf (a, 'input', 1, 'Borderline', 'trapmf', ...
%!            [120 140 150 170]);
%! a = addmf (a, 'input', 1, 'High-Borderline', 'trapmf', ...
%!            [150 170 180 200]);
%! a = addmf (a, 'input', 1, 'High', 'trapmf', [180 200 300 301]);
%! 
%! a = addvar (a, 'input', 'HDL-Level', [0 100]);
%! a = addmf (a, 'input', 2, 'Low-HDL', 'trapmf', [-1 0 35 45]);
%! a = addmf (a, 'input', 2, 'Moderate-HDL', 'trapmf', [35 45 55 65]);
%! a = addmf (a, 'input', 2, 'High-HDL', 'trapmf', [55 65 100 101]);
%! 
%! ## Plot the input membership functions.
%! plotmf (a, 'input', 1);
%! plotmf (a, 'input', 2);

%!shared fis
%! fis = readfis ('mamdani_tip_calculator.fis');

%!test
%! fis = addmf(fis, 'input', 1, 'Excellent', 'trapmf', [5 8 10 11]);
%! assert(fis.input(1).mf(3).name, 'Excellent');

## Test input validation
%!error <addmf requires 6 arguments>
%! addmf()
%!error <addmf requires 6 arguments>
%! addmf(1)
%!error <addmf requires 6 arguments>
%! addmf(1, 2)
%!error <addmf requires 6 arguments>
%! addmf(1, 2, 3)
%!error <addmf requires 6 arguments>
%! addmf(1, 2, 3, 4)
%!error <addmf requires 6 arguments>
%! addmf(1, 2, 3, 4, 5)
%!error <addmf: function called with too many inputs>
%! addmf(1, 2, 3, 4, 5, 6, 7)
%!error <addmf's first argument must be an FIS structure>
%! addmf(1, 2, 3, 4, 5, 6)
%!error <addmf's second argument must be 'input' or 'output'>
%! addmf(fis, 'file', 3, 4, 5, 6)
%!error <addmf's third argument must be a variable index>
%! addmf(fis, 'input', 3, 4, 5, 6)
%!error <addmf's fourth and fifth arguments must be strings>
%! addmf(fis, 'input', 1, 4, 'string', 6)
%!error <addmf's fourth and fifth arguments must be strings>
%! addmf(fis, 'input', 1, 'string', 5, 6)
%!error <addmf's sixth argument must be a vector of parameters>
%! addmf(fis, 'input', 1, 'string', 'trapmf', [])
