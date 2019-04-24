function A_new=shrinkcluster(A,C)
u=unique(C); %different clusters index
N=length(u); %clusters quantity
A_new=zeros(N);
for i=1:N
    for j=1:N
        a_i=find(C==u(i));
        a_j=find(C==u(j));
        for m=1:length(a_i);
            for n=1:length(a_j);
            A_new(i,j)=A_new(i,j)+A(a_i(m),a_j(n));
            end
        end
        A_new(j,i)=A_new(i,j);
    end
end
            
        