
clear all;
img_sz_set = [32,64,128];%,512];
img_index_set = [1,2,3,5];
type_set = [1,2];%[0,1,2,3];
distance_to_source_set = [4,10];

for img_sz = img_sz_set
    if img_sz==32
        N_proj_set = [1,2,4,6,8,10,12,14,16];
    elseif img_sz==64
        N_proj_set = [2,4,8,12,16,20,24,28,32];
    elseif img_sz==128
        N_proj_set = [4,8,16,20,24,28,32,40,48,56,64];
    elseif img_sz==256
        N_proj_set = [8,16,32,40,48,56];%,64,72,80,88,96,104];
    elseif img_sz==512
        N_proj_set = [8,16,32,48];%,64,72,80,88,96,104,112,120,136,152,168,184,200];
    end
    %
    for typecod = type_set
        if typecod==0
            type = 'grid';
        elseif typecod==1
            type = 'strip';
        elseif typecod==2
            type = 'line';
        elseif typecod==3
            type = 'linear';
        end
        %
        for img_index = img_index_set;
            P = img_read(img_index,img_sz);
            P = reshape(P,img_sz^2,1);
            P = double(P);
            P = P/norm(P,inf); % only for binary images
            
            
        for di = distance_to_source_set
            for N_proj = N_proj_set;
                %
%                 proj_geom = astra_create_proj_geom('parallel',1.0,img_sz*1.5,linspace2(0,pi,N_proj));
%                 vol_geom = astra_create_vol_geom(img_sz,img_sz);
%                 %
%                 proj_id = astra_create_projector(type, proj_geom, vol_geom);
%                 matrix_id = astra_mex_projector('matrix', proj_id);
%                 %
%                 M = astra_mex_matrix('get',matrix_id);
%                 %
%                 astra_mex_matrix('delete',matrix_id);
%                 astra_mex_projector('delete',proj_id);
address = '/export/scratch1/fortes/fanbeam/';
Mname = strcat(address,'fan_',type,'_d',num2str(di),'_v',num2str(img_sz),'_a',num2str(N_proj),'.mat');
load(Mname);
M = W;
                %
                %----------------------------------------------------------
                %
                
                Q = M*P;
                
                [R, res, sol] = cgls_W(M, Q,[], 100, 1e-10);
                npix = length(R); % number of pixels
                
                const_one = ones(npix,1);
                y = lsqr(M',const_one,1e-10,100);
                
                const = M'*y;
                e_vec = const_one - const;
                
                sorted_e = sort(e_vec,'descend');
                v = sum(R);
                v2(1) = v;
                
                for i=1:npix
                v = v + sorted_e(i);
                v2(i+1) = v;
                end
                
                proj = num2str(N_proj);
                img = num2str(img_index);
                sz = num2str(img_sz);

                figura = plot([0:npix],v2,'k-','LineWidth',2,'MarkerSize',8);
                hold on
                plot([0:npix],[0:npix],'m-','LineWidth',2,'MarkerSize',8);
                legend('f(l) from Theorem 20','Number of pixels')
                axis([0 max(max(v2)+1,npix) min(v2)-1 max(v2)+1])
                hold off;
                set(gca,'fontsize',15)
                xlabel('Number of pixels','fontsize',20)
                ylabel('Function values','fontsize',20)
                %
                chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/graphs/curves/';
                filename = strcat(chemin,'curves-xbin-',type,'-Im',img,'-sz',sz,'-proj',proj,'_d',num2str(di),'.fig');
                saveas(figura,filename);
                clear figura
                
                %
                %----------------------------------------------------------
                %
            end
        end
        end
    end
end