function lr = straGenerator(inilr,golr,t,t0)

lr = zeros(size(inilr,1),1);
actSpeed = 12*1e-3;
for i = 1:size(inilr,1)
    switch golr(i)>inilr(i)
        case true
            lr(i) = min(golr(i),inilr(i)+actSpeed*(t-t0));
        case false
            lr(i) = max(golr(i),inilr(i)-actSpeed*(t-t0));
    end
end
