
clear all;
img_sz_set = 512;%[32,64,128];%,256];%[32,64,128,256,512];
img_index_set = 5;%[1,2,3,5];
data1 = initialize; data2 = initialize; data3 = initialize; data4 = initialize; data5 = initialize;
type_set = [2,3];%[0,1,2,3];
distance_to_source_set = [4];%,10];

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
            for di = distance_to_source_set
                data1.di = di; data2.di = di; data3.di = di;
                aux = 1;
                
                for N_proj = N_proj_set;
                    %
                    proj_geom = astra_create_proj_geom('parallel',1.0,img_sz*1.5,linspace2(0,pi,N_proj));
                    vol_geom = astra_create_vol_geom(img_sz,img_sz);
                    %
                    proj_id = astra_create_projector(type, proj_geom, vol_geom);
                    matrix_id = astra_mex_projector('matrix', proj_id);
                    %
                    data1.M = astra_mex_matrix('get',matrix_id);
                    data2.M = data1.M;
                    %
                    astra_mex_matrix('delete',matrix_id);
                    astra_mex_projector('delete',proj_id);
%                     %
%                     data1.M = [];
                    [data1] = core_any_matrix(img_index,N_proj,img_sz,aux,type,data1);
                    data2.R = data1.R; data3.R = data1.R; data4.R = data1.R; data5.R = data1.R;
                    data2.M = data1.M; data3.M = data1.M; data4.M = data1.M; data5.M = data1.M;
%                     [data2] = core_any_matrix_v2(img_index,N_proj,img_sz,aux,type,data2);
                    [data3] = core_any_matrix_v3_alternative(img_index,N_proj,img_sz,aux,type,data3);
                    %                 [data4] = core_any_matrix_v4(img_index,N_proj,img_sz,aux,type,data4);
                    %                 [data5] = core_any_matrix_basic(img_index,N_proj,img_sz,aux,type,data5);
                    aux = aux+1;
                end
                % ---------- Graphics -------------
                %
nxbin1 = data1.upp_norm_xbin; 
nxbin3 = data3.upp_norm_xbin; 
xbin = data1.norm_xbin;
%
it = N_proj_set;
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/graphs/';
%
% ------------------ norm xbin (plot) -------------------------------------
%
figura = plot(it,nxbin1-xbin,'k-s','LineWidth',3,'MarkerSize',10);
hold on
plot(it,nxbin3-xbin,'g-d','LineWidth',3,'MarkerSize',10);
legend('D(2)','D(3)')
hold off;
set(gca,'fontsize',17)
xlabel('Number of angles','fontsize',22)
ylabel('Number of pixels','fontsize',22)
%
filename = strcat(chemin,'Difplot-xbin-',type,'-Im',img,'-sz',sz,'d',num2str(di),'.fig');
saveas(figura,filename);
clear figura
%                             build_graph_comp_any_matrix_imp_test(data1,data2,data3,data5,N_proj_set,img_index,img_sz,type)
%                 build_graph_comp_any_matrix_improv(data1,data2,data3,N_proj_set,img_index,img_sz,type)
                data1 = initialize; data2 = initialize; data3 = initialize; data4 = initialize; data5 = initialize;
            end
        end
    end
end