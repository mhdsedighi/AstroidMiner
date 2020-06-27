clc
clear
close all


a=10;
b=5;
c=5;

% res=0.3;
% 
% figure
% hold on
% axis equal
% view(25,45)
% 
% for x=-a:res:a
%     for y=-b:res:b
%         z=c^2*(1-x^2/a^2-y^2/b^2);
%         if z>=0
%             plot3(x,y,z,'b.')
%             plot3(x,y,-z,'b.')
%         end
%     end
% end

% [x, y, z] = ellipsoid(0,0,0,a,b,c,50);
% geom=surf(x, y, z);
% 
% 
% figure
% hold on
% axis equal
% view(25,45)
% plot3(x,y,z,'b.')

% N=length(x);
% vec_length=1;
% for i=1:N
%     for j=1:N
%         
%         p1=[x(i,j) y(i,j) z(i,j)];
%         dir=[geom.VertexNormals(i,j,1) geom.VertexNormals(i,j,2) geom.VertexNormals(i,j,3)];
%         p2=p1+vec_length*dir;
%         n_vec=[p1;p2];
%         plot3(p1(1),p1(2),p1(3),'b.');
%         plot3(n_vec(:,1),n_vec(:,2),n_vec(:,3));
% 
%     end
% end


%%% https://en.wikipedia.org/wiki/Ellipsoid
%%%https://www.scielo.br/scielo.php?script=sci_arttext&pid=S1982-21702014000400970

figure
hold on
axis equal
view(25,45)

res=6;
vec_length=3;
points=[];
for azimuth=0:res:360-res
    for elevation=-90:res:90-res
        
        x=a*cosd(elevation)*cosd(azimuth);
        y=b*cosd(elevation)*sind(azimuth);
        z=c*sind(elevation);
        points=[points; x y z];
        
        p1=[x y z];
        dir=[x/a^2 y/b^2 z/c^2];
        dir=dir/norm(dir);
        p2=p1+vec_length*dir;
        n_vec=[p1;p2];
        %         plot3(p1(1),p1(2),p1(3),'b.');
        plot3(n_vec(:,1),n_vec(:,2),n_vec(:,3));
        
    end
    
end

plot3(points(:,1),points(:,2),points(:,3),'b.')