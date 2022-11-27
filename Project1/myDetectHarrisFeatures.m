%synarthsh tou harris corner detector kefalaiou 1.3
%corners = myDetectHarrisFeatures( I )
%I : MxN grayscale image,double values [0,1]
%corners : Kx2 , every row is the coordinates of a corner
%extracted using Harris Corner Detector
function corners = myDetectHarrisFeatures(I)
    %parametroi
    sigma = 1;
    radius = 1;
    order=2*radius +1;
    threshold =10000;


    %maskes paragwgwn
    [dx,dy]= meshgrid(-1:1,-1:1);



    %ypologismos paragwgwn
    Ix=conv2(double(I),dx,'same');
    Iy=conv2(double(I),dy,'same');
    dim=max(1,fix(6*sigma));
    m=dim; n=dim;

    %smootharisma me gaussian filtro
    [h1,h2]= meshgrid(-(m-1)/2: (m-1)/2,-(n-1)/2: (n-2)/2);
    hg = exp(-(h1.^2+h2.^2)/(2*sigma^2));
    [a,b]= size(hg);
    sum=0;
    for i=1:a
        for j=1:b
            sum= sum+hg(i,j);
        end
    end
    g = hg ./sum;

    %stoixeia gia pinaka M
    Ix2=conv2(double(Ix.^2),g,'same');
    Iy2=conv2(double(Iy.^2),g,'same');
    Ixy=conv2(double(Ix.*Iy),g,'same');

    %to metro tou Harris
    R=(Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2+eps);

    %LocalMaxima ,sygkrinw thn geitonia gia na brw to edges send
    mx = ordfilt2(R,order^2,ones(order)); 

    %thresholding
    points = (R==mx)&(R> threshold);

    [rows,cols] = find(points);
    corners = [rows cols ];
end