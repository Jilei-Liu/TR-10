function [y,energy]=dynrlx(model)

length_rod=model.lr;
length_cable=model.lc;
x=model.x;
rod=model.rod;
cable=model.cable;
k_rod=model.k_rod;
k_cable=model.k_cable;

delta_time = 0.1;   
num_edge = size(rod,1)+size(cable,1);
num_node = size(x,1);
c = zeros(num_edge,num_node); 
for i = 1:size(rod,1)
    c(i,rod(i,1)) = 1;
    c(i,rod(i,2)) = -1;
end
for i = 1:size(cable,1)
    c(i+size(rod,1),cable(i,1)) = 1 ;
    c(i+size(rod,1),cable(i,2)) = -1 ;
end
force_rod = zeros(num_node,3);  
force_cable = zeros(num_node,3); 
sigma_rod = zeros(num_node,1);  
sigma_cable = zeros(num_node,1); 
velocity_1 = zeros(num_node,3);  
velocity_2 = zeros(num_node,3);  
d = c*x;  
for k = 1:size(rod,1)
    delta = (norm(d(k, : ))-length_rod(k)) /norm(d(k, : ))* d(k,:);
    force_rod(rod(k,1), : ) = -k_rod * delta + force_rod(rod(k,1), : );
    force_rod(rod(k,2), : ) = k_rod * delta +  force_rod(rod(k,2), : );
    sigma_rod(rod(k,1),1) = norm( k_rod * delta)/norm(d(k, : )) + k_rod + sigma_rod(rod(k,1),1);
    sigma_rod(rod(k,2),1) = norm( k_rod * delta)/norm(d(k, : )) + k_rod + sigma_rod(rod(k,2),1);
end
for k = 1:size(cable, 1)
    if norm(d(k+size(rod,1), : ))>length_cable(k)
        delta = (norm(d(k+size(rod,1), : ))-length_cable(k)) /norm(d(k+size(rod,1), : ))* d(k+size(rod,1),:);
        force_cable(cable(k,1), : ) = -k_cable * delta + force_cable(cable(k,1), : );
        force_cable(cable(k,2), : ) = k_cable * delta + force_cable(cable(k,2), : );
    end
    sigma_cable(cable(k,1),1) = norm( k_cable * delta)/norm(d(k+size(rod,1), : )) + k_cable + sigma_cable(cable(k,1),1);
    sigma_cable(cable(k,2),1) = norm( k_cable * delta)/norm(d(k+size(rod,1), : )) + k_cable + sigma_cable(cable(k,2),1);
end
node_force = force_cable + force_rod;
node_sigma = 1000*(sigma_rod + sigma_cable);

node_mass = 0.5*delta_time^2*node_sigma;

for a = 1:3
    velocity_1(:,a) = 0.5*delta_time*node_force(:,a)./node_mass; 
end
x = x +delta_time*velocity_1.*1000;
Ek_1 = zeros(num_node,1);
Ek_2 = zeros(num_node,1);
R = zeros(num_node,1);  
for i = 1:num_node
    Ek_1(i) = 0.5*node_mass(i)*(norm(velocity_1(i,:)))^2;
    R(i) = norm(node_force(i,:));
end
n = 1;
force_rod = zeros(num_node,3);
force_cable = zeros(num_node,3);
sigma_rod = zeros(num_node,1);
sigma_cable = zeros(num_node,1);
sigma_R=zeros(50000,1);

while(norm(R,1)>1e-3)
    sigma_R(n)=norm(R,1);
    if n>50000
        y=model.x;
        energy=0;
        return
    end 
    d = c*x;
    for k = 1:size(rod,1)
        delta = (norm(d(k, : ))-length_rod(k)) /norm(d(k, : ))* d(k,:);
        force_rod(rod(k,1), : ) = -k_rod * delta + force_rod(rod(k,1), : );
        force_rod(rod(k,2), : ) = k_rod * delta +  force_rod(rod(k,2), : );
        sigma_rod(rod(k,1),1) = norm( k_rod * delta)/norm(d(k, : )) + k_rod + sigma_rod(rod(k,1),1);
        sigma_rod(rod(k,2),1) = norm( k_rod * delta)/norm(d(k, : )) + k_rod + sigma_rod(rod(k,2),1);
    end
    for k = 1:size(cable, 1)
        delta = (norm(d(k+size(rod,1), : ))-length_cable(k)) /norm(d(k+size(rod,1), : ))* d(k+size(rod,1),:);
        if norm(d(k, : ))>length_cable(k)
            force_cable(cable(k,1), : ) = -k_cable * delta + force_cable(cable(k,1), : );
            force_cable(cable(k,2), : ) = k_cable * delta + force_cable(cable(k,2), : );
        end
        sigma_cable(cable(k,1),1) = norm( k_cable * delta)/norm(d(k+size(rod,1), : )) + k_cable + sigma_cable(cable(k,1),1);
        sigma_cable(cable(k,2),1) = norm( k_cable * delta)/norm(d(k+size(rod,1), : )) + k_cable + sigma_cable(cable(k,2),1);
    end
    node_force = force_cable + force_rod;
    node_sigma = 1000*(sigma_rod + sigma_cable);
    node_mass = 0.5*delta_time^2*node_sigma;
    for a = 1:3
        velocity_2(:,a) = velocity_1(:,a) + delta_time*node_force(:,a)./node_mass;
    end
    for i = 1:num_node
        Ek_1(i) = 0.5*node_mass(i)*(norm(velocity_1(i,:)))^2;
        Ek_2(i) = 0.5*node_mass(i)*(norm(velocity_2(i,:)))^2;
        R(i) = norm(node_force(i,:));
    end
    if norm(Ek_1,1)<norm(Ek_2,1)
        velocity_1 = velocity_2;
        x = x +delta_time*velocity_1.*1000;
    else
        for a = 1:3
            velocity_1(:,a) = 0.5*delta_time*node_force(:,a)./node_mass;
        end
        x = x +delta_time*velocity_1.*1000;
    end
    n = n + 1;
    force_rod = zeros(num_node,3);
    force_cable = zeros(num_node,3);
    sigma_rod = zeros(num_node,1);
    sigma_cable = zeros(num_node,1);
end
d=c*x;
energy_cable = zeros(size(cable,1),1);
for k = 1:size(cable,1)
    energy_cable(k) = 0.5*k_cable*(norm(d(k+size(rod,1),:))-length_cable(k))^2;
end
energy = norm(energy_cable,1);
y = x;
end