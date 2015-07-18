function [info] = core_any_matrix_v3(img_index,N_proj,img_sz,aux,type,info)

if ~isempty(info.M) %&& exist('info.M','var')
    M = info.M;
else
    address = '/ufs/fortes/Desktop/PhD_m_files/tomography/Load/';
    M = loadmatrix(address,img_sz,N_proj,type,'matrix');
end

P = img_read(img_index,img_sz);
P = reshape(P,img_sz^2,1);
P = double(P);
P = P/norm(P,inf); % only for binary images
Q = M*P;

if exist('info.R','var') && ~isempty(info.R)
    R = info.R;
else
    [R, res, sol] = cgls_W(M, Q, 100, 1e-10);
end
npix = size(R,1); % number of pixels

const_one = ones(length(R),1);
y = lsqr(M',const_one,1e-10,100);

weigthed_sum_Q = y'*Q;
const = M'*y;
e_vec = const - const_one;
idx_neg_e_vec = e_vec<0;
idx_pos_e_vec = e_vec>0;
sorted_e = sort(e_vec);
upp_norm_xbin = weigthed_sum_Q;

for i = 1:length(e_vec)
    upp_norm_xbin = upp_norm_xbin - sorted_e(i);
    if upp_norm_xbin < i
        break
    end
end

sqradius = upp_norm_xbin-dot(R,R);

[r, ~, ~, ~, alpha] = round2binary(R);
b = abs(2*R-1);
b(idx_neg_e_vec) = b(idx_neg_e_vec) - r(idx_neg_e_vec).*e_vec(idx_neg_e_vec);
b(idx_pos_e_vec) = b(idx_pos_e_vec) + abs(r(idx_pos_e_vec)-1).*e_vec(idx_pos_e_vec);
[ordb,Ix] = sort(b);

parameter = sqradius - dot(alpha,alpha);

lim = 'notlimited'; % limited or notlimited
[s_aux ixs] = bnwpixr(ordb,parameter,Ix,upp_norm_xbin,r,lim,R);
s =s_aux/npix;
[V V1 V2 wpix wpix2] = variability(npix,sqradius,s,ordb,parameter,Ix,upp_norm_xbin,r,lim,R);
Rr = norm(P-r,1)/npix;

% output structure
info.R = R;
info.M = M;
info.Rr(aux,1) = Rr;
info.s(aux,1) = s;
info.V(aux,1) = V;
info.V1(aux,1) = V1;
info.V2(aux,1) = V2;
info.wpix(aux,1) = wpix;
info.wpix2(aux,1) = wpix2;