function [P,Pmeans]=calculateP(Location,C)
Location=Location';C=C';
delta=10^(-8);N_0=10^(-20);R_b=200000;eta=sqrt(10);f_c=2*10^9;z=500;%参数赋值
n=length(Location);%设备数量
Cluster=unique(C);%index of cluster vector
N_t=length(Cluster);%cluster quantity
%计算中心
central=zeros(N_t,2);
for i=1:N_t
    central(i,:)=mean(Location(find(C==Cluster(i)),:),1);
end

%计算平均功率
P_vn=zeros(n,1);
d_vn=zeros(n,1);
P=0;
for i=1:n
    j=find(Cluster==C(i));
    k=Location(i,:)-central(j,:);
    k(3)=500;
    d_vn(i)=norm(k);
    P_vn(i)=qfuncinv(delta)^2*(R_b*N_0/2)*eta*(4*pi*f_c*d_vn(i)/(3*10^8))^2;
    P=P+P_vn(i);
end
Pmeans=P/n;