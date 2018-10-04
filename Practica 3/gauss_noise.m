function f=gauss_noise(img, white_limit, black_limit, mu, sigma)
    [i,j] = size(img);
    for i=1:i
        for j=1:j
            f(i,j)=add_noise(img(i,j),white_limit, black_limit, mu, sigma);
        end
    end
end

function f=add_noise(pixel,white_limit,black_limit,  mu, sigma)
   r = normrnd(mu,sigma);
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