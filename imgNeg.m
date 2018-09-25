function imagen = imgNeg(img)
 
[X,Y,Z]=size(img);

disp(class(img))

for i=1:X
    for j=1:Y
        for k=1:Z
            imagen2(i,j,k) = 255 - img(i,j,k);
        end
    end
end
 
figure(1),title('Figura Original'),imshow(img);
figure(2),title('Figura Imagen Negativa'),imshow(imagen2);
 
end