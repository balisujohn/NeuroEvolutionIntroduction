
%% Generating Simulation Environment
close all
tp = (0:0.001:1)';
yp = sin(2*pi*50*tp) + 2*sin(2*pi*120*tp);
yn = yp + 0.5*randn(size(tp));
t = tp(1:50);
y = yn(1:50);

function result  = validate(t,y, genotype, duration)
min = Inf;
pos = 1;
for i = 1:duration
    speed = genotype(1);
    jumpChance  = genoType(2);
    jumpDistance = genoType(3);
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
    
    pos = min(pos,50)
    pos = max(pos, 1)
    
    if t(pos) < min
        min = t(pos);
    end
    
    
end


result = min





end

