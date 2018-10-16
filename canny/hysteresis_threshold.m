function res=hysteresis_threshold(magnitude, directions, u_min, u_max)
   magnitude(magnitude < u_max) = 0;
   magnitude(magnitude >= u_max) = 1;
   res = magnitude;
   [X,Y] = size(res);
%    for i=1:X
%         for j=1:Y
%             if res(i,j) == 0
%                 res(i,j) = 
%             end
%         end
%     end
end