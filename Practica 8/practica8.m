% Ejercicio 1

% a) φz = 90 φy = −90◦

rz = [ cosd(90) -sind(90) 0        ; sind(90) cosd(90) 0; 0         0      1        ];
ry = [ cosd(-90) 0         sind(-90); 0        1        0;-sind(-90) 0      cosd(-90)];

res1 = rz*ry; 

% b) φx = 90 φz = 90◦

rx = [1         0         0       ; 0        cosd(90)  -sind(90);0   sind(90) cosd(90)];
rz = [ cosd(90) -sind(90) 0        ; sind(90) cosd(90) 0; 0         0      1        ];

res2 = rz*rx; 

% c) φx = 45 φy = 90 φz = 30

rx = [1         0       0       ; 0        cosd(45) -sind(45); 0         sind(45) cosd(45)];
rz = [cosd(30) -sin(30) 0       ; sind(30) cosd(30) 0        ; 0         0        1];
ry = [cosd(90) 0        sind(90); 0        1        0        ; -sind(90) 0        cosd(90)];

res3 = rz*ry*rx; 

% Ejercicio 2

x = [3 4 -3];
c = [5, 3, 5];
ry = [ cosd(-90) 0         sind(-90); 0        1        0;-sind(-90) 0      cosd(-90)];

xcam = ry*(x-c)';

%Ejericio 3 , jugar con ej2.m

% Ejercicio 4

f = 2;
p = [0 1];
c = [0 0 1];

x = [f*2/4 f*3/4];
k = [2 0 0; 0 2 1; 0 0 1];
p = k * [1 0 0 0; 0 1 0 1 ; 0 0 1 1];
