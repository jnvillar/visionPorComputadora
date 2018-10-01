function f = imgNeg(img)
 
[X,Y,Z]=size(img);

for i=1:X
    for j=1:Y
        for k=1:Z
            negative(i,j,k) = 255 - img(i,j,k);
        end
    end
end
 
f = negative;
 
end