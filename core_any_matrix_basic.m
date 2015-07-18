function [info] = core_any_matrix_basic(img_index,N_proj,img_sz,aux,type,info)

if ~isempty(info.M)
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

if ~isempty(info.R)
    R = info.R;
else
[R, res, sol] = cgls_W(M, Q,[], 100, 1e-10);
end
npix = size(R,1); % number of pixels

min_c = min(sum(M,1));
upp_norm_xbin = floor(norm(Q,1)/min_c);

sqradius = upp_norm_xbin-dot(R,R);

[r, b, ordb, Ix, alpha] = round2binary(R);

parameter = sqradius - dot(alpha,alpha);

lim = 'notlimited'; % limited or notlimited
s_aux = bnwpixr(ordb,parameter,Ix,upp_norm_xbin,r,lim);
s =s_aux/npix;
[V V1 V2 wpix wpix2] = variability(npix,sqradius,s,ordb,parameter,Ix,upp_norm_xbin,r,lim);
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
info.upp_norm_xbin(aux,1) = upp_norm_xbin;
info.regular_norm_xbin(aux,1) = norm(Q,1)/N_proj;