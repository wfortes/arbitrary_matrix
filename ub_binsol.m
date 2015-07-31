function [UB1, UB2, UB3] = ub_binsol(e, z, central_R, Q, M)
%UB_BINSOL computes upper bounds for the l1-norm of any binary solution of
%the reconstruction problem
%
% Wagner Fortes 2014/2015 wfortes@gmail.com

% Theorem 1
delta_minus = min(ones(size(M,1),1)'*M);
UB1 = floor(sum(Q)/delta_minus);

% Theorem 3
UB2 = floor(sum(central_R) + dot(e,z));

% Theorem 4
sorted_e = sort(e,'descend');

UB3 = sum(central_R);
for i = 1:length(e)
    UB3 = UB3 + sorted_e(i);
    if (UB3 < i) && (UB3 - sorted_e(i) >= i-1)
        UB3 = floor(UB3);
        break
    end
end
if UB3 == length(e)&& UB3 > sum(central_R) +  sum(e(e > 0))
    UB3 = 0;
end
