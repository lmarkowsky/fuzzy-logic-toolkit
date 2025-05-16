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
## @deftypefn {Function File} {@var{fis} =} setfis (@var{fis}, @var{property}, @var{property_value})
## @deftypefnx {Function File} {@var{fis} =} setfis (@var{fis}, @var{in_or_out}, @var{var_index}, @var{var_property}, @var{var_property_value})
## @deftypefnx {Function File} {@var{fis} =} setfis (@var{fis}, @var{in_or_out}, @var{var_index}, @var{mf}, @var{mf_index}, @var{mf_property}, @var{mf_property_value})
##
## Set a property (field) value of an FIS structure and return the
## updated FIS.
##
## There are three forms of setfis:
##
## @multitable @columnfractions .20 .70
## @headitem Number of Arguments @tab Action Taken
## @item 3
## @tab  Set a property of the FIS structure. The properties that may
##       be set are: name, type, andmethod, ormethod, impmethod,
##       addmethod, defuzzmethod, and version.
## @item 5
## @tab  Set a property of an input or output variable of the FIS
##       structure. The properties that may be set are: name and range.
## @item 7
## @tab  Set a property of a membership function. The properties that
##       may be set are: name, type, and params.
## @end multitable
## @sp 1
## The types/values of the arguments are expected to be:
##
## @multitable @columnfractions .20 .70
## @headitem Argument @tab Expected Type or Value
## @item @var{fis}
## @tab  an FIS structure
## @item @var{property}
## @tab  a string; one of 'name', 'type', 'andmethod',
##       'ormethod', 'impmethod', 'addmethod', 
##       'defuzzmethod', and 'version' (case-insensitive)
## @item @var{property_value}
## @tab  a number (if property is 'version'); a string (otherwise)
## @item @var{in_or_out}
## @tab  either 'input' or 'output' (case-insensitive)
## @item @var{var_index}
## @tab  a valid integer index of an input or output FIS variable
## @item @var{var_property}
## @tab  a string; either 'name' or 'range'
## @item @var{var_property_value}
## @tab  a string (if var_property is 'name') or 
##       a vector range (if var_property is 'range')
## @item @var{mf}
## @tab  the string 'mf'
## @item @var{mf_index}
## @tab  a valid integer index of a membership function 
## @item @var{mf_property}
## @tab  a string; one of 'name', 'type', or 'params'
## @item @var{mf_property_value}
## @tab  a string (if mf_property is 'name' or 'type');
##       an array (if mf_property is 'params')
## @end multitable
## @sp 1
## Note that all of the strings representing properties above are case
## insensitive.
##
## @seealso{newfis, getfis, showfis}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy inference system fis
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      setfis.m
## Last-Modified: 13 Jun 2024

##----------------------------------------------------------------------

function fis = setfis (fis, arg2, arg3, arg4 = 'dummy', ...
                       arg5 = 'dummy', arg6 = 'dummy', arg7 = 'dummy')

  switch (nargin)
    case 3  fis = setfis_three_args (fis, arg2, arg3);
    case 5  fis = setfis_five_args (fis, arg2, arg3, arg4, arg5);
    case 7  fis = setfis_seven_args (fis, arg2, arg3, arg4, arg5, ...
                                     arg6, arg7);
    otherwise
            error ("setfis requires 3, 5, or 7 arguments\n");
  endswitch

endfunction

##----------------------------------------------------------------------
## Function: setfis_three_args
## Purpose:  Handle calls to setfis that have 3 arguments. See the
##           comment at the top of this file for more complete info.
##----------------------------------------------------------------------

function fis = setfis_three_args (fis, arg2, arg3)

  ## If not all of the arguments have the correct types, print an error
  ## message and halt.

  if (!is_fis (fis))
    error ("setfis's first argument must be an FIS structure\n");
  elseif (!(is_string (arg2) && ismember (tolower (arg2), ...
          {'name', 'type', 'andmethod', 'ormethod', 'impmethod', ...
           'aggmethod', 'defuzzmethod', 'version'})))
    error ("incorrect second argument to setfis\n");
  elseif (strcmp(tolower (arg2), 'version') && !is_real (arg3))
    error ("the third argument to setfis must be a number\n");
  elseif (!strcmp(tolower (arg2), 'version') && !is_string (arg3))
    error ("the third argument to setfis must be a string\n");
  endif

  ## Set the property (arg2) of the FIS to the property value (arg3).

  switch (tolower(arg2))
    case 'name'         fis.name = arg3;
    case 'version'      fis.version = arg3;
    case 'type'         fis.type = arg3;
    case 'andmethod'    fis.andMethod = arg3;
    case 'ormethod'     fis.orMethod = arg3;
    case 'impmethod'    fis.impMethod = arg3;
    case 'aggmethod'    fis.aggMethod = arg3;
    case 'defuzzmethod' fis.defuzzMethod = arg3;
  endswitch

endfunction

##----------------------------------------------------------------------
## Function: setfis_five_args
## Purpose:  Handle calls to setfis that have 5 arguments. See the
##           comment at the top of this file for more complete info.
##----------------------------------------------------------------------

function fis = setfis_five_args (fis, arg2, arg3, arg4, arg5)

  ## If not all of the arguments have the correct types, print an error
  ## message and halt.

  if (!is_fis (fis))
    error ("setfis's first argument must be an FIS structure\n");
  elseif (!(is_string (arg2) && ...
            ismember (tolower (arg2), {'input','output'})))
    error ("setfis's second argument must be 'input' or 'output'\n");
  elseif (!is_var_index (fis, arg2, arg3))
    error ("setfis's third argument must be a variable index\n");
  elseif (!(is_string (arg4) && ...
            ismember (tolower (arg4), {'name', 'range'})))
    error ("setfis's fourth argument must be 'name' or 'range'\n");
  elseif (strcmp (arg4, 'name') && !is_string (arg5))
    error ("incorrect fifth argument to setfis\n");
  elseif (strcmp (arg4, 'range') && !is_real_matrix (arg5))
    error ("incorrect fifth argument to setfis\n");
  endif

  ## Set the input or output variable property (arg4) to the
  ## value (arg5).

  switch (tolower (arg2))
    case 'input'
      switch (tolower (arg4))
        case 'name'  fis.input(arg3).name = arg5;
        case 'range' fis.input(arg3).range = arg5;
      endswitch
    case 'output'
      switch (tolower (arg4))
        case 'name'  fis.output(arg3).name = arg5;
        case 'range' fis.output(arg3).range = arg5;
      endswitch
  endswitch

endfunction

##----------------------------------------------------------------------
## Function: setfis_seven_args
## Purpose:  Handle calls to setfis that have 7 arguments. See the
##           comment at the top of this file for more complete info.
##----------------------------------------------------------------------

function fis = setfis_seven_args (fis, arg2, arg3, arg4, arg5, ...
                                  arg6, arg7)

  ## If not all of the arguments have the correct types, print an error
  ## message and halt.

  if (!is_fis (fis))
    error ("setfis's first argument must be an FIS structure\n");
  elseif (!(is_string (arg2) && ...
            ismember (tolower (arg2), {'input','output'})))
    error ("setfis's second argument must be 'input' or 'output'\n");
  elseif (!is_var_index (fis, arg2, arg3))
    error ("setfis's third argument must be a variable index\n");
  elseif (!(is_string (arg4) && strcmp (tolower (arg4), 'mf')))
    error ("setfis's fourth argument must be 'mf'\n");
  elseif (!is_mf_index (fis, arg2, arg3, arg5))
    error ("setfis's fifth arg must be a membership function index\n");
  elseif (!(is_string (arg6) && ismember (tolower(arg6), ...
           {'name', 'type', 'params'})))
    error ("incorrect sixth argument to setfis\n");
  elseif (ismember (tolower (arg6), {'name', 'type'}) && ...
          !is_string (arg7))
    error ("incorrect seventh argument to setfis\n");
  elseif (strcmp (tolower (arg6), 'params') && !is_real_matrix (arg7))
    error ("incorrect seventh argument to setfis\n");
  endif

  ## Set the membership function property (arg6) to the value (arg7).

  switch (tolower (arg2))
    case 'input'
      switch (tolower (arg6))
        case 'name'   fis.input(arg3).mf(arg5).name = arg7;
        case 'type'   fis.input(arg3).mf(arg5).type = arg7;
        case 'params' fis.input(arg3).mf(arg5).params = arg7;
      endswitch
    case 'output'
      switch (tolower (arg6))
        case 'name'   fis.output(arg3).mf(arg5).name = arg7;
        case 'type'   fis.output(arg3).mf(arg5).type = arg7;
        case 'params' fis.output(arg3).mf(arg5).params = arg7;
      endswitch
  endswitch

endfunction

%!shared fis
%! fis = readfis ('mamdani_tip_calculator.fis');

%!test
%! fis = setfis(fis, 'defuzzMethod', 'mom');
%! assert(fis.defuzzMethod, 'mom');

## Test input validation
%!error <setfis requires 3, 5, or 7 arguments>
%! setfis()
%!error <setfis requires 3, 5, or 7 arguments>
%! setfis(1)
%!error <setfis requires 3, 5, or 7 arguments>
%! setfis(1, 2)
%!error <setfis requires 3, 5, or 7 arguments>
%! setfis(1, 2, 3, 4)
%!error <setfis requires 3, 5, or 7 arguments>
%! setfis(1, 2, 3, 4, 5, 6)
%!error <setfis: function called with too many inputs>
%! setfis(1, 2, 3, 4, 5, 6, 7, 8)
%!error <setfis's first argument must be an FIS structure>
%! setfis(1, 2, 3, 4, 5, 6, 7)
%!error <setfis's second argument must be 'input' or 'output'>
%! setfis(fis, 2, 3, 4, 5, 6, 7)
%!error <setfis's third argument must be a variable index>
%! setfis(fis, 'input', 3, 4, 5, 6, 7)
%!error <setfis's fourth argument must be 'mf'>
%! setfis(fis, 'input', 1, 4, 5, 6, 7)
%!error <setfis's fifth arg must be a membership function index>
%! setfis(fis, 'input', 1, 'mf', 5, 6, 7)
%!error <incorrect sixth argument to setfis>
%! setfis(fis, 'input', 1, 'mf', 1, 6, 7)
%!error <incorrect seventh argument to setfis>
%! setfis(fis, 'input', 1, 'mf', 1, 'name', 7)
