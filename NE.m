
%creates a random adjacency matrix
Ad = randi([0 1],5,5)
for i = 1:size(Ad,2)
Ad(i,i) = 0
end

%creates weight matrix
W = rand(5,5).* 5 
s = W .* Ad

activation = 


%creates a random threshold vectors
thresh = rand(5,1).* 10

