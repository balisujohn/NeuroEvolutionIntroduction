%% Generating Simulation Enviorment
close all
tp = (0:0.001:1)';
yp = sin(2*pi*50*tp) + 2*sin(2*pi*120*tp);
yn = yp + 0.5*randn(size(tp));
t = tp(1:50);
y = yn(1:50);

%% Gradient Descent Algorithm for 2D Graph
resx = [1:50];
res = [1:50];
N = 50;
p = randperm(N);
for i = 1:50
    curr = p(i);
    if (curr ~= 1) && (curr ~= 50)
        while (yn(curr+1) < yn(curr)) || (yn(curr-1) < yn(curr)) 
            if (yn(curr+1) < yn(curr))
                curr = curr + 1;
                if curr == 50
                    break;
                end
            else
                curr = curr - 1;
                if curr == 1
                    break;
                end
            end
        end
    end
    res(i) = yn(curr);
    resx(i) = t(curr);
end

figure
plot(t,y);
hold on;
scatter(resx,res);
hold off;

%% Genetic Algorithm (Simulated Anneling)
resx2 = [1:50];
res2 = [1:50];
N = 50;
p = randperm(N);
for i = 1:50
    location = p(i);
    for j = 1:20000
        ranIndex = randperm(N);
        Neigh = ranIndex(i);
        ranNum = randperm(75);
        if yn(Neigh) < yn(location)
            location = Neigh;
        elseif ranNum(1) == 1
            location = Neigh;
        end
    end
    res2(i) = yn(location);
    resx2(i) = t(location);
end

figure
plot(t,y);
hold on;
scatter(resx2,res2);
hold off;