%demo1 testing graph spectral clustering gia d1a image
close all;
clear;
clc

tic
%lockarw random seed gia na ksekinaw me idio mean position gia ta kmeans  
rng(1); 
%fortwnw set eikonwn
load dip_hw_2.mat;

%3peiramata gia diaforetiko k clustering
k = 2;
k2clustering = myGraphSpectralClustering(d1a,k);
k = 3;
k3clustering = myGraphSpectralClustering(d1a,k);
k = 4;
k4clustering = myGraphSpectralClustering(d1a,k);

%probolh se figures
f1 = figure('Name','Demo1','NumberTitle','off');
f1.WindowState = 'maximized';
sgtitle('Graph Spectral Clustering for input d1a image')

fprintf('k = 2\n');
subplot(2,2,1)
imshow(d1a)
title('d1a affinity matrix')
subplot(2,2,2)
histogram(k2clustering,'BinWidth',0.1);
xlabel('Clusters');
ylabel('Nodes in each cluster');
title('k = 2 clustering');
disp(k2clustering);

fprintf('k = 3\n');
subplot(2,2,3)
histogram(k3clustering,'BinWidth',0.1);
xlabel('Clusters');
ylabel('Nodes in each cluster');
title('k = 3 clustering');
disp(k3clustering);

fprintf('k = 4\n');
subplot(2,2,4)
histogram(k4clustering,'BinWidth',0.1);
xlabel('Clusters');
ylabel('Nodes in each cluster');
title('k = 4 clustering');
disp(k4clustering);
toc
