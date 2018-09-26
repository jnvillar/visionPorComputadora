function f = imgHist(img)

[x,y] = size(img);
counter = zeros(1,256);

for i=1: x
    for j=1:y
        counter(1,img(i,j)+1) = counter(1,img(i,j)+1) + 1;
    end
end

f = counter;

end