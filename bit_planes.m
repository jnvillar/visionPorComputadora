function [res]=bit_planes(img)
res = cat(2, get_bit_plane(img, 1), get_bit_plane(img, 2), get_bit_plane(img, 3), get_bit_plane(img, 4), get_bit_plane(img, 5), get_bit_plane(img, 6), get_bit_plane(img, 7), get_bit_plane(img, 8));
end

function [res]=get_bit_plane(img, n)
res = bitget(double(img),n);
end
