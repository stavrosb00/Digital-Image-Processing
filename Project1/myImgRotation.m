%synarthsh tou rotation kefalaiou 1.1
function rotImg = myImgRotation(img, angle)

anglerad = pi*angle/180;
A = [cos(anglerad), sin(anglerad),0;-sin(anglerad),cos(anglerad),0;0,0,1];
a1=0;

%analoga an einai RGB h gray scale
b = size(img);
if size(b,2)==3
a1 = 1;
end

%metatroph eikonas se double gia apofygh
img= double(img);                       

%% metasxhmatismos

%fernw thn arxh sto kentro tou pinaka
trans = [1,0,-b(2)/2;0,1,-b(1)/2;0,0,1];

%prakseis metasxhmatismou

outx = zeros(b(1),b(2));
outy = zeros(b(1),b(2));

for i = 1:b(1)
    for j = 1:b(2)
        new  = A*trans*[j;i;1];
        outx(i,j) = round(new(1)/new(3));
        outy(i,j) = round(new(2)/new(3));
    end
end
%% kataskeuh eikonas
minoutx = min(outx,[],'all');
minouty = min(outy,[],'all');

maxoutx = max(outx,[],'all');
maxouty = max(outy,[],'all');

rotImg = zeros(maxouty+abs(minouty)+1,maxoutx+abs(minoutx)+1);

for i = 1:b(1)
    for j = 1:b(2)
        rotImg(outy(i,j)+abs(minouty)+1,outx(i,j)+abs(minoutx)+1,1) = img(i,j,1);
        if a1 == 1
            rotImg(outy(i,j)+abs(minouty)+1,outx(i,j)+abs(minoutx)+1,2) = img(i,j,2);
            rotImg(outy(i,j)+abs(minouty)+1,outx(i,j)+abs(minoutx)+1,3) = img(i,j,3);
        end
        
    end
end

%% gemizw ta kena me thn logikh tou mesou barous
b1 = size(rotImg);
for i = 2:b1(1)-2
    for j = 2:b1(2)-2
       if rotImg(i,j)==0
       rotImg(i,j) = median([rotImg(i-1,j-1),rotImg(i-1,j),rotImg(i-1,j+1),rotImg(i,j-1),rotImg(i,j),rotImg(i,j+1),rotImg(i+1,j-1),rotImg(i+1,j),rotImg(i+1,j+1)]);
       if a1 == 1
       rotImg(i,j,2) = median([rotImg(i-1,j-1,2),rotImg(i-1,j,2),rotImg(i-1,j+1,2),rotImg(i,j-1,2),rotImg(i,j,2),rotImg(i,j+1,2),rotImg(i+1,j-1,2),rotImg(i+1,j,2),rotImg(i+1,j+1,2)]);
       rotImg(i,j,3) = median([rotImg(i-1,j-1,3),rotImg(i-1,j,3),rotImg(i-1,j+1,3),rotImg(i,j-1,3),rotImg(i,j,3),rotImg(i,j+1,3),rotImg(i+1,j-1,3),rotImg(i+1,j,3),rotImg(i+1,j+1,3)]);
       end
        end
    end
end

rotImg = uint8(rotImg);
end