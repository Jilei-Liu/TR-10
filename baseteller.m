function base = baseteller(fcont)
base = [];
for i = 1:size(fcont,2)/3
    if norm(fcont(3*i-2:3*i))>0
        base = [base i];
    end
end
end