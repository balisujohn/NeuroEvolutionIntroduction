

%creates a random adjacency matrix
Ad = randi([0 1],5,5)
for i = 1:size(Ad,2)
Ad(i,i) = 0
end

%creates weight matrix
W = rand(5,5).* 5 

%creates a random threshold vectors
thresh = rand(5,1).* 10

inputs = [1 ; 1;1 ; 1; 1]



o = advance(Ad, W, inputs ,thresh)
    
    
    function outputs = advance(Adj , W, i , t)
    Wa = W .* Adj
    s = Wa * i
   % s = atanh(s)
    o = (s-t)>0
    outputs = o
    end
    
    
    

    
    
    
