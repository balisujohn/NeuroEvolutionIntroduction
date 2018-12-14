

function [result,pos]  = validation(genotype)
global t;
global y; 
global duration;

lowest = 3;
pos = ceil(rand * 50);
bestPos = pos;
for i = 1:duration
    speed = genotype(1);
    jumpChance  = genotype(2);
    jumpDistance = genotype(3);
    if pos < 50
        gradient = y(pos + 1) - y(pos);
        pos = ceil(pos - (gradient * speed));
    elseif pos > 1
        gradient = y(pos) - y(pos-1);
        pos = floor(pos - (gradient * speed));
    end
    if rand() <  jumpChance
        pos = floor(pos + ((rand()-.5) *jumpDistance));
    end
    
    pos = min(pos,50);
    pos = max(pos, 1);
    
    assert(pos >0 && pos < 51)
    if y(pos) < lowest
        lowest = y(pos);
        bestPos = pos;
    end
    
    
end


result = interp1([-4,4],[1,100],-1 * lowest);

if isnan(result) || isinf(result)
    out = result
end
assert(result > 0)

pos  =bestPos;

end



