function [heuristic,mc,mc_p] = masscenter(model)

x=model.x;
rod=model.rod;
cable=model.cable;
num_edge = size(rod,1)+size(cable,1);
num_node = size(x,1); 
p = zeros(num_edge,num_node);
mass_rod = 1;
mass_cable = 0.1;
for i = 1:size(rod,1)
    p(i,rod(i,1)) = mass_rod;
    p(i,rod(i,2)) = mass_rod;
end
for i = 1:size(cable,1)
    p(i+size(rod,1),cable(i,1)) = mass_cable ;
    p(i+size(rod,1),cable(i,2)) = mass_cable ;
end
z = p*x./2; 
mass = mass_rod*size(rod,1)+mass_cable*size(cable,1); 
mc = sum(z)./mass; 

model.base(model.base==0)=[];

PA=[sum(model.x(model.base,1))/length(model.base)
    sum(model.x(model.base,2))/length(model.base) 
    0];
PB=model.x(model.rollaxis(1),:);
PC=model.x(model.rollaxis(2),:);

mc_p=[mc(1) mc(2) 0];
AP = mc_p-PA';
BP = mc_p-PB;
CP = mc_p-PC;
AB = PB-PA';
AC = PC-PA';
BC = PC-PB;
AP(3)=0;
BP(3)=0;
CP(3)=0;
G = [AB(1),AC(1);AB(2),AC(2);AB(3),AC(3)];
U = linsolve(G,AP');
u = U(1);
v = U(2);
heuristic = norm(cross(BC,CP))/norm(BC); 

xv = [];
yv = [];
for i = 1:size(model.base,2)
    xv = [xv model.x(model.base(i),1)] ;
    yv = [yv model.x(model.base(i),2)] ;
end
xq = mc_p(1,1);
yq = mc_p(1,2);
[in,on] = inpolygon(xq,yq,xv,yv);
if in ==1 || on ==1 
  heuristic = -heuristic;
  return;
end

% if u>0&&v>0&&(u+v)>1
%     heuristic = -heuristic;
% end

end