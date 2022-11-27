%demo2 gia tonedImage = toneMapping(radianceMap , gamma)
clear;
%clc
close all;



tic
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
%%%%%synarthsh%%%%%%%
ct = 21;

%weightingFcn = i;
%weightingFcn = 2;
weightingFcn = 3;
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
%radM = (radianceMap);


gamma = [0.8 1.2 1.4];
for i = 1:length(gamma)
    radM = toneMapping(radM , gamma(i));
    %debugR(radM);
    ct = printerRadM(radM, ct, wf(weightingFcn),gamma(i));
end

radMgray = rgb2gray(radM);
%exw 6pixels me antanaklash x2 ana epomeno 
%apo to aspro katw mexri to mauro panw
pixels2Dcoords = [250 1350
300 1350
350 1350
400 1350
450 1350
500 1350];

%sthn prwth sthlh to index m sthn deuterh sthlh h fwteinothta
pixelsIntesity = zeros(6,2);

for i = 1:6
    pixelsIntesity(i,1) = i;
    pixelsIntesity(i,2) = radMgray(pixels2Dcoords(i,1), pixels2Dcoords(i,2));
end

f = figure('Name','Demo2','NumberTitle','off');
f.WindowState = 'maximized'; 
hold on
plot(pixelsIntesity(:,1), pixelsIntesity(:,2), 'r')
plot([pixelsIntesity(1,1), pixelsIntesity(6,1)], [pixelsIntesity(1,2), pixelsIntesity(6,2)], 'b')
legend('Computed linearity', 'Theoritic linearity')
xlabel('Pixels')
ylabel('Intensity')
title('Pixels linearity of gray scale intensity')
grid on
toc

