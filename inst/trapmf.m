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
## @deftypefn {Function File} {@var{y} =} trapmf (@var{x}, @var{params})
## @deftypefnx {Function File} {@var{y} =} trapmf (@var{[x1 x2 ... xn]}, @var{[a b c d]})
##
## For a given domain @var{x} and parameters @var{params} (or @var{[a b c d]}),
## return the corresponding @var{y} values for the trapezoidal membership
## function.
##
## The argument @var{x} must be a real number or a non-empty vector of
## strictly increasing real numbers, and parameters @var{a}, @var{b}, @var{c},
## and @var{d} must satisfy the inequalities:
## @var{a} < @var{b} <= @var{c} < @var{d}. None of the parameters @var{a},
## @var{b}, @var{c}, @var{d} are required to be in the domain @var{x}. The
## minimum and maximum values of the trapezoid are assumed to be 0 and 1.
##
## The parameters @var{[a b c d]} correspond to the x values
## of the corners of the trapezoid:
##
## @verbatim
##        1-|      --------
##          |     /        \
##          |    /          \
##          |   /            \
##        0-----------------------
##             a   b      c   d
## @end verbatim
##
## To run the demonstration code, type "@t{demo trapmf}" (without the quotation
## marks) at the Octave prompt.
##
## @seealso{dsigmf, gauss2mf, gaussmf, gbellmf, pimf, psigmf, sigmf, smf, trimf, zmf}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy membership trapezoidal
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      trapmf.m
## Last-Modified: 13 Jun 2024

function y = trapmf (x, params)

  ## If the caller did not supply 2 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 2)
    error ("trapmf requires 2 arguments\n");
  elseif (!is_domain (x))
    error ("trapmf's first argument must be a valid domain\n");
  elseif (!are_mf_params ('trapmf', params))
    error ("trapmf's second argument must be a parameter vector\n");
  endif

  ## Calculate and return the y values of the trapezoid on the domain x.

  a = params(1);
  b = params(2);
  c = params(3);
  d = params(4);

  b_minus_a = b - a;
  d_minus_c = d - c;

  y_val = @(x_val) max (0, min (min (1, (x_val - a) / b_minus_a), ...
                               (d - x_val) / d_minus_c));
  y = arrayfun (y_val, x);

endfunction

%!demo
%! x = 0:100;
%! params = [-1 0 20 40];
%! y1 = trapmf(x, params);
%! params = [20 40 60 80];
%! y2 = trapmf(x, params);
%! params = [60 80 100 101];
%! y3 = trapmf(x, params);
%! figure('NumberTitle', 'off', 'Name', 'trapmf demo');
%! plot(x, y1, 'r;params = [-1 0 20 40];', 'LineWidth', 2)
%! hold on;
%! plot(x, y2, 'b;params = [20 40 60 80];', 'LineWidth', 2)
%! hold on;
%! plot(x, y3, 'g;params = [60 80 100 101];', 'LineWidth', 2)
%! ylim([-0.1 1.2]);
%! xlabel('Crisp Input Value', 'FontWeight', 'bold');
%! ylabel('Degree of Membership', 'FontWeight', 'bold');
%! grid;

%!test
%! x = 0:10;
%! params = [-1 0 2 4];
%! y1 = trapmf(x, params);
%! assert(y1, [1.0 1.0 1.0 0.5 0 0 0 0 0 0 0]);
%! params = [2 4 6 8];
%! y2 = trapmf(x, params);
%! assert(y2, [0 0 0 0.5 1.0 1.0 1.0 0.5 0 0 0]);
%! params = [6 8 10 11];
%! y3 = trapmf(x, params);
%! assert(y3, [0 0 0 0 0 0 0 0.5 1.0 1.0 1.0]);

## Test input validation
%!error <trapmf requires 2 arguments>
%! trapmf()
%!error <trapmf requires 2 arguments>
%! trapmf(1)
%!error <trapmf: function called with too many inputs>
%! trapmf(1, 2, 3)
%!error <trapmf's first argument must be a valid domain>
%! trapmf([1 0], 2)
%!error <trapmf's second argument must be a parameter vector>
%! trapmf(1, 2)
%!error <trapmf's second argument must be a parameter vector>
%! trapmf(0:100, [])
%!error <trapmf's second argument must be a parameter vector>
%! trapmf(0:100, [2])
%!error <trapmf's second argument must be a parameter vector>
%! trapmf(0:100, [2 3])
%!error <trapmf's second argument must be a parameter vector>
%! trapmf(0:100, [90 80 30 20])
%!error <trapmf's second argument must be a parameter vector>
%! trapmf(0:100, [30 80 20 20])
