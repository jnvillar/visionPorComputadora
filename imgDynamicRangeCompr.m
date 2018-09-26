function [res]=imgDynamicRangeCompr(img)

imgDouble = double(img);
maxValue = max(max(imgDouble));

c =  (254/log(maxValue+1));

resDouble = c.*log(imgDouble+1);

res = uint8(resDouble);
end