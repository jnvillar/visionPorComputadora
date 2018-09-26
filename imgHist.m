function f = imgHist(img)

[x,y] = size(img);
counter = zeros(1,255);

for i=1: x
    for j=1:y
        counter(1,img(i,j)) = counter(1,img(i,j)) + 1;
    end
end

f = counter;

end