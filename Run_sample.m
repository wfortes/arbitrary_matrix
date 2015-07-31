%This example computes 2 types of error bounds for binary tomography 
%without perturbation as in the paper: 
%   Quality bounds for binary tomography with arbitrary projection matrices
%   W. Fortes, K.J. Batenburg
%   Discrete Applied Mathematics, Vol. 183, 42-58, 2015
%
%The bounds are on the difference between:
%   any 2 binary solutions of the reconstruction problem
%   the rounded (to binary) central reconstruction and any binary solution
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

img_index = 1; % select image index
img_sz = 64; % select image dimension
N_proj_set = [2,4,8,12,16,20,24,28,32]; %Set of number of projection angles

data = initialize_data_str; % initialize variables for data structure

[dir_a,dir_b]=mkdirvecs(20); % create directions for projection matrix

% loads image
P = img_read(img_sz, img_index);
P = reshape(P,img_sz^2,1);
P = double(P);
P = P/norm(P,inf); % only for binary images

data.aux = 1;
for N_proj = N_proj_set
    
    % Projection matrix: This matrix has constant column sums
    M = mkmatrix(img_sz,img_sz,dir_a(1:N_proj),dir_b(1:N_proj));
    %
    Q = M*P; % Projetion of image P
    central_R = ls_solver(M, Q, [], [], []); % central reconstruction
    
    % Error bounds computation
    [data] = error_bounds_any_matrix(M, central_R, Q, data);
    
    % number of image pixels
    n_pix = size(P,1);
    % Difference between original image P and r, the rounded (to binary)
    % central recostruction, for comparison with bounds
    r = data.r{data.aux};
    data.Pr(data.aux,1) = norm(P-r,1)/n_pix;
    
    data.aux = data.aux+1;
end
% ---------- Graphics -------------
build_graph_error_bounds_any_matrix(data,N_proj_set)
%