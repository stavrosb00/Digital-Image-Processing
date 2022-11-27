function myAffinityMat = SPImage2Graph(spImage)
    [m, n] = size(spImage);
    myAffinityMat = double(zeros(m));
    spImage = double(spImage);
    for i = 1:m
        for j = 1:m
            dist_euc = 0;
            for k = 1:n
                 dist_euc = dist_euc + (spImage(i,k)-spImage(j,k)).^2; %eukleidia apostash fwteinothtas metaksy pixels
            end
            dist_euc = sqrt(dist_euc);
            myAffinityMat(i,j) = 1/(exp(dist_euc));%A=1/(e^d)
        end
    end
end
