function Q=modularity(A,C)
u=unique(C); %different cluster index
N=length(u); %cluster quantity
Q=0;
for l=1:N
    line=find(C==u(l)); % nodes of cluster l
    m=length(line); % nodes quantity of cluster l
    in=0; %  total weight of edge between nodes in cluster l
    for i=1:m
        for j=1:m
        in=in+A(line(i),line(j));
        end
    end
    tot=0; %total weight of the edges attached to nodes in the cluster l
    for n=1:m
    tot=tot+sum(A(:,line(n)));
    end
    Q=Q+(in/(2*m)-(tot/(2*m))^2);
end
