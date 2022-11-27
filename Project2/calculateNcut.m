function nCutValue = calculateNcut(anAffinityMat , clusterIdx)

    W = anAffinityMat;
    %oi etiketes einai 1~A kai 2~B kai kanw logical indexing basei autwn
    %gia na brw ta katallhla mhkh twn clusters 1 kai 2
    idxA = (clusterIdx == 1);
    idxB = (clusterIdx == 2);
    %a8roisma barwn kombwn metaksy clusters
    assocAA = sum(sum(W(idxA,idxA))); %pixels anhkoun A kai A clusters
    assocBB = sum(sum(W(idxB,idxB))); %pixels anhkoun B kai B clusters
    assocAV = sum(sum(W(idxA,:))); %pixels anhkoun A kai olon ton grapho
    assocBV = sum(sum(W(idxB,:))); %pixels anhkoun B kai olon ton grapho
    
    nassoc = assocAA/assocAV + assocBB/assocBV;
    nCutValue = 2 - nassoc;
end