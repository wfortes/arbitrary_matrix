clear all;
img_sz_set = [32,64,128];%,256];%,512];
img_index_set = [1,2,3,5];
data1 = initialize; data2 = initialize; data3 = initialize;
type_set = [1,2];%[0,1,2,3];
distance_to_source_set = [4,10];

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
        
        for di = distance_to_source_set
            data1.di = di; data2.di = di; data3.di = di;
            for img_index = img_index_set;
                aux = 1;
                
                for N_proj = N_proj_set;
                    [data1] = core_any_matrix(img_index,N_proj,img_sz,aux,type,data1);
                    data2.R = data1.R; data3.R = data1.R;
                    data2.M = data1.M; data3.M = data1.M;
                    [data2] = core_any_matrix_v2(img_index,N_proj,img_sz,aux,type,data2);
                    [data3] = core_any_matrix_v3(img_index,N_proj,img_sz,aux,type,data3);
                    aux = aux+1;
                end
                % ---------- Graphics -------------
                build_graph_comp_any_matrix_imp(data1,data2,data3,N_proj_set,img_index,img_sz,type)
                data1 = []; data2 = []; data3 = [];
            end
        end
    end
end