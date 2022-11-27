%1h syna
%lista 1 xrwma MxN img se uint8
%oi xronoi ek8eshs
%epilogh synarthsh barous 1-uni , 2-tenta, 3-gauss, 4-photon(me tk)
% imgStack = IvR;
% exposureTimes = tk;
% weightingFcn = 2;
function radianceMap = mergeLDRStack(imgStack , exposureTimes , weightingFcn)
    [M,N,Nt] = size(imgStack);
    imgStackD0_1 = im2double(imgStack);
    w = zeros(M, N, Nt);
    for k=1:Nt
        w(:,:,k) = weights(imgStackD0_1(:,:,k), exposureTimes(k), weightingFcn);
    end
    
    tkl = log(exposureTimes);
    up = zeros(M,N);
    down = zeros(M,N);
    robust = zeros(M,N);
    %ypologismo a8roismatwn
    for k = 1:Nt
        imgActive = imgStackD0_1(:,:,k);
        imgLog = log(imgActive);
        imgLog(isinf(imgLog)) = 0; %na agnoh8oun osa arxikh entash->0
        %ypologizw eurwstia
        %8ewrw apokrish thn grammikh kampylh me koresmo
        robust = (imgLog - tkl(k));
        up = up + w(:,:,k).*robust;
        down = down + w(:,:,k);
        
    end
    %hint gia na apofygw kakous syntelestes sthn diairesh(0/... , .../0)
    %baros/baros->8ewreitai ashmanto kai agnoeitai
    koresmenaV2 = find(robust == 0);
    up(koresmenaV2) = robust(koresmenaV2);
    down(koresmenaV2) = 1;
    %telikos xarths fwteinothtas HDR
    radianceMap = up ./ down;
    %radianceMap = exp(radianceMap);
end