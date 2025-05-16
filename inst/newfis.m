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
## @deftypefn {Function File} {@var{a} =} newfis (@var{fis_name})
## @deftypefnx {Function File} {@var{a} =} newfis (@var{fis_name}, @var{fis_type})
## @deftypefnx {Function File} {@var{a} =} newfis (@var{fis_name}, @var{fis_type}, @var{and_method})
## @deftypefnx {Function File} {@var{a} =} newfis (@var{fis_name}, @var{fis_type}, @var{and_method}, @var{or_method})
## @deftypefnx {Function File} {@var{a} =} newfis (@var{fis_name}, @var{fis_type}, @var{and_method}, @var{or_method}, @var{imp_method})
## @deftypefnx {Function File} {@var{a} =} newfis (@var{fis_name}, @var{fis_type}, @var{and_method}, @var{or_method}, @var{imp_method}, @var{agg_method})
## @deftypefnx {Function File} {@var{a} =} newfis (@var{fis_name}, @var{fis_type}, @var{and_method}, @var{or_method}, @var{imp_method}, @var{agg_method}, @var{defuzz_method})
## @deftypefnx {Function File} {@var{a} =} newfis (@var{fis_name}, @var{fis_type}, @var{and_method}, @var{or_method}, @var{imp_method}, @var{agg_method}, @var{defuzz_method}, @var{fis_version})
##
## Create and return a new FIS structure using the argument values provided.
## Only the first argument is required. If fewer than eight arguments are given,
## then some or all of the following default values will be used:
##
## @multitable @columnfractions .30 .30
## @headitem Argument @tab Default Value
## @item @var{fis_type}
## @tab  'mamdani'
## @item @var{and_method}
## @tab  'min'
## @item @var{or_method}
## @tab  'max'
## @item @var{imp_method}
## @tab  'min'
## @item @var{agg_method}
## @tab  'max'
## @item @var{defuzz_method}
## @tab  'centroid'
## @item @var{fis_version}
## @tab  1.0
## @end multitable
## @sp 1
## @seealso{addmf, addrule, addvar, setfis}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy inference system fis
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      newfis.m
## Last-Modified: 12 Jun 2024

function fis = newfis (fis_name, fis_type = 'mamdani', ...
                       and_method = 'min', or_method = 'max', ...
                       imp_method = 'min', agg_method = 'max', ...
                       defuzz_method = 'centroid', fis_version = 1.0)

  ## If the caller did not supply the between 1 and 8 argument values,
  ## or if any of the argument values were not strings, print an error
  ## message and halt.

  if (!(nargin >= 1 && nargin <= 8))
    error ("newfis requires between 1 and 8 arguments\n");
  elseif (!(is_string (fis_name) && is_string (fis_type) && ...
           is_string (and_method) && is_string (or_method) && ...
           is_string (imp_method) && is_string (agg_method) && ...
           is_string (defuzz_method) && isfloat (fis_version)))
    error ("incorrect argument type in newfis argument list\n");
  endif

  ## Create and return the new FIS structure.

  fis = struct ('name', fis_name, ...
                'type', fis_type, ...
                'version', fis_version, ...
                'andMethod', and_method, ...
                'orMethod', or_method, ...
                'impMethod', imp_method, ...
                'aggMethod', agg_method, ...
                'defuzzMethod', defuzz_method, ...
                'input', [], ...
                'output', [], ...
                'rule', []);
endfunction

%!shared fis
%! fis = newfis ('Heart-Disease-Risk', 'sugeno', ...
%!               'min', 'max', 'min', 'max', 'wtaver');

%!assert(fis.name == 'Heart-Disease-Risk');
%!assert(fis.type == 'sugeno');
%!assert(fis.andMethod == 'min');
%!assert(fis.orMethod == 'max');
%!assert(fis.impMethod == 'min');
%!assert(fis.aggMethod == 'max');
%!assert(fis.defuzzMethod == 'wtaver');

## Test input validation
%!error <newfis requires between 1 and 8 arguments>
%! newfis()
%!error <newfis: function called with too many inputs>
%! newfis(1, 2, 3, 4, 5, 6, 7, 8, 9)
%!error <incorrect argument type in newfis argument list>
%! newfis(1, 'str', 'str', 'str', 'str', 'str', 'str', 8)
%!error <incorrect argument type in newfis argument list>
%! newfis(1, 'str', 'str', 'str', 'str', 'str', 'str', 8)
%!error <incorrect argument type in newfis argument list>
%! newfis('str', 2, 'str', 'str', 'str', 'str', 'str', 8)
%!error <incorrect argument type in newfis argument list>
%! newfis('str', 'str', 3, 'str', 'str', 'str', 'str', 8)
%!error <incorrect argument type in newfis argument list>
%! newfis('str', 'str', 'str', 4,  'str', 'str', 'str', 8)
%!error <incorrect argument type in newfis argument list>
%! newfis('str', 'str', 'str', 'str', 5, 'str', 'str', 8)
%!error <incorrect argument type in newfis argument list>
%! newfis('str', 'str', 'str', 'str', 'str', 6, 'str', 8)
%!error <incorrect argument type in newfis argument list>
%! newfis('str', 'str', 'str', 'str', 'str', 'str', 7, 8)
%!error <incorrect argument type in newfis argument list>
%! newfis('str', 'str', 'str', 'str', 'str', 'str', 'str', 'str')
