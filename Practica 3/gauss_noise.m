function f=gauss_noise(img, white_limit, black_limit, mu, sigma)
    f = imadd(img,generate_noise_image(img,white_limit, black_limit, mu, sigma));
end

function f=generate_noise_image(img,white_limit,black_limit,  mu, sigma)
    [X,Y] = size(img);
    r = normrnd(mu,sigma);
    r = mu+(sigma-mu)*r;

    for i=1:X
        for j=1:Y
            if r <= white_limit
                f(i,j) = -255;
            end
            if r > white_limit && r<= black_limit
                f(i,j) = 0;
            end
            if r>black_limit
                f(i,j) = 255;
            end
        end
    end
    disp(size(img))
    disp(size(f))
    uint8(f)
end


function f=gauss_noise_original(img, white_limit, black_limit, mu, sigma)
    [i,j] = size(img);
    for i=1:i
        for j=1:j
            f(i,j)=add_noise(img(i,j),white_limit, black_limit, mu, sigma);
        end
    end
end

function f=add_noise(pixel,white_limit,black_limit,  mu, sigma)
   r = normrnd(mu,sigma);
   r = mu+(sigma-mu)*r;
   if r <= white_limit
       f=0;
       return
   end
   if r > white_limit && r<= black_limit
      f=pixel;
      return
   end
   if r>black_limit
       f=255;
       return
   end
end