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
## @deftypefn {Script File} {} linear_tip_demo
##
## Demonstrate the use of linear output membership functions to simulate
## constant membership functions.
##
## The demo:
## @itemize @bullet
## @item
## reads the FIS structure from a file
## @item
## plots the input membership functions
## @item
## plots the FIS output as a function of the inputs
## @item
## evaluates the Sugeno-type FIS for six inputs
## @end itemize
##
## @seealso{cubic_approx_demo, heart_disease_demo_1, heart_disease_demo_2, investment_portfolio_demo, mamdani_tip_demo, sugeno_tip_demo}
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy tests demos
## Note:          This example is based on an assignment written by
##                Dr. Bruce Segee (University of Maine Dept. of ECE).
## Directory:     fuzzy-logic-toolkit/inst
## Filename:      linear_tip_demo.m
## Last-Modified: 4 Jun 2024

## Read the FIS structure from a file.
fis = readfis ('linear_tip_calculator.fis');

## Plot the input membership functions.
plotmf (fis, 'input', 1);
plotmf (fis, 'input', 2);

## Plot the Tip as a function of Food-Quality and Service.
gensurf (fis);

## Calculate the Tip for 6 sets of input values: 
puts ("\nFor the following values of (Food Quality, Service):\n\n");
food_service = [1 1; 5 5; 10 10; 4 6; 6 4; 7 4]
puts ("\nThe Tip is:\n\n");
tip = evalfis (food_service, fis, 1001)

%!test
%! fis = readfis ('linear_tip_calculator.fis');
%! food_service = [1 1; 5 5; 10 10; 4 6; 6 4; 7 4];
%! tip = evalfis (food_service, fis, 1001);
%! expected_result = ...
%!   [10.000
%!    15.000
%!    20.000
%!    15.000
%!    15.000
%!    16.250];
%! assert(tip, expected_result, 1e-3);
