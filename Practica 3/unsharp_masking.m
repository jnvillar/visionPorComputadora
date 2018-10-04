function res=unsharp_masking(img, params)
    detailed = imsubtract(img, smoothing(img, params));
    res = imadd(img, detailed);
end