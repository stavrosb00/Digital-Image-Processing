function Im = myStitch(im1 , im2 )
c1=myDetectHarrisFeatures(im1);
c2=myDetectHarrisFeatures(im2);

%
f1=myLocalDescriptor(im1,c1);
f2=extractFeatures(im2,c2);



R=findMatches(f1,f2);


[A , B] = myRANSAC(c1,c2,R);


%testing = myImgRotation(segment, angle);

%..........

end