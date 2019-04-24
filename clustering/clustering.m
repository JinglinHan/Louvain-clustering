clc
clear


V=50;  %Average Mobile devices number
N=6;    %Number of Cluster 
L=1000; %Length of area
d=300;  %proximity threshhold




    
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

%using LV code on Github
COMTY = cluster_jl(A_t,N);
ConNum=length(COMTY.Niter);



%%%%%%%%%%%%%%%%%%%%%             Graph        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
title('My own')
color(1,:)=[0 0 0];color(2,:)=[1 0 0];color(3,:)=[0 1 0];color(4,:)=[0 0 1];color(5,:)=[0 1 1];color(6,:)=[1 0 1];color(7,:)=[1 1 0];

for i=1:N_t;
    scatter(Location(1,find(C==Cluster(i))),Location(2,find(C==Cluster(i))),10,color(i,:),'filled');
    %scatter(Location(1,find(C==Cluster(i))),Location(2,find(C==Cluster(i))),10,color(i,:),'filled');
    hold on
end
hold off
figure;
for i=1:N;
    %scatter(Location(1,find(C==Cluster(i))),Location(2,find(C==Cluster(i))),10,color(i,:),'filled');
    scatter(Location(1,find(COMTY.COM{ConNum}==i)),Location(2,find(COMTY.COM{ConNum}==i)),10,color(i,:),'filled');
    hold on
end


%%%%%%%%%%%%%%%%%%%%%%           K-means         %%%%%%%%%%%%%%%%%%%%%%%%%%
opts = statset('Display','final');
[idx,Cluster_k] = kmeans(Location',N,'Distance','sqeuclidean',...
    'Replicates',5,'Options',opts);
figure;
for i=1:N
    scatter(Location(1,idx==i),Location(2,idx==i),10,color(i,:),'filled');
    hold on
end
plot(Cluster_k(:,1),Cluster_k(:,2),'ko',...
    'MarkerSize',5,'LineWidth',3) 
hold off


