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
## @deftypefn {Function File} {@var{y} =} gaussmf (@var{x}, @var{params})
## @deftypefnx {Function File} {@var{y} =} gaussmf (@var{[x1 x2 ... xn]}, @var{[sig c]})
##
## For a given domain @var{x} and parameters @var{params} (or @var{[sig c]}),
## return the corresponding @var{y} values for the Gaussian membership
## function. This membership function is shaped like the Gaussian (normal)
## distribution, but scaled to have a maximum value of 1. By contrast, the 
## area under the Gaussian distribution curve is 1.
##
## The argument @var{x} must be a real number or a non-empty vector of strictly
## increasing real numbers, and @var{sig} and @var{c} must be real numbers.
## This membership function satisfies the equation:
##
## @verbatim
##     f(x) = exp((-(x - c)^2)/(2 * sig^2))
## @end verbatim
##
## which always returns values in the range [0, 1].
##
## Just as for the Gaussian (normal) distribution, the parameters @var{sig} and
## @var{c} represent:
##
## @verbatim
##     sig^2 == the variance (a measure of the width of the curve)
##         c == the center (the mean; the x value of the peak)
## @end verbatim
##
## For larger values of @var{sig}, the curve is flatter, and for smaller values
## of sig, the curve is narrower. The @var{y} value at the center is always 1:
##
## @verbatim
##     f(c) == 1
## @end verbatim
##
## To run the demonstration code, type "@t{demo gaussmf}" (without the quotation
## marks) at the Octave prompt.
##
## @seealso{dsigmf, gauss2mf, gbellmf, pimf, psigmf, sigmf, smf, trapmf, trimf, zmf}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy membership gaussian
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      gaussmf.m
## Last-Modified: 13 Jun 2024

function y = gaussmf (x, params)

  ## If the caller did not supply 2 argument values with the correct
  ## types, print an error message and halt.

  if (nargin != 2)
    error ("gaussmf requires 2 arguments\n");
  elseif (!is_domain (x))
    error ("gaussmf's first argument must be a valid domain\n");
  elseif (!are_mf_params ('gaussmf', params))
    error ("gaussmf's second argument must be a parameter vector\n");
  endif

  ## Calculate and return the y values of the membership function on the
  ## domain x.

  sig = params(1);
  c = params(2);

  y_val = @(x_val) exp ((-(x_val - c)^2)/(2 * sig^2));
  y = arrayfun (y_val, x);

endfunction

%!demo
%! x = -5:0.1:5;
%! params = [0.5 0];
%! y1 = gaussmf(x, params);
%! params = [1 0];
%! y2 = gaussmf(x, params);
%! params = [2 0];
%! y3 = gaussmf(x, params);
%! figure('NumberTitle', 'off', 'Name', 'gaussmf demo');
%! plot(x, y1, 'r;params = [0.5 0];', 'LineWidth', 2);
%! hold on ;
%! plot(x, y2, 'b;params = [1 0];', 'LineWidth', 2);
%! hold on ;
%! plot(x, y3, 'g;params = [2 0];', 'LineWidth', 2);
%! ylim([-0.1 1.1]);
%! xlabel('Crisp Input Value');
%! ylabel('Degree of Membership');
%! grid;
%! hold;

%!test
%! x = -5:5;
%! params = [2 0];
%! y = [0.043937 0.1353 0.3247 0.6065 0.8825 1 ...
%!      0.8825 0.6065 0.3247 0.1353 0.043937];
%! z = gaussmf(x, params);
%! assert(z, y, 1e-4);

## Test input validation
%!error <gaussmf requires 2 arguments>
%! gaussmf()
%!error <gaussmf requires 2 arguments>
%! gaussmf(1)
%!error <gaussmf: function called with too many inputs>
%! gaussmf(1, 2, 3)
%!error <gaussmf's first argument must be a valid domain>
%! gaussmf([1 0], 2)
%!error <gaussmf's second argument must be a parameter vector>
%! gaussmf(1, 2)
%!error <gaussmf's second argument must be a parameter vector>
%! gaussmf(0:100, [])
%!error <gaussmf's second argument must be a parameter vector>
%! gaussmf(0:100, [30])
%!error <gaussmf's second argument must be a parameter vector>
%! gaussmf(0:100, [2 3 4 5])
%!error <gaussmf's second argument must be a parameter vector>
%! gaussmf(0:100, [90 80 30])
%!error <gaussmf's second argument must be a parameter vector>
%! gaussmf(0:100, 'abc')
