function dq=dq(i,j,C,A)
m=sum(sum(A))/2;   %total weight of the edges in graph
line=find(C==C(j)); % nodes in community j
k=0;   %k_i_in  total weight of the edges from mobile device i to all mobile devices in cluster j
for n=1:length(line)
    k=k+A(i,line(n));
end
k_i=sum(A(:,i)); %total weight of the edges attached to the ith mobile device
tot=0; %total weight of the edges attached to the cluster j
for n=1:length(line)
    tot=tot+sum(A(:,line(n)));
end
dq=k/m-(tot*k_i)/(2*m^2);

