
clear all;
img_sz_set = [32,64,128];
img_index_set = [1,2,3,5];
data1 = initialize; data2 = initialize; data3 = initialize; 
type_set = [0,1];%,2];

for img_sz = img_sz_set
    if img_sz==32
        N_proj_set = [1,2,4,6,8,10,12,14,16];
    elseif img_sz==64
        N_proj_set = [2,4,8,12,16,20,24,28,32];
    elseif img_sz==128
        N_proj_set = [4,8,16,20,24,28,32,40,48,56,64];
    elseif img_sz==256
        N_proj_set = [8,16,32,40,48,56,64,72,80,88,96,104];
    elseif img_sz==512
        N_proj_set = [8,16,32,48,64,72,80,88,96,104,112,120,136,152,168,184,200];
    end
    %
    for typecod = type_set
        if typecod==0
            type = '0,1';
            a=0;b=1;
        elseif typecod==1
            type = '-1,1';
            a=-1;b=1;
        elseif typecod==2
            type = '-2,2';
            a=-2;b=2;
        end
        %
        for img_index = img_index_set;
            aux = 1;
            M = [];
            for N_proj = N_proj_set;
                %
                address = '/export/scratch1/fortes/PhD_files/Load/matrix/';
                N = loadmatrix(address,img_sz,N_proj,'strip','matrix');
                %
                if N_proj == N_proj_set(1)
                    M = a + (b-a).*rand(size(N,1),size(N,2));
                else
                    r = size(N,1)-size(M,1);
                    M_aux = a + (b-a).*rand(r,size(N,2));
                    M = [M;M_aux];
%                     soma = sum(M); 
%                     max(soma)
%                     min(soma)
                end
                %
                data1.M = M;
                [data1] = core_any_matrix(img_index,N_proj,img_sz,aux,type,data1);
                data2.R = data1.R; data3.R = data1.R; 
                data2.M = data1.M; data3.M = data1.M; 
                [data2] = core_any_matrix_v2(img_index,N_proj,img_sz,aux,type,data2);
                [data3] = core_any_matrix_v3_alternative(img_index,N_proj,img_sz,aux,type,data3);
                
                aux = aux+1;
            end
            % ---------- Graphics -------------
            %
%             build_graph_comp_any_matrix_rand(data1,data2,data3,N_proj_set,img_index,img_sz,type)
build_graph_comp_any_matrix_improv(data1,data2,data3,N_proj_set,img_index,img_sz,type)
            data1 = initialize; data2 = initialize; data3 = initialize; 
        end
    end
end