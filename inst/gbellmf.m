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
## @deftypefn {Function File} {@var{y} =} gbellmf (@var{x}, @var{params})
## @deftypefnx {Function File} {@var{y} =} gbellmf (@var{[x1 x2 ... xn]}, @var{[a b c]})
##
## For a given domain @var{x} and parameters @var{params} (or @var{[a b c]}),
## return the corresponding @var{y} values for the generalized bell-shaped
## membership function.
##
## The argument @var{x} must be a real number or a non-empty vector of strictly
## increasing real numbers, @var{a}, @var{b}, and @var{c} must be real numbers,
## @var{a} must be non-zero, and @var{b} must be an integer. This membership
## function satisfies the equation:
##
## @verbatim
##     f(x) = 1/(1 + (abs((x - c)/a))^(2 * b))
## @end verbatim
##
## which always returns values in the range [0, 1].
##
## The parameters @var{a}, @var{b}, and @var{c} give:
##
## @verbatim
##     a == controls the width of the curve at f(x) = 0.5;
##          f(c-a) = f(c+a) = 0.5
##     b == controls the slope of the curve at x = c-a and x = c+a;
##          f'(c-a) = b/2a and f'(c+a) = -b/2a
##     c == the center of the curve
## @end verbatim
##
## This membership function has a value of 0.5 at the two points c - a and
## c + a, and the width of the curve at f(x) == 0.5 is 2 * |a|:
##
## @verbatim
##     f(c - a) == f(c + a) == 0.5
##     2 * |a| == the width of the curve at f(x) == 0.5
## @end verbatim
##
## The generalized bell-shaped membership function is continuously
## differentiable and is symmetric about the line x = c.
##
## To run the demonstration code, type "@t{demo gbellmf}" (without the quotation
## marks) at the Octave prompt.
##
## @seealso{dsigmf, gauss2mf, gaussmf, pimf, psigmf, sigmf, smf, trapmf, trimf, zmf}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy membership bell-shaped bell
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      gbellmf.m
## Last-Modified: 13 Jun 2024

function y = gbellmf (x, params)

  ## If the caller did not supply 2 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 2)
    error ("gbellmf requires 2 arguments\n");
  elseif (!is_domain (x))
    error ("gbellmf's first argument must be a valid domain\n");
  elseif (!are_mf_params ('gbellmf', params))
    error ("gbellmf's second argument must be a parameter vector\n");
  endif

  ## Calculate and return the y values of the membership function on the
  ## domain x.

  a = params(1);
  b = params(2);
  c = params(3);

  y_val = @(x_val) 1 / (1 + (abs ((x_val - c)/a))^(2 * b));
  y = arrayfun (y_val, x);

endfunction

%!demo
%! x = 0:255;
%! params = [20 4 100];
%! y1 = gbellmf(x, params);
%! params = [30 3 100];
%! y2 = gbellmf(x, params);
%! params = [40 2 100];
%! y3 = gbellmf(x, params);
%! figure('NumberTitle', 'off', 'Name', 'gbellmf demo');
%! plot(x, y1, 'r;params = [20 4 100];', 'LineWidth', 2)
%! hold on;
%! plot(x, y2, 'b;params = [30 3 100];', 'LineWidth', 2)
%! hold on;
%! plot(x, y3, 'g;params = [40 2 100];', 'LineWidth', 2)
%! ylim([-0.1 1.1]);
%! xlabel('Crisp Input Value', 'FontWeight', 'bold');
%! ylabel('Degree of Membership', 'FontWeight', 'bold');
%! grid;

%!test
%! x = 0:25:250;
%! params = [40 2 100];
%! y = [0.024961 0.074852 0.2906 0.8676 1 0.8676 ...
%!      0.2906 0.074852 0.024961 0.010377 5.0313e-03];
%! z = gbellmf(x, params);
%! assert(z, y, 1e-4);

## Test input validation
%!error <gbellmf requires 2 arguments>
%! gbellmf()
%!error <gbellmf requires 2 arguments>
%! gbellmf(1)
%!error <gbellmf: function called with too many inputs>
%! gbellmf(1, 2, 3)
%!error <gbellmf's first argument must be a valid domain>
%! gbellmf([1 0], 2)
%!error <gbellmf's second argument must be a parameter vector>
%! gbellmf(1, 2)
%!error <gbellmf's second argument must be a parameter vector>
%! gbellmf(0:100, [])
%!error <gbellmf's second argument must be a parameter vector>
%! gbellmf(0:100, [30])
%!error <gbellmf's second argument must be a parameter vector>
%! gbellmf(0:100, [2 3])
%!error <gbellmf's second argument must be a parameter vector>
%! gbellmf(0:100, [90 80 30 50])
%!error <gbellmf's second argument must be a parameter vector>
%! gbellmf(0:100, 'abcd')
