% f -> Distancia focal:
%f = 0.1;
f = 1.5;

% s -> Skewness:
s = 0.0;

% px, py -> 0 cuando el origen en la imagen de la camara 
% coincide con el eje z de la camara.
px = 0.5;
py = 0.5;

% K -> la matriz de calibracion:
K = [f s px;...
     0 f py;...
     0 0 1];

% theta_x -> el angulo de rotacion sobre el eje x.
% theta_y -> el angulo de rotacion sobre el eje y.
% theta_z -> el angulo de rotacion sobre el eje z.
theta_x = pi/2; %-3*pi/4;
theta_y = 0;
theta_z = 0; %pi/4;%0;

% Las respectivas matrices de rotaccion:
Rz = [cos(theta_z) -sin(theta_z) 0;...
      sin(theta_z)  cos(theta_z) 0;...
      0 0 1];
Rx = [1 0 0;...
      0 cos(theta_x) -sin(theta_x);...
      0 sin(theta_x)  cos(theta_x)];
Ry = [cos(theta_y) 0 sin(theta_y);...
      0 1 0;...
      -sin(theta_y) 0 cos(theta_y)];

% R -> La rotacion total.
R = Rz*Ry*Rx;
Ri = inv(R);

% C -> La posicion de la camara en coordenadas del mundo.
C = [3 10 3]'; % enfrentado
C = [5 10 5]'; % de costado

% P -> La matriz de la camara.
P = K*Ri*[eye(3) -C];

X = obtener_puntos();

% X -> las coordenadas de los puntos en el mundo.
% x -> las coordenadas de los mismos puntos en la imagen de la camara.
x = P*X;

% xin -> x pero en inhomogeneas.
xin = [x(1,:)./x(3,:);x(2,:)./x(3,:)];

dibujar_con_camara(C, R, P, X, xin)