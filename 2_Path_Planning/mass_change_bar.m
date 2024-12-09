function M = mass_change_bar(t)
%================================
%Choose tensegrity configuration : 1. 10-bar 30-cable Tensegrity Robot(TR-10)；2.6-bar 24-cable Tensegrity Robot(TR-6).
TensegrityRobotType = 1;
%====================================
% Electric push bar parameter setting
ML=0.5;      % Quality of the left end component
MR=0.5;      % Quality of the right end component
Lmin=0.525;  % The shortest length of the push bar extension
Lmax=0.825;  % The length of the push bar when extended to its maximum
L1=0.525;    % The length of the thick part of the push bar
L2=0.525;    % The length of the slender part of the push bar
v=0.012;     % Push bar drive speed
%=========================================
% Central load setting
if TensegrityRobotType == 1
m0=2.1; 
elseif TensegrityRobotType == 2
m0=1.5; 
end

global tstra;

for i=1:size(tstra,1)
    if t<tstra(i,1)
        t=mod(t,tstra(i,1)-tstra(i-1,1));
        break
    end
end 
mi=zeros(10,1);
mj=zeros(10,1);
for j=1:size(tstra,2)-1
    if tstra(i,j+1)>tstra(i-1,j+1) 
        mi(j)=Lmin/2/L1*ML+(1-Lmin/2/L2)*MR+0.5*v*t*(ML/L1-MR/L2);
        mj(j)=Lmin/2/L2*MR+(1-Lmin/2/L1)*ML-0.5*v*t*(ML/L1-MR/L2);
    elseif tstra(i,j+1)<tstra(i-1,j+1) 
        mi(j)=Lmax/2/L1*ML+(1-Lmax/2/L2)*MR-0.5*v*t*(ML/L1-MR/L2);
        mj(j)=Lmax/2/L2*MR+(1-Lmax/2/L1)*ML+0.5*v*t*(ML/L1-MR/L2);
    elseif tstra(i,j+1)==tstra(i-1,j+1) && tstra(i,j+1)==0.525 
        mi(j)=Lmin/2/L1*ML+(1-Lmin/2/L2)*MR;
        mj(j)=Lmin/2/L2*MR+(1-Lmin/2/L1)*ML;
    else 
        mi(j)=Lmax/2/L1*ML+(1-Lmax/2/L2)*MR;
        mj(j)=Lmax/2/L2*MR+(1-Lmax/2/L1)*ML;
    end
end

if TensegrityRobotType == 1
m=diag([mi(1);mj(2);mi(3);mj(4);mi(5);mj(6);mi(7);mj(8);mi(4);mj(7); ...
        mi(8);mj(3);mi(2);mi(9);mj(9);mi(10);mj(1);mi(6);mj(5);mj(10); ...
        m0]);
end
if TensegrityRobotType == 2
m=diag([mi(1);mj(1);mi(2);mj(2);mi(3);mj(3);mi(4);mj(4);mi(5);mj(5);mi(6);mj(6);m0]);
end

M=kron(m,eye(6));

end

