function [ A , B ] = myRANSAC( intPoints1, intPoints2, R)

repNumb=1000;
thr=2;
maxK=-1;%maximum gia ta shmeia endiaferontos

uni=unique(R(:,1),'stable');

for i=1:repNumb
    %%%3random points
    rng('shuffle');
    a=randi(length(uni),3,1);
    while length(unique(R(a,2)))~=3 || length(unique(R(a,1)))~=3
        a=randi(length(uni),3,1);
    end
    x1=R(a,1);
    x2=R(a,2);
    
    
    %testing = myImgRotation(segment, angle);
    %differences
    %eukleidia apostash shmeiwn
    xx=differences(:,1).^2;
    yy=differences(:,2).^2;
    difs=sqrt(xx+yy);
    k=sum(difs<thr);
    %maximum ari8mos shmeiwn pou tairiazoun
    if k>maxK
        maxK=k;
        A=Ai;
        B=Bi;
    end
    
end




end