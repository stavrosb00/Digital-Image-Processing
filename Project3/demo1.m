%demo1 gia radianceMap = mergeLDRStack(imgStack , exposureTimes , weightingFcn)
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

% disp(['Range of RGB image is [',num2str(min(Istack(:))),', ',num2str(max(Istack(:))),'].']);
% Istack(1:40,1:40,2,5) = 
% Istack = double(Istack);
% disp(['Range of RGB image is [',num2str(min(Istack(:))),', ',num2str(max(Istack(:))),'].']);

%eixame pei an theloume rgb2gray alliws ena ena ka8e xrwma 
%den ksexnw na tis kanonikopoihsw wste fwteinothta z=[0,1]
%h im2double kanonikopoiei se double 0-1

% Istack = im2double(Istack);
% whos Istack

%p.x. kokkino
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
%%%%%kalesma synarthshs%%%%%%%
ct = 1;
for i = 1:4
    weightingFcn = i;
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
    %radianceMap = rescale(radianceMap,0,255);
    %radM = uint8(radianceMap);
    %radM = radianceMap;
    
    %debugR(radM);
    %radianceMap = rescale(radianceMap,0,1);
    %radM = radianceMap;
    
    %RGB oloklhrh
    f = figure('Name','Demo1','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for RGB channels using %s as weight function',wf(i)))
    subplot(1,2,1)
    imagesc(radM(:,:,:))
    subplot(1,2,2)
    imhist(radM(:,:,:));
    
    name = sprintf('test_%d.png',ct);
    ct = ct + 1;
    imwrite(radM, name); %,c,

    %kokkino
    f = figure('Name','Demo1','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for Red channel using %s as weight function',wf(i)))
    subplot(1,2,1)
    imagesc(radM(:,:,1))
    c = colormap(autumn);
    axis off
    colorbar
    subplot(1,2,2)
    imhist(radM(:,:,1));
    
    name = sprintf('test_%d.jpg',ct);
    ct = ct + 1;
    imwrite(radM(:,:,1),c, name,'Quality',100);

    %prasino
    f = figure('Name','Demo1','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for Green channel using %s as weight function',wf(i)))
    subplot(1,2,1)
    imagesc(radM(:,:,2))
    c = colormap(summer);
    axis off
    colorbar
    subplot(1,2,2)
    imhist(radM(:,:,2));
    
    name = sprintf('test_%d.jpg',ct);
    ct = ct + 1;
    imwrite(radM(:,:,2),c, name,'Quality',100);
    %mple
    f = figure('Name','Demo1','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for Blue channel using %s as weight function',wf(i)))
    subplot(1,2,1)
    imagesc(radM(:,:,3))
    c = colormap(winter);
    axis off
    colorbar
    subplot(1,2,2)
    imhist(radM(:,:,3));
    
    name = sprintf('test_%d.jpg',ct);
    ct = ct + 1;
    imwrite(radM(:,:,3),c, name, 'Quality',100);
end

toc

