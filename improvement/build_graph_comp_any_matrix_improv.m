function build_graph_comp_any_matrix_improv(data1,data2,data3,proj,img_index,img_sz,type)
%
npix = img_sz^2;
%
dxy = data3.dxy; dxy2 = data3.dxy2;
V2 = data2.V2; V3 = data3.V2;
s2 = data2.s; s3 = data3.s;
nxbin2 = data2.upp_norm_xbin; nxbin3 = data3.upp_norm_xbin;

Rr = data1.Rr;
xbin = data1.norm_xbin;
U = min(s2,s3);
V = min(V2,min(V3,min(dxy,dxy2)));
%
V23 = (data2.V2-data3.V2)*npix;
s23 = (data2.s-data3.s)*npix;
Rr23 = (data2.Rr-data3.Rr)*npix;
%
it = proj;
img = num2str(img_index);
sz = num2str(img_sz);
d = num2str(data1.di);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/graphs_parallel/';
%
% ------------------ dif versions 2 and 3 ---------------------------------
%
% figura = plot(it,V23,'m-+','LineWidth',2,'MarkerSize',8);
% hold on
% plot(it,s23,'r-o','LineWidth',2,'MarkerSize',8);
% % plot(it,Rr23,'k-s','LineWidth',2,'MarkerSize',8);
% legend('V2-V3','U2-U3')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Dif-v2v3-',type,'-Im',img,'-sz',sz,'.fig');
% saveas(figura,filename);
% clear figura
%
% ------------------ semilogy all U's and E -------------------------------
% %
figura = semilogy(it,data2.s,'k-x','LineWidth',3,'MarkerSize',10);
hold on
semilogy(it,data3.s,'m-+','LineWidth',3,'MarkerSize',10);
semilogy(it,data1.Rr,'r-s','LineWidth',3,'MarkerSize',10);
legend('U_s(1)','U_s(2)','E_s')
hold off;
set(gca,'fontsize',17)
xlabel('Number of angles','fontsize',23)
ylabel('Fraction of pixels','fontsize',23)
%
filename = strcat(chemin,'Bound_us-',type,'-Im',img,'-sz',sz,'-d',d,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ semilogy all V's and E -------------------------------
%
% figura = semilogy(it,data3.dxy,'g-d','LineWidth',3,'MarkerSize',10);
% hold on
% % semilogy(it,data3.dxy2,'m-+','LineWidth',2,'MarkerSize',8);
% semilogy(it,data2.V2,'b-x','LineWidth',3,'MarkerSize',10);
% semilogy(it,data3.V2,'r-s','LineWidth',3,'MarkerSize',10);
% %
% legend('U_d(1)','U_d(2)','U_d(3)')%,'U_d(4)')
% hold off;
% set(gca,'fontsize',17)
% xlabel('Number of angles','fontsize',23)
% ylabel('Fraction of pixels','fontsize',23)
% %
% filename = strcat(chemin,'Bound_vs-',type,'-Im',img,'-sz',sz,'.fig');%,'-d',d,'.fig');
% saveas(figura,filename);
% clear figura
% %
% % ------------------ semilogy best--------- -------------------------------
% %
% figura = semilogy(it,V,'k-x','LineWidth',2,'MarkerSize',8);
% hold on
% semilogy(it,U,'m-+','LineWidth',2,'MarkerSize',8);
% semilogy(it,data1.Rr,'r-s','LineWidth',2,'MarkerSize',8);
% %
% legend('U_d','U_s','E_s')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Bound_best-',type,'-Im',img,'-sz',sz,'-d',d,'.fig');
% saveas(figura,filename);
% clear figura
% %