%demo2 testing graph spectral clustering gia d2a kai d2b RGB image
close all;
clear;
clc

tic
%lockarw random seed gia na ksekinaw me idio mean position gia ta kmeans  
rng(1); 
%fortwnw set eikonwn
load dip_hw_2.mat;

%2peiramata gia diaforetiko k clustering gia thn ka8e eikona d2a,d2b

affine2a = Image2Graph(d2a);
affine2b = Image2Graph(d2b);
[M2A,N2A,nA] = size(d2a);
[M2B,N2B,nB] = size(d2b);

%kanw thn eikona k clustering kai basei twn omadwn autwn thn ksanakanw
%reshape stis arxikes diastaseis ths me tis nees omadopoihmenes apoxrwseis

k = 3;
k3clusteringA = myGraphSpectralClustering(affine2a,k);
k3clusteringA = k3clusteringA./k;
imgk3A = reshape(k3clusteringA,M2A,N2A);

k3clusteringB = myGraphSpectralClustering(affine2b,k);
k3clusteringB = k3clusteringB./k;
imgk3B = reshape(k3clusteringB,M2B,N2B);

k = 4;
k4clusteringA = myGraphSpectralClustering(affine2a,k);
k4clusteringA = k4clusteringA./k;
imgk4A = reshape(k4clusteringA,M2A,N2A);

k4clusteringB = myGraphSpectralClustering(affine2b,k);
k4clusteringB = k4clusteringB./k;
imgk4B = reshape(k4clusteringB,M2B,N2B);

%probolh se figures
f1 = figure('Name','Demo2','NumberTitle','off');
f1.WindowState = 'maximized';
sgtitle('Graph Spectral Clustering for input d2a image')
subplot(1,3,1);
imshow(d2a);
title('d2a image');
imwrite(d2a,'d2aOG.jpg')

subplot(1,3,2);
imshow(imgk3A);
title('k = 3 clustering image');
imwrite(imgk3A,'d2aK3.jpg')
subplot(1,3,3);
imshow(imgk4A);
title('k = 4 clustering image');
imwrite(imgk4A,'d2aK4.jpg')

f2 = figure('Name','Demo2','NumberTitle','off');
f2.WindowState = 'maximized';
sgtitle('Graph Spectral Clustering for input d2b image')
subplot(1,3,1);
imshow(d2b);
title('d2b image');
imwrite(d2b,'d2bOG.jpg')

subplot(1,3,2);
imshow(imgk3B);
title('k = 3 clustering image');
imwrite(imgk3B,'d2bK3.jpg')
subplot(1,3,3);
imshow(imgk4B);
title('k = 4 clustering image');
imwrite(imgk4B,'d2bK4.jpg')
toc