function f = imgHist(img)

counter = zeros(1,255);

for i=1: size(img)
    counter(1,img(i)) = counter(1,img(i)) + 1;
end

f = counter;

end