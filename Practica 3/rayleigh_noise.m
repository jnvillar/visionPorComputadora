function f=rayleigh_noise(img, mu, sigma)
    f = add_noise(img, mu, sigma);
end


function f=add_noise(img, mu, sigma)
    [X,Y] = size(img);    
    for i=1:X
        for j=1:Y
            r = rand();           
            r = mu + sqrt((-1)*sigma*log(1-r));
            f(i,j) = uint8(img(i,j)*r);  
        end
    end
end