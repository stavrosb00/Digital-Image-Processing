function responseCurve = estimateResponseCurve(imgStack , exposureTimes , smoothingLamda , weightingFcn)
    [~,~,Nt] = size(imgStack);
    Z = [];
    %% downsampling gia na brw Z
    for k=1:Nt
        imageActive = imgStack(:,:,k);
        samplesFreq = 64;
        if Nt == 7
            samplesFreq = 32;
        end
        tempImage = imageActive(1:samplesFreq:end, 1:samplesFreq:end);
        [m, n] = size(tempImage);
        img = reshape(tempImage,[m*n 1]);
        Z(:,k) = img;
    end
    %% synarthsh barous
    w = [];
    for k=1:Nt
        w(:,k) = weights(im2double(mat2gray(Z(:,k))), exposureTimes(k), weightingFcn);
    end    
    %% Paul Debevec
    B = log(exposureTimes);
    n = 256;
    A = zeros(size(Z,1)*size(Z,2)+n+1,n+size(Z,1));
    b = zeros(size(A,1),1);
    %% Include the data-fitting equations
    k = 1;
    for i=1:size(Z,1)
        for j=1:size(Z,2)
            wij = w(Z(i,j)+1);
            A(k,Z(i,j)+1) = wij;
            A(k,n+i) = -wij;
            b(k,1) = wij * B(j);
            k=k+1;
        end
    end

    %% Fix the curve by setting its middle value to 0
    A(k,129) = 1;
    k=k+1;
    
    %% Include the smoothness equations
    for i=1:n-2
        A(k,i)=smoothingLamda*w(i+1); A(k,i+1)=-2*smoothingLamda*w(i+1); A(k,i+2)=smoothingLamda*w(i+1);
        k=k+1;
    end
    
    %% Solve the system using SVD
    x = A\b;
    responseCurve = x(1:n);
    %g = x(1:n);
    %lE = x(n+1:size(x,1));
    

end