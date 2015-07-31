function [EB_rxbinsol1, EB_rxbinsol2] = ...
    eb_rxbinsol_any_matrix(ordb, r, z, e, central_R, UB1, UB2, UB3)
%EB_RXBINSOL_ANY_MATRIX computes 2 error bounds for the number of pixel 
%  differences between rounded binary vector r and any binary solutions.
%  Input parameters are computed in error_bounds_any_matrix.m

% ---------------- Chapter 5
% can use any of the 3 upper bounds for the norm of bin sol
% this code uses the bound from Theorem 4
% Theorem 9:
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

sq_radius = UB3 - dot(central_R,central_R);
dif_Rr = central_R - r;
parameter = sq_radius - dot(dif_Rr, dif_Rr);

EB_rxbinsol1 = error_bound4r(ordb, parameter);

% ---------------- Chapter 6
% can only use upper bound for the norm of bin sol from Theorem 3
% Theorem 15:

sq_radius = UB2 - dot(central_R,central_R);
dif_Rr = central_R - r;
parameter = sq_radius - dot(dif_Rr, dif_Rr);

gamma = abs(2*central_R-1) + e.*(z-abs(r-1));
ord_gamma = sort(gamma);

EB_rxbinsol2 = error_bound4r(ord_gamma, parameter);
%

