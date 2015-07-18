function build_graph_comp_any_matrix(data1,data2,data3,proj,img_index,img_sz,type)
% 
it = proj;
figura = semilogy(it,data1.V2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
hold on
semilogy(it,data1.s(:,1),'m-+','LineWidth',2,'MarkerSize',8);
semilogy(it,data1.Rr(:,1),'m-+','LineWidth',2,'MarkerSize',8);

semilogy(it,data2.V2(:,1),'r-o','LineWidth',2,'MarkerSize',8);
semilogy(it,data2.s(:,1),'r-o','LineWidth',2,'MarkerSize',8);
semilogy(it,data2.Rr(:,1),'r-o','LineWidth',2,'MarkerSize',8);

semilogy(it,data3.V2(:,1),'k-s','LineWidth',2,'MarkerSize',8);
semilogy(it,data3.s(:,1),'k-s','LineWidth',2,'MarkerSize',8);
semilogy(it,data3.Rr(:,1),'k-s','LineWidth',2,'MarkerSize',8);

legend('V','U','E','Vb','Ub','Eb','Vany','Uany','Eany')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
%
img = num2str(img_index);
sz = num2str(img_sz);
chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/';%Graphs/';
filename = strcat(chemin,'V+U+E-',type,'-Im',img,'-sz',sz,'.fig');
saveas(figura,filename);
clear figura

