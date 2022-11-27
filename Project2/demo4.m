%demo4
%https://www.mathworks.com/help/matlab/matlab_external/build-an-executable-mex-file.html
close all;
clear;
clc
%mex -setup 
%mex slicmex.c
tic
rng(1)
img = imread('bee.jpg');
whos img
f3 = figure('Name','Demo4','NumberTitle','off');
f3.WindowState = 'maximized';
sgtitle('Superpixel transformation')
subplot(1,2,1)
imshow(img)
title('Bee image')
%% tropopoihsh se SLIC superpixels

rNL = 400;
cF = 20;
[labels , ~] = slicmex(img , rNL , cF);
[M,N,n] = size(img);
outputImage = zeros(size(img));

%gia ka8e kanali ths eikonas pairnw ton meso oro tou ka8e SPixel
for i = 1:n
    outputImage(:,:,i) = superpixelDescriptor(img(:,:,i),labels);
end
outputImage = uint8(outputImage);
subplot(1,2,2)
imshow(outputImage)
title('SLIC Superpixeled Bee image')
imwrite(outputImage,'beeSLIC.jpg');
%% clustering
%prepei na krathsw se lista tis monoshmantes times pou pairnoun ola ta
%superpixels kai se poia 8esh prwto emfanisthke auth h timh wste na dwsw
%san eikona mia lista superpixels anti gia thn 2D eikona gia thn antlhsh
%tou pinaka sysxetishs metaksy twn superpixels. sth synexeia kanw
%clustering basei tou pinaka autou kai antistrofa ksanagyrnaw stis
%idiothtes ths kanonikhs eikonas basei twn clusters kai twn dedomenwn twn
%superpixels pou krathsa sthn arxh
[uniqueVals, firstObserves, ~] = unique(labels);
firstObserves = uint32(firstObserves);
imInList = reshape(im2double(outputImage), [M*N, n]);
spIm = imInList(firstObserves, :);
affSP = SPImage2Graph(spIm);



% ncut mh anadromiko clustering
%k=6
D = diag(sum(affSP,2));
L = D - affSP;
[U,~] = eigs(L,D,6,'smallestreal');
k6SPclustering = kmeans(U,6);
k6clusters = zeros(M*N,1);
for i = 1:size(uniqueVals, 1)        
    idxs = find(labels == uniqueVals(i));
    clusterIdx = k6SPclustering(i).*ones(length(idxs),1);
    k6clusters(idxs,:) = clusterIdx; 
end

clusterImage = label2rgb(reshape(k6clusters, [M, N]));
f1 = figure('Name','Demo4','NumberTitle','off');
f1.WindowState = 'maximized';
sgtitle('Superpixel Graph N-cut Non-recursive Clustering for input bee image')
subplot(1,2,1)
imshow(uint8(clusterImage))
title('k = 6 clustering')

%k=10
D = diag(sum(affSP,2));
L = D - affSP;
[U,~] = eigs(L,D,10,'smallestreal');
k10SPclustering = kmeans(U,10);
k10clusters = zeros(M*N,1);
for i = 1:size(uniqueVals, 1)        
    idxs = find(labels == uniqueVals(i));
    clusterIdx = k10SPclustering(i).*ones(length(idxs),1);
    k10clusters(idxs,:) = clusterIdx; 
end

clusterImage = label2rgb(reshape(k10clusters, [M, N]));
subplot(1,2,2)
imshow(uint8(clusterImage))
title('k = 10 clustering')

% ncut anadromiko clustering 
%me trial&error : k = max(kSPclustering) katalhgw sta parakatw T1,T2
%k=6 
T1 = 20;
T2 = 0.97;
k6SPclustering = ncutHelpDemo3b(affSP, 1, T1, T2);
k6clusters = zeros(M*N,1);
for i = 1:size(uniqueVals, 1)        
    idxs = find(labels == uniqueVals(i));
    clusterIdx = k6SPclustering(i).*ones(length(idxs),1);
    k6clusters(idxs,:) = clusterIdx; 
end

clusterImage = label2rgb(reshape(k6clusters, [M, N]));
f2 = figure('Name','Demo4','NumberTitle','off');
f2.WindowState = 'maximized';
sgtitle('Superpixel Graph N-cut Recursive Clustering for input bee image')
subplot(1,2,1)
imshow(uint8(clusterImage))
title('k = 6 clustering')

%k=10
T1 = 10;
T2 = 0.97;
k10SPclustering = ncutHelpDemo3b(affSP, 1, T1, T2);
k10clusters = zeros(M*N,1);
for i = 1:size(uniqueVals, 1)        
    idxs = find(labels == uniqueVals(i));
    clusterIdx = k10SPclustering(i).*ones(length(idxs),1);
    k10clusters(idxs,:) = clusterIdx; 
end

clusterImage = label2rgb(reshape(k10clusters, [M, N]));
subplot(1,2,2)
imshow(uint8(clusterImage))
title('k = 10 clustering')
toc