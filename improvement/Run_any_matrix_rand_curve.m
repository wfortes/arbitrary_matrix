
clear all;
img_sz_set = [32,64,128];
img_index_set = [1,2,3,5];
data1 = initialize; data2 = initialize; data3 = initialize; 
type_set = [0,1,2];

for img_sz = img_sz_set
    if img_sz==32
        N_proj_set = [8,10,12,14,16];
    elseif img_sz==64
        N_proj_set = [16,20,24,28,32];
    elseif img_sz==128
        N_proj_set = [,24,28,32,40,48,56,64];
    elseif img_sz==256
        N_proj_set = [56,64,72,80,88,96,104];
    elseif img_sz==512
        N_proj_set = [80,88,96,104,112,120,136,152];
    end
    %
    for typecod = type_set
        if typecod==0
            type = '[0,1]';
            a=0;b=1;
        elseif typecod==1
            type = '[-1,1]';
            a=-1;b=1;
        elseif typecod==2
            type = '[-2,2]';
            a=-2;b=2;
        end
        %
        for img_index = img_index_set;
            P = img_read(img_index,img_sz);
            P = reshape(P,img_sz^2,1);
            P = double(P);
            P = P/norm(P,inf); % only for binary images
            for N_proj = N_proj_set;
                %
                address = '/ufs/fortes/Link_to_Music/work/Load/';
                N = loadmatrix(address,img_sz,N_proj,'strip','matrix');
                %
                if N_proj == N_proj_set(1)
                    M = a + (b-a).*rand(size(N,1),size(N,2));
                else
                    r = size(N,1)-size(M,1);
                    M_aux = a + (b-a).*rand(r,size(N,2));
                    M = [M;M_aux];
                end
                %
                Q = M*P;
                
                [R, res, sol] = cgls_W(M, Q, 100, 1e-10);
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
                chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/graph_rand/curves/';
                filename = strcat(chemin,'curves-xbin-',type,'-Im',img,'-sz',sz,'-proj',proj,'.fig');
                saveas(figura,filename);
                clear figura
            end
            clear M
        end
    end
end