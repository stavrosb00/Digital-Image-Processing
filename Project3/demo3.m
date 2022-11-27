%demo3 gia CRF ektimhsh kai efarmogh ths
clear;
clc
close all;

%tic

%% eikona 1h diadromos+dwmatio
%xronoi ek8eshs
tk = [1/2500, 1/1000, 1/500, 1/250, 1/125, 1/60, 1/30, 1/15, 1/8, 1/4, 1/2, 1, 2, 4, 8, 15];
Nt = length(tk);
%8elw na fortwsw eikones gia na tis stibaksw sthn lista pou tha dwsw
for k = 1:Nt
  jpgFilename = sprintf('exposure%d.jpg', k);
  fullFileName = fullfile('Image1/', jpgFilename);
  if exist(fullFileName, 'file')
    imgs{k} = imread(fullFileName );
  else
    warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
    uiwait(warndlg(warningMessage));
  end
  %imshow(imgs{k});
end

exp1 = imgs{1};
[M,N,n] = size(exp1);
Istack = uint8(zeros(M,N,n,Nt));
whos Istack
for i = 1:Nt
    Istack(:,:,:,i) = imgs{i};
end


IvR = uint8(zeros(M,N,Nt));
IvR(:,:,:) = Istack(:,:,1,:);
whos IvR
IvG = uint8(zeros(M,N,Nt));
IvG(:,:,:) = Istack(:,:,2,:);
whos IvG
IvB = uint8(zeros(M,N,Nt));
IvB(:,:,:) = Istack(:,:,3,:);
whos IvB
wf = ["Uniform" "Tent" "Gaussian" "Photon"];
%% peiramata gia CRF
numberOfPhotons = 0:255;
weightingFcn = 3;
lamda = [650 180 365];

tic
responseCurveR = estimateResponseCurve(IvR, tk, lamda(1), weightingFcn);
toc

tic
responseCurveG = estimateResponseCurve(IvG, tk, lamda(2), weightingFcn);
toc

tic
responseCurveB = estimateResponseCurve(IvB, tk, lamda(3), weightingFcn);
toc


figure('Name','Demo3','NumberTitle','off');
plot(responseCurveR, numberOfPhotons)
hold on
xlabel('Number of photons tk*E')
ylabel('Pixel value f(tk*E)')
title(sprintf('Camera response function for Red channel using %s as weight function',wf(weightingFcn)))
hold off

figure('Name','Demo3','NumberTitle','off');
plot(responseCurveG, numberOfPhotons)
hold on
xlabel('Number of photons tk*E')
ylabel('Pixel value f(tk*E)')
title(sprintf('Camera response function for Green channel using %s as weight function',wf(weightingFcn)))
hold off

figure('Name','Demo3','NumberTitle','off');
plot(responseCurveB, numberOfPhotons)
hold on
xlabel('Number of photons tk*E')
ylabel('Pixel value f(tk*E)')
title(sprintf('Camera response function for Blue channel using %s as weight function',wf(weightingFcn)))
hold off   

%% peiramata LDR se HDR basei twn CRF
radianceMapR = mergeLDRStackV2(IvR , tk , weightingFcn, responseCurveR);
radianceMapG = mergeLDRStackV2(IvG , tk , weightingFcn, responseCurveG);
radianceMapB = mergeLDRStackV2(IvB , tk , weightingFcn, responseCurveB);

radianceMap = zeros(M,N,3);
radianceMap(:,:,1) = radianceMapR;
radianceMap(:,:,2) = radianceMapG;
radianceMap(:,:,3) = radianceMapB;

debugR(radianceMap);
radianceMap = rescale(radianceMap,0,255);
radM = uint8(radianceMap);

ct = 41;
gamma = 1.4;
if gamma ~= 1
    radM = toneMapping(radM , gamma);
end
%debugR(radM);
ct = printerRadM(radM, ct, wf(weightingFcn),gamma);


%% eikona 2h balkoni

tk2 = [1/400, 1/250, 1/100, 1/40, 1/25, 1/8, 1/3];
Nt = length(tk2);
%8elw na fortwsw eikones gia na tis stibaksw sthn lista pou tha dwsw
imgs = {};
for k = 1:Nt
  %sample2-05_rotated ->allaksa apla to onoma ths eikonas ston fakelo mou
  jpgFilename = sprintf('sample2-0%d.jpg', k-1);
  fullFileName = fullfile('Image2/', jpgFilename);
  if exist(fullFileName, 'file')
    imgs{k} = imread(fullFileName);
  else
    warningMessage = sprintf('Warning: image file does not exist:\n%s', fullFileName);
    uiwait(warndlg(warningMessage));
  end
  %imshow(imgs{k});
end

exp1 = imgs{1};
[M,N,n] = size(exp1);
Istack = uint8(zeros(M,N,n,Nt));
whos Istack
for i = 1:Nt
    Istack(:,:,:,i) = imgs{i};
end

IvR = uint8(zeros(M,N,Nt));
IvR(:,:,:) = Istack(:,:,1,:);
whos IvR
IvG = uint8(zeros(M,N,Nt));
IvG(:,:,:) = Istack(:,:,2,:);
whos IvG
IvB = uint8(zeros(M,N,Nt));
IvB(:,:,:) = Istack(:,:,3,:);
whos IvB
wf = ["Uniform" "Tent" "Gaussian" "Photon"];
%% peiramata gia CRF
numberOfPhotons = 0:255;
weightingFcn = 3;
%lamda = [220 220 220];
lamda(:) = 10^6;
%650 180 365
tic
responseCurveR = estimateResponseCurve(IvR, tk, lamda(1), weightingFcn);
toc

tic
responseCurveG = estimateResponseCurve(IvG, tk, lamda(2), weightingFcn);
toc

tic
responseCurveB = estimateResponseCurve(IvB, tk, lamda(3), weightingFcn);
toc


figure('Name','Demo3','NumberTitle','off');
plot(responseCurveR, numberOfPhotons)
hold on
xlabel('Number of photons tk*E')
ylabel('Pixel value f(tk*E)')
title(sprintf('Camera response function for Red channel using %s as weight function',wf(weightingFcn)))
hold off

figure('Name','Demo3','NumberTitle','off');
plot(responseCurveG, numberOfPhotons)
hold on
xlabel('Number of photons tk*E')
ylabel('Pixel value f(tk*E)')
title(sprintf('Camera response function for Green channel using %s as weight function',wf(weightingFcn)))
hold off

figure('Name','Demo3','NumberTitle','off');
plot(responseCurveB, numberOfPhotons)
hold on
xlabel('Number of photons tk*E')
ylabel('Pixel value f(tk*E)')
title(sprintf('Camera response function for Blue channel using %s as weight function',wf(weightingFcn)))
hold off   

%% peiramata LDR se HDR basei twn CRF
radianceMapR = mergeLDRStackV2(IvR , tk , weightingFcn, responseCurveR);
radianceMapG = mergeLDRStackV2(IvG , tk , weightingFcn, responseCurveG);
radianceMapB = mergeLDRStackV2(IvB , tk , weightingFcn, responseCurveB);

radianceMap = zeros(M,N,3);
radianceMap(:,:,1) = radianceMapR;
radianceMap(:,:,2) = radianceMapG;
radianceMap(:,:,3) = radianceMapB;

debugR(radianceMap);
radianceMap = rescale(radianceMap,0,255);
radM = uint8(radianceMap);

ct = 45;
gamma = 1.3;
if gamma ~= 1
    radM = toneMapping(radM , gamma);
end
%debugR(radM);
ct = printerRadM(radM, ct, wf(weightingFcn),gamma);

%% peiramata LDR se HDR me grammikh CRF
radianceMapR = mergeLDRStack(IvR , tk , weightingFcn);
radianceMapG = mergeLDRStack(IvG , tk , weightingFcn);
radianceMapB = mergeLDRStack(IvB , tk , weightingFcn);

radianceMap = zeros(M,N,3);
radianceMap(:,:,1) = radianceMapR;
radianceMap(:,:,2) = radianceMapG;
radianceMap(:,:,3) = radianceMapB;

debugR(radianceMap);
radianceMap = rescale(radianceMap,0,255);
radM = uint8(radianceMap);

ct = 49;
gamma = 1.3;
if gamma ~= 1
    radM = toneMapping(radM , gamma);
end
%debugR(radM);
ct = printerRadM(radM, ct, wf(weightingFcn),gamma);


