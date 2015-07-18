function build_graph_comp_any_matrix_imp_test(data1,data2,data3,data5,proj,img_index,img_sz,type)
%
npix = img_sz^2;
%
V1 = data1.V2; V2 = data2.V2; V3 = data3.V2; V5 = data5.V2;
s1 = data1.s; s2 = data2.s; s3 = data3.s;  s5 = data5.s;
nxbin1 = data1.upp_norm_xbin; nxbin2 = data2.upp_norm_xbin; nxbin3 = data3.upp_norm_xbin;
nxbin5 = data5.upp_norm_xbin; reg_norm_xbin = data5.regular_norm_xbin;
Rr = data1.Rr;
xbin = data1.norm_xbin;
U = min(s1,min(s2,min(s3,s5)));
V = min(V1,min(V2,min(V3,V5)));
%
V12 = (data1.V2-data2.V2)*npix;
V13 = (data1.V2-data3.V2)*npix;
V23 = (data2.V2-data3.V2)*npix;
s12 = (data1.s-data2.s)*npix;
s13 = (data1.s-data3.s)*npix;
s23 = (data2.s-data3.s)*npix;
Rr12 = (data1.Rr-data2.Rr)*npix;
Rr13 = (data1.Rr-data3.Rr)*npix;
Rr23 = (data2.Rr-data3.Rr)*npix;
%
it = proj;
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/graphs/';
%
% ------------------ norm xbin (plot) -------------------------------------
%
figura = plot(it,nxbin1-xbin,'k-s','LineWidth',2,'MarkerSize',8);
hold on
plot(it,nxbin3-xbin,'g-d','LineWidth',2,'MarkerSize',8);
% plot(it,nxbin5-xbin,'m-+','LineWidth',2,'MarkerSize',8);
% plot(it,reg_norm_xbin-xbin,'r-o','LineWidth',2,'MarkerSize',8);
% legend('xbin(max)-xbin(true)','xbin(v3)-xbin(true)','xbin(basic)-xbin(true)','xbin(regular)-xbin(true)')
legend('D(2)','D(3)')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Difplot-xbin-',type,'-Im',img,'-sz',sz,'d',num2str(data1.di),'.fig');
saveas(figura,filename);
clear figura
% %
% % ------------------ norm xbin (semilogy) ---------------------------------
% %
% figura = semilogy(it,nxbin1,'k-s','LineWidth',2,'MarkerSize',8);
% hold on
% semilogy(it,nxbin3,'g-d','LineWidth',2,'MarkerSize',8);
% semilogy(it,nxbin5,'m-+','LineWidth',2,'MarkerSize',8);
% semilogy(it,reg_norm_xbin,'r-o','LineWidth',2,'MarkerSize',8);
% semilogy(it,xbin,'b-x','LineWidth',2,'MarkerSize',8);
% legend('xbin(max)','xbin(v3)','xbin(basic)','xbin(regular)','xbin(true)')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Diflogy-xbin-',type,'-Im',img,'-sz',sz,'.fig');
% saveas(figura,filename);
% clear figura
% %
% % ------------------ dif versions 1 and 2 ---------------------------------
% %
% figura = plot(it,V12,'m-+','LineWidth',2,'MarkerSize',8);
% hold on
% plot(it,s12,'r-o','LineWidth',2,'MarkerSize',8);
% % plot(it,Rr12,'k-s','LineWidth',2,'MarkerSize',8);
% legend('V1-V2','U1-U2')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Dif-v1v2-',type,'-Im',img,'-sz',sz,'.fig');
% saveas(figura,filename);
% clear figura
% %
% % ------------------ dif versions 1 and 3 ---------------------------------
% %
% it = proj;
% figura = plot(it,V13,'m-+','LineWidth',2,'MarkerSize',8);
% hold on
% plot(it,s13,'r-o','LineWidth',2,'MarkerSize',8);
% % plot(it,Rr13,'k-s','LineWidth',2,'MarkerSize',8);
% legend('V1-V3','U1-U3')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Dif-v1v3',type,'-Im',img,'-sz',sz,'.fig');
% saveas(figura,filename);
% clear figura
% %
% % ------------------ dif versions 2 and 3 ---------------------------------
% %
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
% %
% % ------------------ semilogy all U's and E -------------------------------
% %
% figura = semilogy(it,data5.s,'g-d','LineWidth',2,'MarkerSize',8);
% hold on
% semilogy(it,data1.s,'m-+','LineWidth',2,'MarkerSize',8);
% semilogy(it,data2.s,'b-x','LineWidth',2,'MarkerSize',8);
% semilogy(it,data3.s,'r-s','LineWidth',2,'MarkerSize',8);
% semilogy(it,data1.Rr,'k-o','LineWidth',2,'MarkerSize',8);
% legend('Vb','V1','V2','V3','E')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Bound_us-',type,'-Im',img,'-sz',sz,'.fig');
% saveas(figura,filename);
% clear figura
% %
% % ------------------ semilogy all V's and E -------------------------------
% %
% figura = semilogy(it,data5.V2,'g-d','LineWidth',2,'MarkerSize',8);
% hold on
% semilogy(it,data1.V2,'m-+','LineWidth',2,'MarkerSize',8);
% semilogy(it,data2.V2,'b-x','LineWidth',2,'MarkerSize',8);
% semilogy(it,data3.V2,'r-s','LineWidth',2,'MarkerSize',8);
% %
% legend('Vb','V1','V2','V3')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Bound_vs-',type,'-Im',img,'-sz',sz,'.fig');
% saveas(figura,filename);
% clear figura
% %
% % ------------------ semilogy best--------- -------------------------------
% %
% figura = semilogy(it,V,'r-x','LineWidth',2,'MarkerSize',8);
% hold on
% semilogy(it,U,'b-+','LineWidth',2,'MarkerSize',8);
% semilogy(it,data1.Rr,'k-s','LineWidth',2,'MarkerSize',8);
% %
% legend('Vbest','Ubest','Error')
% hold off;
% set(gca,'fontsize',15)
% xlabel('Number of angles','fontsize',20)
% ylabel('Fraction of pixels','fontsize',20)
% %
% filename = strcat(chemin,'Bound_best-',type,'-Im',img,'-sz',sz,'.fig');
% saveas(figura,filename);
% clear figura
%