function out = tensegrity_ode(t,x,tstra,obj)   
node_num=size(x,1)/6;
out = zeros(6*node_num,1);
rod = obj.rod;
cable = obj.cable;
string  = obj.string;
c = obj.c;
k_rod = obj.k_rod;
k_cable =obj.k_cable;
k_string =obj.k_string;
c_rod = obj.c_rod;
c_cable = obj.c_cable;
c_string = obj.c_string;
xxx = zeros(node_num,3);
length_rod = []; 
for i = 1:node_num
    xxx(i,:) = x(3*i-2:3*i)';
end
d = c*xxx; 
if size(tstra,1)>1
    for i = 1:size(tstra)-1
        if tstra(i,1)<=t && t<tstra(i+1,1)
            length_rod = straGenerator(tstra(i,2:end)',tstra(i+1,2:end)',t,tstra(i,1));
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
g = zeros(3*node_num,1);
force_rod = zeros(3*node_num,1);
force_cable = zeros(3*node_num,1);
force_string = zeros(3*node_num,1);
if obj.type == 1
M = mass_change_bar_1(t);
elseif obj.type == 2
M = mass_change_bar_2(t);
end
for i = 1:node_num

    xx = [x(3*i-2) x(3*i-1) x(3*i)];
    vv = [x(3*i-2+3*node_num) x(3*i-1+3*node_num) x(3*i+3*node_num)];

    [fcont_temp,fftemp] = fcont_calculator(xx,vv,i);
    fcont(3*i-2:3*i) = fcont_temp';
    ff(3*i-2:3*i) = fftemp';
    g(3*i) = -9.8*M(6*i,6*i)*cosd(0);        
end
for k = 1:size(rod,1)
    ix = 3*rod(k,1)-2;
    iv = 3*rod(k,1)-2+3*node_num;
    jx = 3*rod(k,2)-2;
    jv = 3*rod(k,2)-2+3*node_num;   
    delta = (norm(d(k, : ))-length_rod(k)) /norm(d(k, : ))* d(k,:)';
    vr = dot((x(iv:iv+2) - x(jv:jv+2)),d(k,:)')/norm(d(k,:));
    force_rod(ix:ix+2) = -k_rod * delta + force_rod(ix:ix+2) - c_rod*vr*d(k,:)'/norm(d(k,:));
    force_rod(jx:jx+2) = k_rod * delta + force_rod(jx:jx+2) + c_rod*vr*d(k,:)'/norm(d(k,:));
end
for k = 1:size(cable, 1)
    ix = 3*cable(k,1)-2;
    iv = 3*cable(k,1)-2+3*node_num;
    jx = 3*cable(k,2)-2;
    jv = 3*cable(k,2)-2+3*node_num;   
    delta = (norm(d(k+size(rod,1), : ))-length_cable(k)) /norm(d(k+size(rod,1), : ))* d(k+size(rod,1),:)';
    vr = dot((x(iv:iv+2) - x(jv:jv+2)),d(k+size(rod,1),:)')/norm(d(k+size(rod,1),:));
    if norm(d(k, : ))>length_cable(k)
        force_cable(ix:ix+2) = -k_cable * delta + force_cable(ix:ix+2) - c_cable*vr*d(k+size(rod,1),:)'/norm(d(k+size(rod,1),:));
        force_cable(jx:jx+2) = k_cable * delta + force_cable(jx:jx+2) + c_cable*vr*d(k+size(rod,1),:)'/norm(d(k+size(rod,1),:));
    end
end
for k = 1:size(string, 1)
    ix = 3*string(k,1)-2;
    iv = 3*string(k,1)-2+3*node_num;
    jx = 3*string(k,2)-2;
    jv = 3*string(k,2)-2+3*node_num;   
    delta = (norm(d(k+size(rod,1)+size(cable,1), : ))-length_string(k)) /norm(d(k+size(rod,1)+size(cable,1), : ))* d(k+size(rod,1)+size(cable,1),:)';
    vr = dot((x(iv:iv+2) - x(jv:jv+2)),d(k+size(rod,1)+size(cable,1),:)')/norm(d(k+size(rod,1)+size(cable,1),:));
    if norm(d(k, : ))>length_string(k)
        force_string(ix:ix+2) = -k_string * delta + force_string(ix:ix+2) - c_string*vr*d(k+size(rod,1)+size(cable,1),:)'/norm(d(k+size(rod,1)+size(cable,1),:));
        force_string(jx:jx+2) = k_string * delta + force_string(jx:jx+2) + c_string*vr*d(k+size(rod,1)+size(cable,1),:)'/norm(d(k+size(rod,1)+size(cable,1),:));
    end
end
node_force = force_rod + force_cable+ force_string + g + fcont+ff;
out(1:3*node_num) = x((3*node_num+1):6*node_num);
out((3*node_num+1):6*node_num) = node_force;
end