function str = error_bounds_any_matrix(W, central_R, Q, str)
%ERROR_BOUNDS_ANY_MATRIX is the core code for computing 2 types of error 
%bounds for binary tomography without perturbation as in the paper: 
%   Quality bounds for binary tomography with arbitrary projection matrices
%   W. Fortes, K.J. Batenburg
%   Discrete Applied Mathematics, Vol. 183, 42-58, 2015
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% If reconstruction is not given then compute it
if isempty(central_R)
    central_R = ls_solver(W, Q, str.solver, str.maxit, str.tol);
end

% computes residual vector e
e_vec = residual_e(W);

% z is binary vector that maximizes central radius
z = zeros(length(e_vec),1); 
z(e_vec > 0) = 1;

% upper bounds for the l1-norm of any binary solution of the reconstrution
% problem
[UB1, UB2, UB3] = ub_binsol(e_vec, z, central_R, Q, W);

% r is the rounded (to binary) vector 
% ordb is the sorted vector of increments 
% Ixb are the indexes of the sorting
[r, ~, ordb, ~] = round2binary(central_R);

% =========================== Error bounds ================================

% Error bounds for the number of pixel differences between any two binary 
% solutions.
[EB_2binsol1, EB_2binsol2, EB_2binsol3] = ...
    eb_any2binsol_any_matrix(ordb, r, z, e_vec, central_R, UB1, UB2, UB3);
%--------------------------------------------------------------------------

% Error bound for the number of pixel differences between the binary 
% rounded vector r and any binary solution. 
[EB_rxbinsol1, EB_rxbinsol2] = ...
    eb_rxbinsol_any_matrix(ordb, r, z, e_vec, central_R, UB1, UB2, UB3);

%--------------------------------------------------------------------------

% number of image pixels
n_pix = size(central_R,1);

% output structure str
aux = str.aux;
str.r{aux} = r;

str.UB1(aux,1) = UB1;
str.UB2(aux,1) = UB2;
str.UB3(aux,1) = UB3;

str.V1(aux,1) = EB_2binsol1/n_pix; % error relative to image size
str.V2(aux,1) = EB_2binsol2/n_pix; % error relative to image size
str.V3(aux,1) = EB_2binsol3/n_pix; % error relative to image size

str.U1(aux,1) = EB_rxbinsol1/n_pix; % error relative to image size
str.U2(aux,1) = EB_rxbinsol2/n_pix; % error relative to image size
%