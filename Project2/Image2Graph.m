function myAffinityMat = Image2Graph(imIn)
    %eikona eisodou MxN me n kanalia
    [M,N,n] = size(imIn);
    %pinakas A pou perigrafei grafo
    myAffinityMat = zeros(M*N,M*N);
    dist_euc = zeros(M*N,M*N);
    channels = cell(1,n);
    %xwrizw thn eikona sta n kanalia gia na kanw prakseis metaksy twn
    %pixels diaforetikwn kanaliwn
    for i=1:n
        channels(i) = {imIn(:,:,i)};
    end
    %% na brw ta barh tou A
    for i=1:M*N
        for j=1:M*N
            for k=1:n
                dist_euc(i,j) = dist_euc(i,j) + norm(channels{k}(i) - channels{k}(j)); %eukleidia apostash fwteinothtas metaksy pixels
            end
            myAffinityMat(i,j) = 1/(exp(dist_euc(i,j)));%A=1/(e^d)
        end
    end    
end