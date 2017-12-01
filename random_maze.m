function [ maze ] = random_maze(N,r)
maze_temp = ones(N, N);
for i = 1 : N
    for j = 1 : N
        if rand < 0.01 * r
            maze_temp(i,j) = 0;
        end
    end
end
maze_temp(1,1)=1;
maze_temp(N,N)=1;
maze = maze_temp;

% maze=ones(N,N);
% maze(3,4)=0;
% maze(3,5)=0;
% maze(2,1)=0;
% maze(2,2)=0;
% maze(4,1)=0;
% maze(4,5)=0;

end

