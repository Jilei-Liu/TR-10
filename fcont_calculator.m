function [fcont,ff] = fcont_calculator(x,v,i)
k = 1000000;  
c = 2000;     
c2 = 50;
mu = 0.3;     
[gnd,n] = z(x);

if (i==13&&x(3)-0.05<gnd(3)) || (i~=13&&x(3)<gnd(3))
    if i~=13
        fcont = (k*(dot((gnd-x),n)) - c*dot(v,n))*n;
    else
        fcont = (k*(dot((gnd-x),n)+0.05) - c*dot(v,n))*n; 
    end
    ff_1 = -c2*(v-dot(v,n)*n);           
    ff_2 = -mu*norm(fcont)*(v-dot(v,n)*n)/norm(v-dot(v,n)*n);

    TF=isnan(ff_2);
    ff_2(TF)=0;

    if norm(ff_1)<norm(ff_2)
        ff = ff_1;
    else
        ff = ff_2;
    end
else
    fcont = zeros(1,3);
    ff = zeros(1,3);
end
end
function [gnd,n]=z(x)
gnd =zeros(1,3);
gnd(1) = x(1);
gnd(2) = x(2);
gnd(3) = 0*x(1)+0*x(2);  
n=[0,0,1];  
end