function [info] = core_any_matrix(img_index,N_proj,img_sz,aux,type,info)

if ~isempty(info.M)
    M = info.M;
else
address = '/export/scratch1/fortes/fanbeam/';%'/export/scratch1/Music/work/Load/'; 
% M = loadmatrix(address,img_sz,N_proj,type,'matrix');
Mname = strcat(address,'fan_',type,'_d',num2str(info.di),'_v',num2str(img_sz),'_a',num2str(N_proj),'.mat');
    load(Mname);
    M = W;
end

P = img_read(img_index,img_sz);
P = reshape(P,img_sz^2,1);
P = double(P);
P = P/norm(P,inf); % only for binary images
norm_xbin = norm(P,1);
Q = M*P;

% if ~isempty(info.R)
%     R = info.R;
% else
[R, res, sol] = cgls_W(M, Q,[], 100, 1e-10);
% end
npix = size(R,1); % number of pixels

const_one = ones(length(R),1);
y = lsqr(M',const_one,1e-10,100);

const = M'*y;
e_vec = const_one - const;
idx_max_e_vec = e_vec>0;

weigthed_sum_Q = y'*Q;
worst_residual = sum(e_vec(idx_max_e_vec));

upp_norm_xbin = floor(weigthed_sum_Q + worst_residual);

sqradius = upp_norm_xbin - dot(R,R);

[r, ~, ordb, Ix, alpha] = round2binary(R);

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
info.norm_xbin(aux,1) = norm_xbin;
info.regular_norm_xbin(aux,1) = norm(Q,1)/N_proj;