function [res]=dynamic_range_compr(img)
imgDouble = double(img);
maxValue = max(max(imgDouble));
disp(maxValue);
c =  (254/log(maxValue+1));
resDouble = c.*log(imgDouble+1);
res = uint8(resDouble);
end