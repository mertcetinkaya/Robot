function [ state, state_environment ] = state_environment_control( maze,N )
state_environment=zeros(N*N,4);
state=reshape(transpose(maze),[N*N,1]);
%state=transpose(maze_straight);
for i=1:N*N
    if i-N < 1
        state_environment(i,1)=0;
    else
        state_environment(i,1)=state(i-N);
    end
    if mod(i,N)==0
        state_environment(i,2)=0;
    else
        state_environment(i,2)=state(i+1);
    end
    if mod(i,N)== 1 
        state_environment(i,3)=0;
    else
        state_environment(i,3)=state(i-1);
    end
    if i+N > N*N
        state_environment(i,4)=0;
    else
        state_environment(i,4)=state(i+N);
    end
end