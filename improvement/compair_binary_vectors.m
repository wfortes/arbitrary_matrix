clear all
img_sz_set = 512;
img_index_set = [1,2,3];%,5];
type_set = 1;
for img_sz = img_sz_set
    for typecod = type_set
        if typecod==0
            type = 'line';
        else
            type = 'linear';
        end
        for img_index = img_index_set;
            if img_index==1
                N_proj_set = [1:8];
            elseif img_index==2
                N_proj_set = [1:10];
            elseif img_index==3
                N_proj_set = [1:25];
            elseif img_index==5
                N_proj_set = [1:40];
            end
            aux = 1;
            Dist1 = zeros(length(N_proj_set),1); Dist2=Dist1;Dist3=Dist1;Dist4=Dist1;Dist5=Dist1;
            for N_proj = N_proj_set
                %
                proj_geom = astra_create_proj_geom('parallel',1.0,img_sz*1.5,linspace2(0,pi,N_proj));
                vol_geom = astra_create_vol_geom(img_sz,img_sz);
                %
                proj_id = astra_create_projector(type, proj_geom, vol_geom);
                matrix_id = astra_mex_projector('matrix', proj_id);
                %
                M = astra_mex_matrix('get',matrix_id);
                %
                astra_mex_matrix('delete',matrix_id);
                astra_mex_projector('delete',proj_id);
                %
                
                v = dart_img_read(img_index,N_proj);
                v = reshape(v,img_sz^2,1);
                v = double(v);
                v = v/norm(v,inf);
                
                P = img_read(img_index,img_sz);
                P = reshape(P,img_sz^2,1);
                P = double(P);
                
                P = P/norm(P,inf); % only for binary images
                Q = M*P;
                [R, res, sol] = cgls_W(M, Q,[], 100, 1e-10);
                npix = length(P);
                %
                const_one = ones(length(R),1);
                y = lsqr(M',const_one,1e-10,100);
                
                const = M'*y;
                e_vec = const_one - const;
                %
                % --------------- v2 --------------------------
                %
                idx_pos_e_vec = e_vec>0;
                
                z = zeros(length(R),1); z(idx_pos_e_vec) = 1;
                worst_residual = dot(e_vec,z);
                upp_norm_xbin = floor(sum(R) + worst_residual);
                
                sqradius = upp_norm_xbin-dot(R,R);
                
                [r, ~, ~, ~, alpha] = round2binary(R);
                
                b = abs(2*R-1);
                b = b + e_vec.*(z-abs(r-1));
                [ordb,Ix] = sort(b);
                
                parameter = sqradius - dot(alpha,alpha);
                
                lim = 'notlimited'; % limited or notlimited
                %                 [s_aux ixs] = bnwpixr(ordb,parameter,Ix,upp_norm_xbin,r,lim);
                %
                %                 Dist3(aux,1) = (s_aux+dot(r-v,r-v))/npix;
                
                dif = r-v;
                indxrv = find(dif==0);
                b = abs(2*R-1);
                b = (b + e_vec.*(z-abs(r-1)));%.*indxrv;
                b = b(indxrv);
                [ordb,Ix] = sort(b);
                s_aux = bnwpixr(ordb,parameter,Ix,upp_norm_xbin,r(indxrv),lim);
                
                Dist3(aux,1) = (s_aux+dot(r-v,r-v))/npix;
                %
                % --------------- v3 --------------------------
                %
                sorted_e = sort(e_vec,'descend');
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
                    end
                end
                
                sqradius = upp_norm_xbin-dot(R,R);
                
                [r, ~, ordb, Ix, alpha] = round2binary(R);
                
                parameter = sqradius - dot(alpha,alpha);
                
                lim = 'notlimited';
                s_aux = bnwpixr(ordb,parameter,Ix,upp_norm_xbin,r,lim);
                s =s_aux/npix;
                [V V1 V2 wpix wpix2] = variability(npix,sqradius,s,ordb,parameter,Ix,upp_norm_xbin,r,lim);
                Rr = norm(P-r,1)/npix;
                
                Dist1(aux,1) = (sqrt(sqradius)+norm(v-R))^2/npix;
                %                 Dist2(aux,1) = 3*(sum(R)-dot(R,R))/npix+sum(e_vec)/npix;
                dist2 = sum(R)-3*dot(R,R)+norm(v-R)^2+2*dot(v,R)+sum(max(zeros(npix,1),e_vec+2*R-2*v));
                Dist2(aux,1) = dist2/npix;
                
                dif = r-v;
                indxrv = find(dif==0);
                b = abs(2*R-1);
                b = b(indxrv);
                [ordb,Ix] = sort(b);
                s_aux = bnwpixr(ordb,parameter,Ix,upp_norm_xbin,r(indxrv),lim);
                
                Dist4(aux,1) = (s_aux+dot(r-v,r-v))/npix;
                Dist5(aux,1) = norm(v-P,1)/npix;
                
                aux = aux+1;
            end
            it = N_proj_set;
            figura = semilogy(it,Dist1,'g-d','LineWidth',2,'MarkerSize',8);
            hold on
            semilogy(it,Dist2,'m-+','LineWidth',2,'MarkerSize',8);
            semilogy(it,Dist3,'b-x','LineWidth',2,'MarkerSize',8);
            semilogy(it,Dist4,'k-o','LineWidth',2,'MarkerSize',8);
            semilogy(it,Dist5,'r-s','LineWidth',2,'MarkerSize',8);
            
            legend('U_a(1)','U_a(2)','U_a(3)','U_a(4)','E_a')
            hold off;
            set(gca,'fontsize',15)
            xlabel('Number of projections','fontsize',20)
            ylabel('Fraction of pixels','fontsize',20)
            %
            img = num2str(img_index);
            sz = num2str(img_sz);
            proj = num2str(N_proj);
            
            chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/';
            filename = strcat(chemin,'UE-DART-',type,'-Im',img,'-sz',sz,'p',proj,'.fig');
            saveas(figura,filename);
            clear figura
            %
        end
    end
end
