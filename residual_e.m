function e = residual_e(M)
%RESIDUAL_E computes the residual vector E from Lemma 2
%   M is the underdetermined matrix
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

const_one = ones(size(M,2),1);
yls = ls_solver(M', const_one, 'lsqr', 100, 1e-6);
e = const_one - M'*yls;