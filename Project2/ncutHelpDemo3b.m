%boh8htikh synarthsh gia to demo3b opou xwrizw anadromika me ncut
function clusterIdx = ncutHelpDemo3b(anAffinityMat, init, T1, T2)
    
    %arxikopoiw ton pinaka omadwn pou tha epistrafei
    clusterIdx = zeros(size(anAffinityMat,1),1);
    
    %spasimo se 2 clusters panta
    %bhma 1 o anAffinityMat einai o W mou
    %bhma 2 na brw ton diagwnio D pou einai a8roisma tou W kata j(2h
    %diastash) wste na brw ton L = D-W
    D = diag(sum(anAffinityMat,2));
    L = D - anAffinityMat;
    %bhma 3 kai 4 na brw genikeumena idiodianysmata/idiotimes tou L kai na 
    %krathsw ta k mikrotera idiodianysmata me thn eigs() ston U
    [U,~] = eigs(L,D,2,'smallestreal');
    %bhma 5 na kanw clustering me k-means
    cluster = kmeans(U,2);
   
    %briskw to mhkos twn stoixeiwn ka8e omadas
    len1 = sum(cluster==1);
    len2 = sum(cluster==2);
    
    %syn8hkh gia mhkos dentrou T1
    if len1 < T1 || len2 < T1
        %ektelesh otan prwtoarxikopoieitai h diadikasia ths synarthshs
        if init == 1
            clusterIdx = cluster;
        else
            clusterIdx = ones(size(cluster));
        end
        return
    end
    
    ncut = calculateNcut(anAffinityMat, cluster);
    
    %syn8hkh gia ncut value T2
    if ncut > T2
        %ektelesh otan prwtoarxikopoieitai h diadikasia ths synarthshs
        if init == 1
            clusterIdx = cluster;
        else
            clusterIdx = ones(size(cluster));
        end
        return
    end
    
    %xwrizw omades se 2 groups
    pointIdx1 = find(cluster==1);
    pointIdx2 = find(cluster==2);
    
    %kanw ek neou affinity pinaka gia to ka8e group
    affinity1 = anAffinityMat(pointIdx1,pointIdx1);
    affinity2 = anAffinityMat(pointIdx2,pointIdx2);
    
    %briskw tis nees omades
    cluster1 = ncutHelpDemo3b(affinity1, 0, T1, T2);
    cluster2 = ncutHelpDemo3b(affinity2, 0, T1, T2);
    
    %to megisto ID tou cluster1 to pros8etw sto cluster2
    cluster2 = cluster2 + max(cluster1);
    
    %pros8etw to ena cluster sto allo gia na krathsw monadikh seira
    %etiketas
    clusterIdx = [cluster1; cluster2];
    pointIdxs = [pointIdx1; pointIdx2];
    [~,indices] = sort(pointIdxs);
    
    %anadiataksh shmeiwn sth swsth seira basei tou original deikth tous
    clusterIdx = clusterIdx(indices);

    
end