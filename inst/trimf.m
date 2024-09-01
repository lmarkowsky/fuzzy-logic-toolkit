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
## @deftypefn {Function File} {@var{y} =} trimf (@var{x}, @var{params})
## @deftypefnx {Function File} {@var{y} =} trimf (@var{[x1 x2 ... xn]}, @var{[a b c]})
##
## For a given domain @var{x} and parameters @var{params} (or @var{[a b c]}),
## return the corresponding @var{y} values for the triangular membership
## function.
##
## The argument @var{x} must be a real number or a non-empty vector of strictly
## increasing real numbers, and parameters @var{a}, @var{b}, and @var{c} must be
## real numbers that satisfy @var{a} < @var{b} < @var{c}. None of the parameters
## @var{a}, @var{b}, and @var{c} are required to be in the domain @var{x}. The
## minimum and maximum values of the triangle are assumed to be 0 and 1.
##
## The parameters [@var{a} @var{b} @var{c}] correspond to the x values of the
## vertices of the triangle:
##
## @verbatim
##        1-|         /\
##          |        /  \
##          |       /    \
##          |      /      \
##        0-----------------------
##                a   b   c
## @end verbatim
##
## To run the demonstration code, type "@t{demo trimf}" (without the quotation
## marks) at the Octave prompt.
##
## @seealso{dsigmf, gauss2mf, gaussmf, gbellmf, pimf, psigmf, sigmf, smf, trapmf, trimf_demo, zmf}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy membership triangular
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      trimf.m
## Last-Modified: 13 Jun 2024

function y = trimf (x, params)

  ## If the caller did not supply 2 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 2)
    error ("trimf requires 2 arguments\n");
  elseif (!is_domain (x))
    error ("trimf's first argument must be a valid domain\n");
  elseif (!are_mf_params ('trimf', params))
    error ("trimf's second argument must be a parameter vector\n");
  endif

  ## Calculate and return the y values of the triangle on the domain x.

  a = params(1);
  b = params(2);
  c = params(3);

  b_minus_a = b - a;
  c_minus_b = c - b;

  y_val = @(x_val) max (0, min (min (1, (x_val - a) / b_minus_a), ...
                               (c - x_val)/c_minus_b));
  y = arrayfun (y_val, x);

endfunction

%!demo
%! x = 0:100;
%! params = [-1 0 50];
%! y1 = trimf(x, params);
%! params = [0 50 100];
%! y2 = trimf(x, params);
%! params = [50 100 101];
%! y3 = trimf(x, params);
%! figure('NumberTitle', 'off', 'Name', 'trimf demo');
%! plot(x, y1, 'r;params = [-1 0 50];', 'LineWidth', 2)
%! hold on;
%! plot(x, y2, 'b;params = [0 50 100];', 'LineWidth', 2)
%! hold on;
%! plot(x, y3, 'g;params = [50 100 101];', 'LineWidth', 2)
%! ylim([-0.1 1.2]);
%! xlabel('Crisp Input Value', 'FontWeight', 'bold');
%! ylabel('Degree of Membership', 'FontWeight', 'bold');
%! grid;

%!test
%! x = 0:10;
%! params = [0 2 4];
%! y1 = trimf(x, params);
%! assert(y1, [0 0.5 1.0 0.5 0 0 0 0 0 0 0]);
%! params = [2 4 6];
%! y2 = trimf(x, params);
%! assert(y2, [0 0 0 0.5 1.0 0.5 0 0 0 0 0]);
%! params = [6 8 10];
%! y3 = trimf(x, params);
%! assert(y3, [0 0 0 0 0 0 0 0.5 1.0 0.5 0]);

## Test input validation
%!error <trimf requires 2 arguments>
%! trimf()
%!error <trimf requires 2 arguments>
%! trimf(1)
%!error <trimf: function called with too many inputs>
%! trimf(1, 2, 3)
%!error <trimf's first argument must be a valid domain>
%! trimf([1 0], 2)
%!error <trimf's second argument must be a parameter vector>
%! trimf(1, 2)
%!error <trimf's second argument must be a parameter vector>
%! trimf(0:100, [])
%!error <trimf's second argument must be a parameter vector>
%! trimf(0:100, [2])
%!error <trimf's second argument must be a parameter vector>
%! trimf(0:100, [2 3])
%!error <trimf's second argument must be a parameter vector>
%! trimf(0:100, [90 80 30])
%!error <trimf's second argument must be a parameter vector>
%! trimf(0:100, [30 80 20])
