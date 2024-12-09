function base = baseteller(fcont)
%Based on the contact force received at the point, determine the  bottom
%surface of the current tensegrity
base = [];
for i = 1:12
    if norm(fcont(3*i-2:3*i))>0
        base = [base i];
    end
end
end