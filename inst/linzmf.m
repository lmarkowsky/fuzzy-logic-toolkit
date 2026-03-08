## Copyright (C) 2026 Tang Chonghao <chadholton@qq.com>
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
## @deftypefn {Function File} {@var{y} =} linzmf (@var{x}, @var{params})
## @deftypefnx {Function File} {@var{y} =} linzmf (@var{[x1 x2 ... xn]}, @var{[a b]})
##
## For a given domain @var{x} and parameters @var{params} (or @var{[a b]}),
## return the corresponding @var{y} values for the linear Z-shaped saturation
## membership function.
##
## The argument @var{x} must be a real number or a non-empty vector of strictly
## increasing real numbers. The parameters @var{a} and @var{b} define the
## shoulder and the foot of the membership function and must satisfy @var{a} <= @var{b}.
## When @var{a} < @var{b} the membership decreases linearly from 1 at @var{a} to
## 0 at @var{b}; values below @var{a} have membership 1, values above @var{b}
## have membership 0. When @var{a} = @var{b} the membership is a crisp step:
## 1 for @var{x} < @var{a}, 0 for @var{x} >= @var{a}. The minimum and maximum
## of the membership function are assumed to be 0 and 1.
##
## The parameters @var{[a b]} correspond to the shoulder and foot locations:
##
## @verbatim
##        1-|------------
##          |            \
##          |             \
##          |              \
##        0-|_______________\____________
##                       a   b
## @end verbatim
##
## To run the demonstration code, type "@t{demo linzmf}" (without the quotation
## marks) at the Octave prompt.
##
## @seealso{dsigmf, gauss2mf, gaussmf, gbellmf, linsmf, pimf, psigmf, sigmf, smf, trimf, trapmf, zmf}
## @end deftypefn

function y = linzmf (x, params)

  ## If the caller did not supply 2 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 2)
    error ("linzmf requires 2 arguments\n");
  elseif (!is_domain (x))
    error ("linzmf's first argument must be a valid domain\n");
  elseif (!are_mf_params ('linzmf', params))
    error ("linzmf's second argument must be a parameter vector [a b]\n");
  endif

  ## Extract parameters and calculate membership values.
  ## linzmf is the complement of linsmf: linzmf(x) = 1 - linsmf(x)

  a = params(1);
  b = params(2);

  if (a == b)
    y = double (x < a);
  else
    y = max (0, min (1, (b - x) / (b - a)));
  endif

endfunction

%!demo
%! x = 0:0.1:10;
%! params = [2 5];
%! y1 = linzmf (x, params);
%! params = [4 6];
%! y2 = linzmf (x, params);
%! params = [7 7];
%! y3 = linzmf (x, params);
%! figure ('NumberTitle', 'off', 'Name', 'linzmf demo');
%! plot (x, y1, 'r;params = [2 5];', 'LineWidth', 2)
%! hold on;
%! plot (x, y2, 'b;params = [4 6];', 'LineWidth', 2)
%! hold on;
%! plot (x, y3, 'g;params = [7 7];', 'LineWidth', 2)
%! ylim ([-0.1 1.2]);
%! xlabel ('Crisp Input Value', 'FontWeight', 'bold');
%! ylabel ('Degree of Membership', 'FontWeight', 'bold');
%! grid;

%!test
%! x = 0:0.5:5;
%! params = [2 4];
%! y = linzmf (x, params);
%! assert (y, [1.00 1.00 1.00 1.00 1.00 0.75 0.50 0.25 0.00 0.00 0.00]);
%! params = [3 3];
%! y = linzmf (x, params);
%! assert (y, [1 1 1 1 1 1 0 0 0 0 0]);

## Test input validation
%!error <linzmf requires 2 arguments>
%! linzmf ()
%!error <linzmf requires 2 arguments>
%! linzmf (1)
%!error <linzmf: function called with too many inputs>
%! linzmf (1, 2, 3)
%!error <linzmf's first argument must be a valid domain>
%! linzmf ([1 0], 2)
%!error <linzmf's second argument must be a parameter vector>
%! linzmf (1, 2)
%!error <linzmf's second argument must be a parameter vector>
%! linzmf (0:100, [])
%!error <linzmf's second argument must be a parameter vector>
%! linzmf (0:100, [2])
%!error <linzmf's second argument must be a parameter vector>
%! linzmf (0:100, [2 3 4])
%!error <linzmf's second argument must be a parameter vector>
%! linzmf (0:100, [5 3])   # a > b is not allowed
