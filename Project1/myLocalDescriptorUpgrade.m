%synarthsh tou descriptor kefalaiou 1.2
function d = myLocalDescriptorUpgrade(I,p,rhom,rhoM,rhostep ,N)
    b = size(I); %h eikona I apo prin einai grayscale dhladh 1D kai oxi 3
    d = [];
    for rho = rhom:rhostep:rhoM
        x_rho = [];
        for theta = 0:(2*pi/N):2*pi
            [x,y] = pol2cart(theta, rho);
            x = floor(x + p(1));
            y = floor(y + p(2));
            if y >= 1 || y <= b(1) || x >= 1 || x <= b(2)
                x_new = [];
                neigh = [x+1 y+1 ;x+1 y-1 ;x-1 y+1 ;x-1 y-1 ]; %geitonia tou shmeiou
                for i = 1:4
                    if neigh(i,1) >= 1 && neigh(i,1) <= b(1) && neigh(i,2) >= 1 && neigh(i,2) <= b(2)
                        x_new = [x_new; I(neigh(i,1), neigh(i,2))];
                    end
                end
                x_new = floor(mean(x_new));
                if isnan(x_new)
                    x_new = [];
                end
                x_rho = [x_rho; x_new];
            end
        end
        x_mean = mean(x_rho);
        if ~isnan(x_mean)
            d = [d; mean(x_rho)];
        end
    end
end