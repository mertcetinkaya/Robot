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
visited_flag=zeros(1,100);
while 1
[a,b]=state2coordinate(current_state,N);
mazex(a,b) = 0.5; 
imagesc(mazex);
drawnow;
if current_state==100 break; end
mazex(a,b) = maze(a,b);
q_alt=network1(transpose(cat(2,current_state,state(current_state),state_environment(current_state,:))));
[val,index] = max( q_alt);
if visited_flag(current_state+action_choices(index))==1 || state(current_state+action_choices(index))==0 ...
    || (mod(current_state,10)==0 && index==2) || (mod(current_state,10)==1 && index==3) 
    t=sort(q_alt,'descend');
    t_index=2;
    while 1
        index=find(q_alt==t(t_index));
        if (current_state+action_choices(index)<1) || (current_state+action_choices(index)>100)...
            || (visited_flag(current_state+action_choices(index))==1) || (index==2 && mod(current_state,10)==0)...
            || (index==3 && mod(current_state,10)==1) || (state(current_state+action_choices(index))==0)
            t_index=t_index+1;
            if t_index==5
                return;
            end
            continue;
        end
        break;
    end
end
chosen_action=index;
current_state=current_state+action_choices(chosen_action);
visited_flag(current_state)=1;
end
