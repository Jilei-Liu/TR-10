function [v_in,v_out] = innerspace(model)

rod = model.rod;
x = model.x;
[~,mc,~] = masscenter(model);

V = zeros(size(rod,1),1);
for i = 1:size(rod,1)
    p1 = mc-x(rod(i,1),:);
    p2 = x(rod(i,2),:)-x(rod(i,1),:);
    V(i) = norm(cross(p1,p2))/norm(p2);
end

r_in = mean(V);
d_in = 2*r_in;
v_in = pi*d_in^3/6;

distances = sqrt(sum((x-repmat(mc,size(x,1),1)).^2,2));
r_out = mean(distances);
d_out = 2*r_out;
v_out = pi*d_out^3/6*8;

end