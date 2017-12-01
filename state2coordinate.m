function [ a,b ] = state2coordinate( state,N )
if mod(state,N)==0
    a=fix(state/N);
else
    a=fix(state/N)+1;
end
b=mod(state,N);
if b==0
    b=N;
end
end

