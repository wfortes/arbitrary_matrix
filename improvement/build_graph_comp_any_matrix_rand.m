function build_graph_comp_any_matrix_rand(data1,data2,data3,proj,img_index,img_sz,type)
%
npix = img_sz^2;
%
V1 = data1.V2; V2 = data2.V2; V3 = data3.V2;
s1 = data1.s; s2 = data2.s; s3 = data3.s;  
nxbin1 = data1.upp_norm_xbin; nxbin2 = data2.upp_norm_xbin; nxbin3 = data3.upp_norm_xbin;
reg_norm_xbin = data1.regular_norm_xbin;
Rr = data1.Rr;
xbin = data1.norm_xbin;
U = min(s1,min(s2,s3));
V = min(V1,min(V2,V3));
%
V12 = (data1.V2-data2.V2)*npix;
V13 = (data1.V2-data3.V2)*npix;
V23 = (data2.V2-data3.V2)*npix;
s12 = (data1.s-data2.s)*npix; % Errado
s13 = (data1.s-data3.s)*npix; % Errado
s23 = (data2.s-data3.s)*npix; % Errado
%
it = proj;
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/improvement/graph_rand/';
%
% ------------------ norm xbin (plot) -------------------------------------
%
figura = plot(it,nxbin1-xbin,'k-s','LineWidth',2,'MarkerSize',8);
hold on
plot(it,nxbin3-xbin,'m-+','LineWidth',2,'MarkerSize',8);
plot(it,reg_norm_xbin-xbin,'r-o','LineWidth',2,'MarkerSize',8);
legend('xbin(max)-xbin(true)','xbin(v3)-xbin(true)','xbin(regular)-xbin(true)')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Difplot-xbin-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ norm xbin (semilogy) ---------------------------------
%
figura = semilogy(it,nxbin1,'k-s','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,nxbin3,'m-+','LineWidth',2,'MarkerSize',8);
semilogy(it,reg_norm_xbin,'r-o','LineWidth',2,'MarkerSize',8);
semilogy(it,xbin,'b-x','LineWidth',2,'MarkerSize',8);
legend('xbin(max)','xbin(v3)','xbin(regular)','xbin(true)')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Diflogy-xbin-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ dif versions 1 and 2 ---------------------------------
%
figura = plot(it,V12,'m-+','LineWidth',2,'MarkerSize',8);
hold on
plot(it,s12,'r-o','LineWidth',2,'MarkerSize',8);
% plot(it,Rr12,'k-s','LineWidth',2,'MarkerSize',8);
legend('V1-V2','U1-U2')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Dif-v1v2-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ dif versions 1 and 3 ---------------------------------
%
it = proj;
figura = plot(it,V13,'m-+','LineWidth',2,'MarkerSize',8);
hold on
plot(it,s13,'r-o','LineWidth',2,'MarkerSize',8);
% plot(it,Rr13,'k-s','LineWidth',2,'MarkerSize',8);
legend('V1-V3','U1-U3')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Dif-v1v3',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ dif versions 2 and 3 ---------------------------------
%
figura = plot(it,V23,'m-+','LineWidth',2,'MarkerSize',8);
hold on
plot(it,s23,'r-o','LineWidth',2,'MarkerSize',8);
% plot(it,Rr23,'k-s','LineWidth',2,'MarkerSize',8);
legend('V2-V3','U2-U3')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Dif-v2v3-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ semilogy all U's and E -------------------------------
%
figura = semilogy(it,data1.s,'m-+','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,data2.s,'b-x','LineWidth',2,'MarkerSize',8);
semilogy(it,data3.s,'r-s','LineWidth',2,'MarkerSize',8);
semilogy(it,data1.Rr,'k-o','LineWidth',2,'MarkerSize',8);
legend('V1','V2','V3','E')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Bound_us-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ semilogy all V's and E -------------------------------
%
figura = semilogy(it,data1.V2,'m-+','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,data2.V2,'b-x','LineWidth',2,'MarkerSize',8);
semilogy(it,data3.V2,'r-s','LineWidth',2,'MarkerSize',8);
%
legend('V1','V2','V3')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Bound_vs-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%
% ------------------ semilogy best--------- -------------------------------
%
figura = semilogy(it,V,'r-x','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,U,'b-+','LineWidth',2,'MarkerSize',8);
semilogy(it,data1.Rr,'k-s','LineWidth',2,'MarkerSize',8);
%
legend('Vbest','Ubest','Error')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
filename = strcat(chemin,'Bound_best-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura
%