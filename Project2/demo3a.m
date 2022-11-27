%demo3a testing graph ncut clustering gia d2a kai d2b RGB image

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

k = 2;
%% d2a eikona

%kanw thn eikona k clustering
%bhma 1 o anAffinityMat einai o W mou
%bhma 2 na brw ton diagwnio D pou einai a8roisma tou W kata j(2h
%diastash) wste na brw ton L = D-W
D = diag(sum(affine2a,2));
L = D - affine2a;
%bhma 3 kai 4 na brw genikeumena idiodianysmata/idiotimes tou L kai na 
%krathsw ta k mikrotera idiodianysmata me thn eigs() ston U
[U,~] = eigs(L,D,k,'smallestreal');
%bhma 5 na kanw clustering me k-means
k2clusteringA = kmeans(U,k);

%ypologizw to ncut gia thn prwth diaxwrish mou
ncutA = calculateNcut(affine2a , k2clusteringA);
disp(ncutA);

%basei tou clusterIdx ksanakanw reshape eikona stis arxikes diastaseis ths 
%me tis nees omadopoihmenes apoxrwseis


k2clusteringA = k2clusteringA./k;
imgk2A = reshape(k2clusteringA,M2A,N2A);

%% d2b eikona

%kanw thn eikona k clustering
%bhma 1 o anAffinityMat einai o W mou
%bhma 2 na brw ton diagwnio D pou einai a8roisma tou W kata j(2h
%diastash) wste na brw ton L = D-W
D = diag(sum(affine2b,2));
L = D - affine2b;
%bhma 3 kai 4 na brw genikeumena idiodianysmata/idiotimes tou L kai na 
%krathsw ta k mikrotera idiodianysmata me thn eigs() ston U
[U,~] = eigs(L,D,k,'smallestreal');
%bhma 5 na kanw clustering me k-means
k2clusteringB = kmeans(U,k);

%ypologizw to ncut gia thn prwth diaxwrish mou
ncutB = calculateNcut(affine2b , k2clusteringB);
disp(ncutB);

%basei tou clusterIdx ksanakanw reshape eikona stis arxikes diastaseis ths 
%me tis nees omadopoihmenes apoxrwseis


k2clusteringB = k2clusteringB./k;
imgk2B = reshape(k2clusteringB,M2B,N2B);


%% probolh se figures
f1 = figure('Name','Demo3a','NumberTitle','off');
f1.WindowState = 'maximized';
sgtitle('Graph Normalized-cuts Clustering for input d2a image')
subplot(1,2,1);
imshow(d2a);
title('d2a image');

subplot(1,2,2);
imshow(imgk2A);
title('k = 2  clustering image');


f2 = figure('Name','Demo3a','NumberTitle','off');
f2.WindowState = 'maximized';
sgtitle('Graph Normalized-cuts Clustering for input d2b image')
subplot(1,2,1);
imshow(d2b);
title('d2b image');

subplot(1,2,2);
imshow(imgk2B);
title('k = 2 clustering image');

toc