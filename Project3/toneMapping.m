%pairnei thn eksodo ths mergeLDRStack kai kanei tone mapping se authn
function tonedImage = toneMapping(radianceMap , gamma)
    %metatrepw thn eikona apo uint8 se double me 0...1 euros
    radM_d = im2double(radianceMap);
    %ypologizw tis nees entaseis kai epistrefw sthn arxikh uint8 morfh
    radM_d = (radM_d).^gamma;
    radM_d = rescale(radM_d,0,255);
    tonedImage = uint8(radM_d);
end