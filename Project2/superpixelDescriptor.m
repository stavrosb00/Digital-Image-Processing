function outputImage = superpixelDescriptor(imIn , labels)
    %mpainei eikona enos kanaliou kai bgainei sthn eksodo eikona enos
    %kanaliou symfwna me ton kanona tou mesou orou stis omades twn
    %superpixels
    m = max(labels,[],'all'); %mporei na einai mikrotero apo 400 giati ta 
    %poly mikra teams o slicmex.c ta enswmatwnei se alla megalytera teams 
    [M,N] = size(imIn);
    imIn = double(imIn);
    outputImage = zeros(M,N);
    tempimg = imIn(:,:);
    for lb = 0:m
        %taktikes logical indexing gia na trexei me normal taxythta
        logIdx = (labels == lb);
        temp = zeros(M,N);
        temp(logIdx) = tempimg(logIdx);
        %mesos oros geitonias gia xrwmatismo superpixel
        mo = sum(temp,'all') / sum(logIdx,'all'); 
        outputImage(logIdx) = mo;
    end
end