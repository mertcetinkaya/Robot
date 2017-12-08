clc
N = 10; 
r = 20;
action_number = 4;
action_choices = [-N,1,-1,N];
maze = random_maze(N,r);
[state,state_environment]=state_environment_control(maze,N);
mazex = maze;
imagesc(mazex);
colormap(gray(256));
drawnow;
current_state=1;
trace=[];
k=1;
time_limit=20;
visited_flag=zeros(1,N*N);
tic;
while 1
if toc>time_limit
        disp(['This maze can not be solved.']);
        pause(3);
        position1 = find(trace == 1);
        back_trace = fliplr(trace(position1(end):end-1));
        for i = back_trace
            [x,y]=state2coordinate(i,N);           
            mazex(x,y) = 0.5; 
            imagesc(mazex);
            drawnow;
            mazex(x,y) = maze(x,y);
        end
        return;
end
[a,b]=state2coordinate(current_state,N);
trace(k)=current_state;
k=k+1;
mazex(a,b) = 0.5; 
imagesc(mazex);
drawnow;
if current_state==N*N break; end
mazex(a,b) = maze(a,b);
q_alt=network1(transpose(cat(2,current_state,state(current_state),state_environment(current_state,:))));
t=sort(q_alt,'descend');
t_index=1;
while 1
    index=find(q_alt==t(t_index));
    if (current_state+action_choices(index)<1) || (current_state+action_choices(index)>N*N)...
        || (visited_flag(current_state+action_choices(index))==1) || (index==2 && mod(current_state,N)==0)...
        || (index==3 && mod(current_state,N)==1) || (state(current_state+action_choices(index))==0)
        t_index=t_index+1;
        if t_index==4
            [x,y]=state_environment_control(maze,N);
            if any(y(current_state,:))==0
                disp(['This maze can not be solved.']);
                return;
            end
            possible_index=find(y(current_state,:)==1);
            if length(possible_index)==4
                [val,index] = min( q_alt);
                possible_index(index)=[];
            end
            chosen_index=randi(length(possible_index));
            index=possible_index(chosen_index);
            break;
        end
        continue;
    end
    break;
end
chosen_action=index;
current_state=current_state+action_choices(chosen_action);
visited_flag(current_state)=1;
end
