%demo3b testing graph ncut clustering gia d2b RGB image

close all;
clear;
clc

tic
rng(1)
load dip_hw_2.mat;
affine2a = Image2Graph(d2a);
affine2b = Image2Graph(d2b);
[M2A,N2A,nA] = size(d2a);
[M2B,N2B,nB] = size(d2b);

%% 1h seira peiramatwn ncut anadromiko gia d2b

T1 = 5;
T2 = 0.6; %wste na ginoun k = 2 clusters
k2clusteringB = ncutHelpDemo3b(affine2b, 1, T1, T2);
imgk2B = reshape(k2clusteringB,M2B,N2B);
k = max(k2clusteringB);
imgk2B = imgk2B./k;

f1 = figure('Name','Demo3b','NumberTitle','off');
f1.WindowState = 'maximized';
sgtitle('Graph Normalized-cuts Recursive Clustering for input d2b image')
subplot(1,3,1);
imshow(d2b);
title('d2b image');

subplot(1,3,2);
imshow(imgk2B);
title(sprintf('T1 = %d T2 = %1.1f k = %d',T1,T2,k));

%me peiramatismo katelhksa T2=0.7 wste k=3
T2 = 0.7;

k3clusteringB = ncutHelpDemo3b(affine2b, 1, T1, T2);
imgk3B = reshape(k3clusteringB,M2B,N2B);
k3 = max(k3clusteringB);
imgk3B = imgk3B./k3;

subplot(1,3,3);
imshow(imgk3B);
title(sprintf('T1 = %d T2 = %1.1f k = %d',T1,T2,k3));

%% 2h seira peiramatwn ncut mh anadromiko gia d2b

k = 2;
D = diag(sum(affine2b,2));
L = D - affine2b;
[U,~] = eigs(L,D,k,'smallestreal');
k2clusteringB = kmeans(U,k);
k2clusteringB = k2clusteringB./k;
imgk2B2 = reshape(k2clusteringB,M2B,N2B);


%%%%%%
k = 3;
D = diag(sum(affine2b,2));
L = D - affine2b;
[U,~] = eigs(L,D,k,'smallestreal');
k3clusteringB = kmeans(U,k);
k3clusteringB = k3clusteringB./k;
imgk3B2 = reshape(k3clusteringB,M2B,N2B);


f2 = figure('Name','Demo3b','NumberTitle','off');
f2.WindowState = 'maximized';
sgtitle('Graph Normalized-cuts Clustering for input d2b image')
subplot(1,3,1);
imshow(d2b);
title('d2b image');

subplot(1,3,2);
imshow(imgk2B2);
title('k = 2 clustering image');

subplot(1,3,3);
imshow(imgk3B2);
title('k = 3 clustering image');



%% 3h seira peiramatwn me spectral omadopoihsh

k = 2;
k2clusteringB3 = myGraphSpectralClustering(affine2b,k);
k2clusteringB3 = k2clusteringB3./k;
imgk2B3 = reshape(k2clusteringB3,M2B,N2B);

k = 3;
k3clusteringB = myGraphSpectralClustering(affine2b,k);
k3clusteringB = k3clusteringB./k;
imgk3B3 = reshape(k3clusteringB,M2B,N2B);


%%%%%%
f3 = figure('Name','Demo3b','NumberTitle','off');
f3.WindowState = 'maximized';
sgtitle('Graph Spectral Clustering for input d2b image')
subplot(1,3,1);
imshow(d2b);
title('d2b image');

subplot(1,3,2);
imshow(imgk2B3);
title('k = 2 clustering image');
subplot(1,3,3);
imshow(imgk3B3);
title('k = 3 clustering image');


toc