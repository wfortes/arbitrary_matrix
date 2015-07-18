function [info] = core_any_matrix_v3_alternative(img_index,N_proj,img_sz,aux,type,info)

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

if  ~isempty(info.R) %exist('info.R','var') &&
    R = info.R;
else
    [R, res, sol] = cgls_W(M, Q,[], 100, 1e-10);
end
npix = size(R,1); % number of pixels

const_one = ones(length(R),1);
y = lsqr(M',const_one,1e-10,100);

% weighted_sum_Q = y'*Q;
const = M'*y;
e_vec = const_one - const;

sorted_e = sort(e_vec,'descend');
% upp_norm_xbin = weighted_sum_Q;
upp_norm_xbin = sum(R);
idx_pos_e_vec = e_vec>0;
largest_e = sum(e_vec(idx_pos_e_vec));

for i = 1:length(e_vec)
    upp_norm_xbin = upp_norm_xbin + sorted_e(i);
    if (upp_norm_xbin < i) && (upp_norm_xbin - sorted_e(i) >= i-1)
        upp_norm_xbin = floor(upp_norm_xbin);
        break
    end
end
if upp_norm_xbin > sum(R)+largest_e
    if upp_norm_xbin == length(e_vec)
        upp_norm_xbin = 0;
%     else
%         upp_norm_xbin = floor(sum(R)+largest_e);
    end
end

sqradius = upp_norm_xbin-dot(R,R);

[r, ~, ordb, Ix, alpha] = round2binary(R);

parameter = sqradius - dot(alpha,alpha);

lim = 'notlimited'; % limited or notlimited
s_aux  = bnwpixr(ordb,parameter,Ix,upp_norm_xbin,r,lim);
s =s_aux/npix;
[V V1 V2 wpix wpix2] = variability(npix,sqradius,s,ordb,parameter,Ix,upp_norm_xbin,r,lim);
Rr = norm(P-r,1)/npix;

% computation from 22/01/2013
xe = (2*R+e_vec);
xe_aux = xe > 0 & xe >= 2*xe-2; % xe<=2
xee_aux = xe > 1 & xe < 2*xe-2; % xe>2

dxy2 = 2*sum(R)-4*sum(R.*R)+sum(xe_aux.*xe)+sum(xee_aux.*xe*2)-2*sum(xee_aux);
    

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

info.dxy(aux,1) = 4*sqradius/npix;
% info.dxy2(aux,1) = (4*sum(R)+sum(e_vec)-4*dot(R,R))/npix;
info.dxy2(aux,1) = dxy2/npix;