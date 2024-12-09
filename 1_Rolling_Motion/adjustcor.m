function x = adjustcor(model)
%Adjust the coordinates so that:
%The regression plane of the bottom is located on the xy plane, and the overall plane is above the xy plane;
%The projection point of the centroid on the xy plane is located at the origin;
%The projection point of the rolling axis on the xy plane is perpendicular to the x-axis, and x is greater than 0.
base=model.base;
base(base==0)=[];
Px=model.x(base,1);
Py=model.x(base,2);
Pz=model.x(base,3);
X = [ones(length(Px),1) Px Py];
b = regress(Pz,X);
n=[b(2);b(3);-1];
p_r=[0;0;1];
u = cross(n,p_r)/norm(cross(n,p_r));
v = cross(u,n)/norm(cross(u,n));
w = cross(u,v);
theta = acosd(dot(n,p_r)/(norm(n)*norm(p_r)));
if theta~=0&&theta~=180
    Q = [u(1),u(2),u(3);
        v(1),v(2),v(3);
        w(1),w(2),w(3)];
    T = rotx(theta);
    R = Q'*T*Q;
    model.x = R*model.x';
    model.x = model.x';
end
[~,mc,~] = masscenter(model);
num_node = size(model.x,1);
model.x(:,1)=model.x(:,1)-mc(1)*ones(num_node,1);
model.x(:,2)=model.x(:,2)-mc(2)*ones(num_node,1);
model.x(:,3)=model.x(:,3)-mean(model.x(base,3))*ones(num_node,1);
if mean(model.x(:,3))<0
    T = rotx(180);
    model.x = T*model.x';
    model.x = model.x';
end
l_rollaxis=model.x(model.rollaxis(1),:)-model.x(model.rollaxis(2),:);
l_rollaxis(3)=0;
alpha = acosd(dot(l_rollaxis,[1 0 0])/norm(l_rollaxis))-90;
T = rotz(alpha);
model.x = T*model.x';
model.x = model.x';
if abs(model.x(model.rollaxis(1),1)-model.x(model.rollaxis(2),1))>0.01
    T = rotz(-alpha);
    model.x = T*model.x';
    model.x = model.x';
    model.x = T*model.x';
    model.x = model.x';
end
if model.x(model.rollaxis(1),1)<0
    T = rotz(180);
    model.x = T*model.x';
    model.x = model.x';
end
x=model.x;
zRise=abs(min(model.x(base,3))); 
x(:,3)=model.x(:,3)+zRise*ones(num_node,1);
end