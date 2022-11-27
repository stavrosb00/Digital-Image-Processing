function clusterIdx = myGraphSpectralClustering(anAffinityMat , k)
    
    %bhma 1 o anAffinityMat einai o W mou
    %bhma 2 na brw ton diagwnio D pou einai a8roisma tou W kata j(2h
    %diastash) wste na brw ton L = D-W
    D = diag(sum(anAffinityMat,2));
    L = D - anAffinityMat;
    %bhma 3 kai 4 na brw ta genikeumena idiodianysmata/idiotimes tou L kai 
    %na krathsw ta k mikrotera idiodianysmata me thn eigs() ston U
    %D mpainei gia na threitai h genikeumenh lysh tou problhmatos
    [U,~] = eigs(L,D,k,'smallestreal');
    %bhma 5 na kanw clustering me k-means
    clusterIdx = kmeans(U,k);
end