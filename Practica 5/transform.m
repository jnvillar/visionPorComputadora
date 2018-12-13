function f = transform(x,y,m)
    v = [x y 1]';
    v = m*v;
    f = [round(v(1)/v(3)) round(v(2)/v(3))];
end