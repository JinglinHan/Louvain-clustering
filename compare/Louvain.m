function C=Louvain(A,N,C)
%delta=0.0001;
%gq_max=25;
%V_t=size(A);


m=sum(sum(A))/2;       %total weight of edges in graph  
N_t=length(unique(C)); %contemporary cluster number
Q=modularity(A,C);     % initial value of Q(modularity)
C_s=C;                 %comtemporary nodes






%%%%%%%%%%%%%%%%%%%%%%%%%%       Louvain  Alogorithm     %%%%%%%%%%%%%%%%%%

while N_t>N
C_t=C_s;
label=0;
while 1
    Q=modularity(A,C_t);   %comtemporary modularity value Q
    label=0;
for i=1:length(A)
    Dq=0;                  %modularity change value
    label=0;
    for j=1:length(A)
        %{
        if A(i,j)~=0       %search the neighbour nodes  
            
            index=find(C_t==C_t(j));
            n=0;
            for m=1:length(index)
               n=n+length(find(C==C_s(index(m))));
            end            
            if n<=gq_max
            %}
                %if dq(i,j,C_t,A)>Dq & dq(i,j,C_t,A)>delta;% select maximum value of DeltaQ>0
                
                if dq(i,j,C_t,A)>Dq
                    Dq=dq(i,j,C_t,A);                   
                    C_t(i)=C_t(j);
                    N_t=length(unique(C_t));   
                    if N_t<=N                         
                    label=1;
                    break;
                    end              
                end
                %{
            else
                continue
            end
                
        else
            continue
        end
                %}
    end
    if label==1
        break;
    end
end


%N_t=length(unique(C_t));

if modularity(A,C_t)<=Q %repeat the merge process until the modularity value do not incerese again
    Q=modularity(A,C_t);
    break;
else
    Q=modularity(A,C_t);
end

if label==1
    break
end

end

for i=1:length(C)
    C(i)=C_t(find(C_s==C(i)));
end

N_t=length(unique(C));% comtemporary clusters quantity


if label==1
    break
end

C_s=C_t;
if N_t>N & N_t<size(A)        %shrink cluster to nodes and prepare for next iteration
    A=shrinkcluster(A,C_s);    %update the adjacency matrix 
    C_s=unique(C_s);           %updata the cluster vector    
else
    break
end

end
