function build_graph_comp_any_matrix_imp(data1,data2,data3,proj,img_index,img_sz,typeshort)
% 
V1 = data1.V2;
V2 = data2.V2;
V3 = data3.V2;
s1 = data1.s;
s2 = data2.s;
s3 = data3.s;
Rr1 = data1.Rr;
Rr2 = data2.Rr;
Rr3 = data3.Rr;
%
it = proj;
figura = semilogy(it,V1,'m-+','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,V2,'k-o','LineWidth',2,'MarkerSize',8);
semilogy(it,s1,'m-+','LineWidth',2,'MarkerSize',8);
semilogy(it,s2,'k-o','LineWidth',2,'MarkerSize',8);
semilogy(it,Rr1,'m-+','LineWidth',2,'MarkerSize',8);
semilogy(it,Rr2,'k-o','LineWidth',2,'MarkerSize',8);

legend('V','Vv2','U','Uv2','E','Ev2')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
img = num2str(img_index);
sz = num2str(img_sz);
d = num2str(data1.di);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/semilogy_v1v2/';
filename = strcat(chemin,'Bound_nconst_orig_v2-',typeshort,'-Im',img,'-sz',sz,'-d',d,'.fig');
saveas(figura,filename);
clear figura
%
% -------------------------------------------------------------------------
%
it = proj;
figura = semilogy(it,V1,'m-+','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,V3,'k-o','LineWidth',2,'MarkerSize',8);
semilogy(it,s1,'m-+','LineWidth',2,'MarkerSize',8);
semilogy(it,s3,'k-o','LineWidth',2,'MarkerSize',8);
semilogy(it,Rr1,'m-+','LineWidth',2,'MarkerSize',8);
semilogy(it,Rr3,'k-o','LineWidth',2,'MarkerSize',8);

legend('V','Vv3','U','Uv3','E','Ev3')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/semilogy_v1v3/';
filename = strcat(chemin,'Bound_nconst_orig_v3-',typeshort,'-Im',img,'-sz',sz,'-d',d,'.fig');
saveas(figura,filename);
clear figura
%
% -------------------------------------------------------------------------
%
it = proj;
figura = semilogy(it,V2,'m-+','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,s2,'r-o','LineWidth',2,'MarkerSize',8);
semilogy(it,Rr2,'k-s','LineWidth',2,'MarkerSize',8);

legend('V','U','E')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/semilogy_v2/';
filename = strcat(chemin,'Bound_nconst_orig_v2-',typeshort,'-Im',img,'-sz',sz,'-d',d,'.fig');
saveas(figura,filename);
clear figura
%
% -------------------------------------------------------------------------
%
it = proj;
figura = semilogy(it,V3,'m-+','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,s3,'r-o','LineWidth',2,'MarkerSize',8);
semilogy(it,Rr3,'k-s','LineWidth',2,'MarkerSize',8);

legend('V','U','E')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/semilogy_v3/';
filename = strcat(chemin,'Bound_nconst_orig_v3-',typeshort,'-Im',img,'-sz',sz,'-d',d,'.fig');
saveas(figura,filename);
clear figura
%
% -------------------------------------------------------------------------
%
it = proj;
figura = plot(it,V2,'m-+','LineWidth',2,'MarkerSize',8);
hold on
plot(it,s2,'r-o','LineWidth',2,'MarkerSize',8);
plot(it,Rr2,'k-s','LineWidth',2,'MarkerSize',8);

legend('V','U','E')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/plot_v2/';
filename = strcat(chemin,'Bound_nconst_orig_v2-',typeshort,'-Im',img,'-sz',sz,'-d',d,'.fig');
saveas(figura,filename);
clear figura
%
% -------------------------------------------------------------------------
%
it = proj;
figura = plot(it,V3,'m-+','LineWidth',2,'MarkerSize',8);
hold on
plot(it,s3,'r-o','LineWidth',2,'MarkerSize',8);
plot(it,Rr3,'k-s','LineWidth',2,'MarkerSize',8);

legend('V','U','E')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/plot_v3/';
filename = strcat(chemin,'Bound_nconst_orig_v3-',typeshort,'-Im',img,'-sz',sz,'-d',d,'.fig');
saveas(figura,filename);
clear figura
