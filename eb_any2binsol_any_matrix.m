function [EB_2binsol1, EB_2binsol2, EB_2binsol3] = ...
  eb_any2binsol_any_matrix(ordb, r, z, e, central_R, UB1, UB2, UB3)
%EB_ANY2BINSOL_ANY_MATRIX computes 3 error bounds for the number of pixel 
%  differences between any two binary solutions. 
%  Input parameters are computed in error_bounds_any_matrix.m
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% ---------------- Chapter 4 
% can use any of the 3 upper bounds for the norm of bin sol
% this code uses the bound from Theorem 4
% Theorem 7:

EB_2binsol1 = 4*(UB3 - dot(central_R,central_R))^2;

% ---------------- Chapter 5
% can use any of the 3 upper bounds for the norm of bin sol
% this code uses the bound from Theorem 4
% Theorem 11:

sq_radius = UB3 - dot(central_R,central_R);
dif_Rr = central_R - r;
parameter = sq_radius - dot(dif_Rr, dif_Rr);

EB_2binsol2 = error_bound4r(ordb, 2*parameter);

% ---------------- Chapter 6
% can only use upper bound for the norm of bin sol from Theorem 3
% Theorem 17:

sq_radius = UB2 - dot(central_R,central_R);
dif_Rr = central_R - r;
parameter = sq_radius - dot(dif_Rr, dif_Rr);

gamma = abs(2*central_R-1) + e.*(z-abs(r-1));
ord_gamma = sort(gamma);

EB_2binsol3 = error_bound4r(ord_gamma, 2*parameter);
%