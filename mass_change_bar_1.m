function M = mass_change_bar_1(t)
%Choose tensegrity configuration : 1. 10-bar 30-cable Tensegrity Robot(TR-10)；2.6-bar 24-cable Tensegrity Robot(TR-6).
TensegrityRobotType = 1;
% Basic gait of TR-10 : 1.ES-step; 2.SE-step; 3.SS1-step; 4.SS2-step; 5.SS3-step; 6.SS4-step;
% Basic gait of TR-6  :  7.CO-step; 8.OCO-step;
% Combination gait of TR-10 : 11.Combination gait 1; 12.Combination gait 2; 13.Combination gait 3.
BaseGaitType = 1;
%=========================================
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

if TensegrityRobotType == 1
    if BaseGaitType == 1
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.525	0.825	0.525	0.525	0.525	0.525	0.525	0.525	0.825];
    elseif BaseGaitType == 2
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.525	0.525	0.525	0.825	0.525	0.825	0.825	0.825	0.525];
    elseif BaseGaitType == 3
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.525	0.525	0.825	0.825	0.525	0.825	0.825	0.825	0.525];
    elseif BaseGaitType == 4
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.825	0.825	0.525	0.525	0.825	0.825	0.825	0.825	0.825];
    elseif BaseGaitType == 5
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.825	0.525	0.525	0.525	0.525	0.525	0.525	0.825	0.525];
    elseif BaseGaitType == 6
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.825	0.825	0.525	0.525	0.825	0.825	0.525	0.525	0.525	0.525];
    elseif BaseGaitType == 11
    tstra=[
        0   0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.525	0.825	0.525	0.525	0.525	0.525	0.525	0.525	0.825
        50	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        75	0.525	0.825	0.825	0.525	0.525	0.825	0.525	0.825	0.825	0.825
        100	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        125	0.525	0.525	0.525	0.825	0.825	0.525	0.825	0.525	0.825	0.825];
    elseif BaseGaitType == 12
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.525	0.825	0.525	0.525	0.525	0.525	0.525	0.525	0.825
        50	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        75	0.525	0.825	0.525	0.525	0.525	0.525	0.525	0.525	0.825	0.525
        100	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        125	0.525	0.525	0.525	0.525	0.825	0.525	0.825	0.825	0.825	0.420];    
    elseif BaseGaitType == 13
    tstra=[
        0	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        25	0.525	0.525	0.825	0.525	0.525	0.525	0.525	0.525	0.525	0.825
        50	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        75	0.420	0.525	0.525	0.825	0.825	0.525	0.825	0.825	0.825	0.525
        100	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525	0.525
        125	0.825	0.825	0.525	0.525	0.825	0.825	0.825	0.525	0.525	0.525];
    end
end

if TensegrityRobotType == 2
    if BaseGaitType == 7
    tstra=[
        0	0.525	0.525	0.525	0.825	0.825	0.525
        25	0.525	0.525	0.525	0.525	0.525	0.525];
    elseif BaseGaitType == 8
    tstra=[
        0	0.525	0.825	0.825	0.525	0.525	0.525
        25	0.525	0.525	0.525	0.525	0.525	0.525];
    end
end

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


