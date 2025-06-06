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
## @deftypefn {Function File} {@var{vxb} =} xie_beni_index (@var{input_data}, @var{cluster_centers}, @var{soft_partition})
##
## Return the Xie-Beni validity index for a given soft partition.
##
## The arguments to xie_beni_index are:
## @itemize @w
## @item
## @var{input_data}: a matrix of input data points; each row corresponds to one point
## @item
## @var{cluster_centers}: a matrix of cluster centers; each row corresponds to one point
## @item
## @var{soft_partition}: the membership degree of each input data point in each cluster
## @end itemize
##
## The return value is:
## @itemize @w
## @item
## @var{vxb}: the Xie-Beni validity index for the given partition
## @end itemize
##
## To run demonstration code that uses this function, type "@t{demo fcm}"
## or "@t{demo gustafson_kessel}" (without the quotation marks) at the
## Octave prompt.
##
## For more information about the @var{input_data}, @var{cluster_centers},
## and @var{soft_partition} matrices, please see the documentation for function
## fcm.
##
## @seealso{fcm, gustafson_kessel, partition_coeff, partition_entropy}
##
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy xie beni cluster validity
## Directory:     fuzzy-logic-toolkit/inst/
## Filename:      xie_beni_index.m
## Last-Modified: 13 Jun 2024

function vxb = xie_beni_index (input_data, cluster_centers, ...
                               soft_partition)

  ## If xie_beni_index was called with an incorrect number of arguments,
  ## or the argument does not have the correct type, print an error
  ## message and halt.

  if (nargin != 3)
    error ("xie_beni_index requires 3 arguments\n");
  elseif (!is_real_matrix (input_data))
    error ("xie_beni_index's first argument must be matrix of reals\n");
  elseif (!(is_real_matrix (cluster_centers) &&
            (columns (cluster_centers) == columns (input_data))))
    error ("xie_beni_index's 2nd arg must be matrix of reals with same #cols as input_data\n");
  elseif (!(is_real_matrix (soft_partition) &&
            (min (min (soft_partition)) >= 0) &&
            (max (max (soft_partition)) <= 1)))
    error ("xie_beni_index's 3rd arg must be a matrix of reals 0.0-1.0\n");
  endif

  ## Compute and return the Xie-Beni index.

  vxb = xie_beni_private (input_data, cluster_centers, soft_partition);

endfunction

##----------------------------------------------------------------------
## Function: xie_beni_private
## Purpose:  Return the Xie-Beni index for the given soft partition.
## Note:     The following is an implementation of Equations 13.11,
##           13.12, and 13.13 in Fuzzy Logic: Intelligence, Control and
##           Information, by J. Yen and R. Langari, Prentice Hall, 1999,
##           page 384 (International Edition). 
##----------------------------------------------------------------------

function vxb = xie_beni_private (X, V, Mu)

  sqr_dist = square_distance_matrix (X, V);
  sum_sigma = sum (sum (Mu .* sqr_dist));
  n = rows (X);
  d_sqr_min = min_sqr_dist_between_centers (V);
  vxb = sum_sigma / (n * d_sqr_min);

endfunction

##----------------------------------------------------------------------
## Function: min_sqr_dist_between_centers
## Purpose:  Return the square of the minimum distance between
##           cluster centers.
##----------------------------------------------------------------------

function d_sqr_min = min_sqr_dist_between_centers (V)

  k = rows (V);
  d_sqr_matrix = NaN(k, k);

  for i = 1 : (k - 1)
    Vi = V(i, :);
    for j = (i + 1) : k
      Vi_to_Vj = V(j, :) - Vi;
      d_sqr_matrix(i, j) = sum (Vi_to_Vj .* Vi_to_Vj);
    endfor
  endfor

  d_sqr_min = min (min (d_sqr_matrix));

endfunction

## Test input validation
%!error <xie_beni_index requires 3 arguments>
%! xie_beni_index()
%!error <xie_beni_index requires 3 arguments>
%! xie_beni_index(1)
%!error <xie_beni_index requires 3 arguments>
%! xie_beni_index(1, 2)
%!error <xie_beni_index: function called with too many inputs>
%! xie_beni_index(1, 2, 3, 4)
%!error <xie_beni_index's first argument must be matrix of reals>
%! xie_beni_index(1j, 2, 3)
%!error <xie_beni_index's 2nd arg must be matrix of reals with same #cols as input_data>
%! xie_beni_index(1, [2 2], 3)
%!error <xie_beni_index's 3rd arg must be a matrix of reals 0.0-1.0>
%! xie_beni_index([1 1], [2 2], 3j)

