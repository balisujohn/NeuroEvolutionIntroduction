function result  = validation(genotype)
global t;
global y; 
global duration;

lowest = Inf;
pos = 1;
for i = 1:duration
    speed = genotype(1);
    jumpChance  = genotype(2);
    jumpDistance = genotype(3);
    if pos < 50
        gradient = t(pos + 1) - t(pos);
        pos = floor(pos - (gradient * speed));
    elseif pos > 1
        gradient = t(pos) - t(pos-1);
        pos = floor(pos - (gradient * speed));
    end
    if rand() <  jumpChance
        pos = pos + ((rand()-1) *jumpDistance);
    end
    
    pos = min(pos,50);
    pos = max(pos, 1);
    
    if t(pos) < lowest
        lowest = t(pos);
    end
    
    
end


result = lowest;





end

