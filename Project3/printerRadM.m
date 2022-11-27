function ct = printerRadM(radM, ct, label, gamma)
    f = figure('Name','Demo2','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for RGB channels using %s as weight function, gamma= %.2f',label,gamma))
    subplot(1,2,1)
    imagesc(radM(:,:,:))
    subplot(1,2,2)
    imhist(radM(:,:,:));

    name = sprintf('test_%d.png',ct);
    ct = ct + 1;
    imwrite(radM, name); %,c,
    %kokkino
    f = figure('Name','Demo2','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for Red channel using %s as weight function, gamma= %.2f',label,gamma))
    subplot(1,2,1)
    imagesc(radM(:,:,1))
    c = colormap(autumn);
    axis off
    colorbar
    subplot(1,2,2)
    imhist(radM(:,:,1));

    name = sprintf('test_%d.jpg',ct);
    ct = ct + 1;
    imwrite(radM(:,:,1),c, name,'Quality',100);
    %prasino
    f = figure('Name','Demo2','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for Green channel using %s as weight function, gamma= %.2f',label,gamma))
    subplot(1,2,1)
    imagesc(radM(:,:,2))
    c = colormap(summer);
    axis off
    colorbar
    subplot(1,2,2)
    imhist(radM(:,:,2));

    name = sprintf('test_%d.jpg',ct);
    ct = ct + 1;
    imwrite(radM(:,:,2),c, name,'Quality',100);
    %mple
    f = figure('Name','Demo2','NumberTitle','off');
    f.WindowState = 'maximized';
    sgtitle(sprintf('HDR Radiance Map for Blue channel using %s as weight function, gamma= %.2f',label,gamma))
    subplot(1,2,1)
    imagesc(radM(:,:,3))
    c = colormap(winter);
    axis off
    colorbar
    subplot(1,2,2)
    imhist(radM(:,:,3));
    
    name = sprintf('test_%d.jpg',ct);
    ct = ct + 1;
    imwrite(radM(:,:,3),c, name, 'Quality',100);
end