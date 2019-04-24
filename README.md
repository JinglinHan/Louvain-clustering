# Louvain-clustering
MATLAB simulation of clustering using Louvain algorithm, and comparing its performance with K-means.


Here is two sets of code.

In the folder "clustering", the code set groups the nodes using Louvain (coded by us), 
Louvain (code you recommend on Github) and K-means (from MATLAB, and it's Kmeans++, to be exact).
And the result of clustering is showed in figure 2, 3 and 4, respectively.
Figure 1 shows the initial postion of all nodes.

——>The main entrence of this code set is "clustering.m".  <——

The function of the rest m files is listed as follows.
"cluster_jl.m" is the Louvain code from Github;
"dq.m" calculates the differences of Modularity Q after each iteration, using the term given in your paper;
"Louvain.m" is the main function of Louvain coded by us;
"modularity.m" calculates modularity Q;
"PPP.m" generates inital position of nodes following poisson distribution at the beginning of the programm;
"shrinkcluster.m" shrinks multiple nodes into a new one when it's need in the Louvain algorithm.

Parameters like numbers of cluster, average number of nodes, etc, can be modified in clustering.m.



----------------------------------------------------------------------------------------------------------------------------------


In the folder "compare", the code set compares the performances of Louvain algorithm with Kmeans.
There is only minor difference between the m files here and those in the clustering folder, that is all the functions
of plotting figure are commented because we don't need them here.

"CalcutaleP.m" calcutates the total and average transmit power using the result of clustering.

——>The main entrence of this code set is "compare.m".<——


The result is presented in the form of line chart and a sample chart is showed in
"sample.png" along with the code.
