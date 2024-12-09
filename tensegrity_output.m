function [force_rod,force_cable,force_string,len_cable,len_string,fcont,ff,mc,energy,v_in,v_ratio] = tensegrity_output(t,x,tstra,obj,m)   

node_num=size(x,1)/6;
rod = obj.rod;
cable = obj.cable;
string = obj.string;
c = obj.c;
k_rod = obj.k_rod;
k_cable =obj.k_cable;
k_string =obj.k_string;
c_rod = obj.c_rod;
c_cable = obj.c_cable;
c_string = obj.c_string;
xxx = zeros(node_num,3);
vvv = zeros(node_num,3);
length_rod = [];
for i = 1:node_num
    xxx(i,:) = x(3*i-2:3*i)';
    vvv(i,:) = x(3*i-2+3*node_num:3*i+3*node_num)';
end
d = c*xxx;
if size(tstra,1)>1
    for i = 1:size(tstra,1)-1
        try
            if tstra(i,1)<=t && t<tstra(i+1,1)
                length_rod = straGenerator(tstra(i,2:end)',tstra(i+1,2:end)',t,tstra(i,1));
            end
                
        catch
            keyboard
        end
    end
    if isempty(length_rod)
        length_rod = tstra(i+1,2:end)';
    end
else
    length_rod = tstra';
end

length_cable = obj.lc;
length_string = obj.ls;
fcont = zeros(3*node_num,1);
ff = zeros(3*node_num,1);
force_rod = zeros(size(rod,1),1);
force_cable = zeros(size(cable,1),1);
force_string = zeros(size(string,1),1);
len_cable = zeros(size(cable,1),1);
len_string = zeros(size(string,1),1);
energy_cable = zeros(size(cable,1),1);
energy_string = zeros(size(string,1),1);

for i = 1:node_num
    xx = [x(3*i-2) x(3*i-1) x(3*i)];
    vv = [x(3*i-2+3*node_num) x(3*i-1+3*node_num) x(3*i+3*node_num)];
    [fcont_temp,fftemp] = fcont_calculator(xx,vv,i);
    fcont(3*i-2:3*i) = fcont_temp';
    ff(3*i-2:3*i) = fftemp';
end
for i = 1:size(rod,1)
    vr = dot((vvv(rod(i,1),:) - vvv(rod(i,2),:)),d(i,:))/norm(d(i,:));
    force_rod(i,:) = -norm(k_rod*(norm(d(i,:))-length_rod(i))*d(i,:)/norm(d(i,:)) - c_rod*vr*d(i,:)/norm(d(i,:)));
end
for i = 1:size(cable, 1)
    vr = dot((vvv(cable(i,1),:) - vvv(cable(i,2),:)),d(i+size(length_rod,1),:))/norm(d(i+size(length_rod,1),:));
    force_cable(i,:) = norm(k_cable*(norm(d(i+size(length_rod,1),:))-length_cable(i))*d(i+size(length_rod,1),:)/norm(d(i+size(length_rod,1),:)) ...
        - c_cable*vr*d(i+size(length_rod,1),:)/norm(d(i+size(length_rod,1),:)));
    energy_cable(i) = 0.5*k_cable*(norm(d(i+size(length_rod,1),:))-length_cable(i))^2;
    len_cable(i,:)=norm(d(i+size(length_rod,1),:));
end
for i = 1:size(string, 1)
    vr = dot((vvv(string(i,1),:) - vvv(string(i,2),:)),d(i+size(length_rod,1)+size(length_cable,1),:))/norm(d(i+size(length_rod,1)+size(length_cable,1),:));
    force_string(i,:) = norm(k_string*(norm(d(i+size(length_rod,1)+size(length_cable,1),:))-length_string(i))*d(i+size(length_rod,1)+size(length_cable,1),:)/norm(d(i+size(length_rod,1)+size(length_cable,1),:)) ...
        - c_string*vr*d(i+size(length_rod,1)+size(length_cable,1),:)/norm(d(i+size(length_rod,1)+size(length_cable,1),:)));
    energy_string(i) = 0.5*k_string*(norm(d(i+size(length_rod,1)+size(length_cable,1),:))-length_string(i))^2;
    len_string(i,:)=norm(d(i+size(length_rod,1)+size(length_cable,1),:));
end
mc = sum(m*xxx)/sum(sum(m));
fcont = fcont';
ff = ff';
force_rod = force_rod';
force_cable = force_cable';
force_string = force_string';
len_cable = len_cable';
len_string = len_string';
energy = sum([energy_cable;energy_string]);
[v_in,v_out] = innerspace(obj);
v_ratio = v_in/v_out;
end