function t_rank = straDiv(stra)

t_rank = zeros(size(stra,1),1);
actspeed = 0.012;
if size(stra,1)>1
    for i = 1:size(stra,1)-1
        dlr = abs(stra(i+1,:)-stra(i,:));
        t_rank(i+1) = max(dlr)/actspeed;
    end
else
    t_rank = [];
end

t_rank1=t_rank;
for i=1:size(stra,1)-1
    t_rank(i+1)=sum(t_rank1(1:i+1));
end
end