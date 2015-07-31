function build_graph_error_bounds_any_matrix(data,proj)
% Build three graphs

figure;
semilogy(proj,data.UB1(:,1),'b-s','LineWidth',2,'MarkerSize',8);
hold on
semilogy(proj,data.UB2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
semilogy(proj,data.UB3(:,1),'k-o','LineWidth',2,'MarkerSize',8);

legend('EB1','EB2','EB3')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Number of pixels','fontsize',20)
title('Upper bounds on the number of ones in any binary solution','fontsize',11)
%
%--------------------------------------------------------------------------
%
figure;
semilogy(proj,data.V1(:,1),'b-s','LineWidth',2,'MarkerSize',8);
hold on
semilogy(proj,data.V2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
semilogy(proj,data.V3(:,1),'k-o','LineWidth',2,'MarkerSize',8);

legend('EB1','EB2','EB3')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
title('Error bounds on the difference between 2 binary solutions','fontsize',11)
%
%--------------------------------------------------------------------------
%
figure;
semilogy(proj,data.U1(:,1),'b-s','LineWidth',2,'MarkerSize',8);
hold on
semilogy(proj,data.U2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
semilogy(proj,data.Pr(:,1),'k-o','LineWidth',2,'MarkerSize',8);

legend('EB1','EB2','Pr')
hold off;
set(gca,'fontsize',15)
xlabel('Number of angles','fontsize',20)
ylabel('Fraction of pixels','fontsize',20)
title('Error bounds on the difference between r and any binary solution','fontsize',11)
%
%--------------------------------------------------------------------------
%
