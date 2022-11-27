function w = weights(z, tk, weightingFcn)
    zmin = 0.04;
    zmax = 0.96;
    [M, N, ~] = size(z);
    w = zeros(M, N);
    koresmena = (z > zmax | z < zmin);
    switch weightingFcn
        %uni
        case 1
            %
            w = ones(M,N);; %+1

        %tenta
        case 2
            %
            w = min(z, 1-z);
        %gauss
        case 3
            %
            w = (exp(-4 * ((z - 0.5).^2) ./ (0.5^2)) );
        %photon
        case 4
            %
            w = tk* ones(M,N); 
        otherwise
            disp('Error on weightingFcn argument')
    end
    
    w(koresmena) = 0;
end