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
## @deftypefn {Function File} {@var{y} =} dsigmf (@var{x}, @var{params})
## @deftypefnx {Function File} {@var{y} =} dsigmf (@var{[x1 x2 ... xn]}, @var{[a1 c1 a2 c2]})
##
## For a given domain @var{x} and parameters @var{params} (or
## @var{[a1 c1 a2 c2]}), return the corresponding @var{y} values for the
## difference between two sigmoidal membership functions.
##
## The argument @var{x} must be a real number or a non-empty list of strictly
## increasing real numbers, and @var{a1}, @var{c1}, @var{a2}, and @var{c2} must
## be real numbers. This membership function satisfies the equation:
##
## @verbatim
##     f(x) = 1/(1 + exp(-a1*(x - c1))) - 1/(1 + exp(-a2*(x - c2)))
## @end verbatim
##
## and in addition, is bounded above and below by 1 and 0 (regardless of the
## value given by the formula above).
##
## If the parameters @var{a1} and @var{a2} are positive and @var{c1} and
## @var{c2} are far enough apart with @var{c1} < @var{c2}, then:
##
## @verbatim
##      (a1)/4 ~ the rising slope at c1
##          c1 ~ the left inflection point
##     (-a2)/4 ~ the falling slope at c2
##          c2 ~ the right inflection point
## @end verbatim
##
## and at each inflection point, the value of the function is about 0.5:
##
## @verbatim
##       f(c1) ~ f(c2) ~ 0.5.
## @end verbatim
##
## Here, the symbol ~ means "approximately equal".
##
## To run the demonstration code, type "@t{demo dsigmf}" (without the quotation
## marks) at the Octave prompt.
##
## @seealso{gauss2mf, gaussmf, gbellmf, pimf, psigmf, sigmf, smf, trapmf, trimf, zmf}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy membership sigmoidal
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      dsigmf.m
## Last-Modified: 26 Jul 2024

function y = dsigmf (x, params)

  ## If the caller did not supply 2 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 2)
    error ("dsigmf requires 2 arguments\n");
  elseif (!is_domain (x))
    error ("dsigmf's first argument must be a valid domain\n");
  elseif (!are_mf_params ('dsigmf', params))
    error ("dsigmf's second argument must be a parameter vector\n");
  endif

  ## Calculate and return the y values of the membership function on the
  ## domain x.

  a1 = params(1);
  c1 = params(2);
  a2 = params(3);
  c2 = params(4);

  y_val = @(x_val) max (0, ...
                        min (1, 1 / (1 + exp (-a1 * (x_val - c1))) - ...
                                1 / (1 + exp (-a2 * (x_val - c2)))));
  y = arrayfun (y_val, x);

endfunction

%!demo
%! x = 0:100;
%! params = [0.5 20 0.3 60];
%! y1 = dsigmf(x, params);
%! params = [0.3 20 0.2 60];
%! y2 = dsigmf(x, params);
%! params = [0.2 20 0.1 60];
%! y3 = dsigmf(x, params);
%! figure('NumberTitle', 'off', 'Name', 'dsigmf demo');
%! plot(x, y1, 'r;params = [0.5 20 0.3 60];', 'LineWidth', 2)
%! hold on;
%! plot(x, y2, 'b;params = [0.3 20 0.2 60];', 'LineWidth', 2)
%! hold on;
%! plot(x, y3, 'g;params = [0.2 20 0.1 60];', 'LineWidth', 2)
%! ylim([-0.1 1.1]);
%! xlabel('Crisp Input Value', 'FontWeight', 'bold');
%! ylabel('Degree of Membership', 'FontWeight', 'bold');
%! grid;

%!test
%! x = 0:10;
%! params = [5 2 3 6];
%! y = [4.5383e-05 6.6925e-03 0.5000 0.9932 0.9975 0.9526 ...
%!      0.5000 0.047426 2.4726e-03 1.2339e-04 6.1442e-06];
%! z = dsigmf(x, params);
%! assert(z, y, 1e-4);

## Test input validation
%!error <dsigmf requires 2 arguments>
%! dsigmf()
%!error <dsigmf requires 2 arguments>
%! dsigmf(1)
%!error <dsigmf's first argument must be a valid domain>
%! dsigmf([1 0], 2)
%!error <dsigmf's second argument must be a parameter vector>
%! dsigmf(1, 2)
%!error <dsigmf: function called with too many inputs>
%! dsigmf(1, 2, 3)
%!error <dsigmf's second argument must be a parameter vector>
%! dsigmf(0:100, [])
%!error <dsigmf's second argument must be a parameter vector>
%! dsigmf(0:100, [30])
%!error <dsigmf's second argument must be a parameter vector>
%! dsigmf(0:100, [2 3])
%!error <dsigmf's second argument must be a parameter vector>
%! dsigmf(0:100, [90 80 30])
%!error <dsigmf's second argument must be a parameter vector>
%! dsigmf(0:100, 'abc')
