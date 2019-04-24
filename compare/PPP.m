%%% Part1 %%%
function Location=PPP(Lambda,L)
%Lambda = 100;  
u = unifrnd(0,1);
M = 0;
while u >= exp(-Lambda)%判定条件
    u = u*unifrnd(0,1);
    M=M+1;
end 
    %取点个数
R = poissrnd(Lambda,1,M) ;

%%% Part2 %%%
a = 0; c = 0;
b = L; d =L;     %取[0,100]*[0,100]的布点区域；
Nall = M;
% A = [];
% B = [];
while M > 0         %scatter in the [0,100]*[0,100]
    M = M-1;
    u1 = unifrnd(0,1);
    A(Nall-M) = (b-a)*u1;
    u2 = unifrnd(0,1);
    B(Nall-M) = (d-c)*u2;
    %u3 = unifrnd(0,1);
    % C(Nall-M) = (f-e)*u3;
 %   figure(1)    %base stations 分布图
   % plot3(A(Nall-M),B(Nall-M),C(Nall-M),'r^');
    %hold on;
 %   plot(A(Nall-M),B(Nall-M),'b.')
  %  hold on
end
%grid on
%hold off
Location=cat(1,A,B);
