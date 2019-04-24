clc
clear
N=4;
total=zeros(1,5);
PLVmeans100=zeros(1,5);
PKmeans100=zeros(1,5);
while(N<=8)


Tmax=100;
T=1;
P1=zeros(1,Tmax); %Total Power of LV
P2=zeros(1,Tmax);%Total P of Kmeans
P3=zeros(1,Tmax);%average P of LV
P4=zeros(1,Tmax);%average P of Kmeans
Compare=zeros(1,Tmax);%compare the two average P

V=50;  %Average Mobile devices number
%N=6;    %UAV number
L=1000; %Length of area
d=300;  %proximity threshhold



while(T<=Tmax)
clearvars -EXCEPT Tmax T P1 P2 P3 P4 Compare V N L d total PLVmeans100 PKmeans100
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Initiation      %%%%%%%%%%%%%%%%%%%%%%%%%%
Location=PPP(V,L);     %2D random points in Possion distribution
V_t=size(Location,2);  %real quantity of mobile devices

A=zeros(V_t);          %adjacency matrix initiation
for i=1:V_t-1
    for j=i+1:V_t
        if norm(Location(:,i)-Location(:,j))<=d %definition of neighborhood
            %A(i,j)=exp(-1*norm(Location(:,i)-Location(:,j))/d);
            %A(j,i)=exp(-1*norm(Location(:,i)-Location(:,j))/d);
            %A(i,j)=d^-1*norm(Location(:,i)-Location(:,j))+1;
            %A(j,i)=d^-1*norm(Location(:,i)-Location(:,j))+1;
            A(i,j)=1;
            A(j,i)=1;
        end
    end
end

%cluster vector initiation
for i=1:V_t
    C(i)=i;
end



%%%%%%%%%%%%%%%%%%%%       cluster generation      %%%%%%%%%%%%%%%%%%%%%%%%
Q=modularity(A,C);
A_t=A;
C=Louvain(A_t,N,C);%Cluster vector produced by Louvain Algorithm provided in GitHub
Cluster=unique(C);%index of cluster vector
N_t=length(Cluster);%cluster quantity
Q1=modularity(A,C);

%New one
% COMTY = cluster_jl(A_t,N);
% ConNum=length(COMTY.Niter);


%when compareing the two algorithm, the plot moduel is not needed.
%%%%%%%%%%%%%%%%%%%%%             Graph        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% title('My own')
% color(1,:)=[0 0 0];color(2,:)=[1 0 0];color(3,:)=[0 1 0];color(4,:)=[0 0 1];color(5,:)=[0 1 1];color(6,:)=[1 0 1];color(7,:)=[1 1 0];
% 
% for i=1:N_t;
%     scatter(Location(1,find(C==Cluster(i))),Location(2,find(C==Cluster(i))),10,color(i,:),'filled');
%     %scatter(Location(1,find(C==Cluster(i))),Location(2,find(C==Cluster(i))),10,color(i,:),'filled');
%     hold on
% end
% hold off
% figure;
% for i=1:N;
%     %scatter(Location(1,find(C==Cluster(i))),Location(2,find(C==Cluster(i))),10,color(i,:),'filled');
%     scatter(Location(1,find(COMTY.COM{ConNum}==i)),Location(2,find(COMTY.COM{ConNum}==i)),10,color(i,:),'filled');
%     hold on
% end


%%%%%%%%%%%%%%%%%%%%%%           K-means         %%%%%%%%%%%%%%%%%%%%%%%%%%
opts = statset('Display','final');
[idx,Cluster_k] = kmeans(Location',N,'Distance','sqeuclidean',...
    'Replicates',5,'Options',opts);
%figure;
% for i=1:N
%     scatter(Location(1,idx==i),Location(2,idx==i),10,color(i,:),'filled');
%     hold on
% end
%plot(Cluster_k(:,1),Cluster_k(:,2),'ko',...
%     'MarkerSize',5,'LineWidth',3) 
%hold off


[P1(T),P3(T)]=calculateP(Location,C);
[P2(T),P4(T)]=calculateP(Location,idx);

if (P1(T)<=P2(T))
    Compare(T)=1;
else
    Compare(T)=0;
end

T=T+1;
end

total(N-3)=sum(Compare(:));
PLVmeans100(N-3)=sum(P1(:))/Tmax;
PKmeans100(N-3)=sum(P2(:))/Tmax;

N=N+1;
end

x1=4:1:8;
subplot(2,1,1);
plot(x1,1000*PLVmeans100,'-*b',x1,1000*PKmeans100,'-or');
set(gca,'XTick',[3:1:9]) %x range 1-6£¬with interval of 1
legend('LV','Kmeans');
xlabel('Number of Cluster')
ylabel('Average Power in 100 Times of Simulations/mW')
text(x1,1000*PLVmeans100,num2str([1000*PLVmeans100].','%.2f'))
text(x1,1000*PKmeans100,num2str([1000*PKmeans100].','%.2f'))
grid on;

subplot(2,1,2);
x2=4:1:8;
plot(x2,total,'-or');
set(gca,'XTick',[3:1:9]) 
xlabel('Number of Cluster')
ylabel('Times that LV is better than Kmeans in 100 simulations')
text(x2,total,num2str([total].','%.2f'))
grid on;
