clear
clc
iteration = 50;
N = 10; 
r = 20;
gamma = 0.5;
learning_rate = 0.8;
action_number = 4;
action_choices = [-N,1,-1,N];
initial_state = 1;
goal_state = N*N;
maze = random_maze(N,r);
mazex = maze;
imagesc(mazex);
colormap(gray(256));
drawnow;
q_matrix = initialize_q_matrix(N, action_number);
i = 1;
k=1;
reward = 0;
trace_index = [];
trace_index2 = [];
x=[];
y=[];
time_limit=N*N;
for episode = 1 : iteration
    disp(['Iteration number: ',num2str(episode)]);
    instance=[];
    j=1;
    instance(j)=initial_state;
    j=j+1;
    trace_index(i)=initial_state;
    trace_index2(k)=initial_state;
    [x(k),y(k)]=state2coordinate(initial_state,N);
    i=i+1;
    k=k+1;
    current_state = initial_state;
    tic;
    while 1
    if toc>time_limit
            disp(['This maze can not be solved.']);
            return
    end        
%Simulasyon istenmiyorsa burasi yoruma alinmalidir.

        [a,b]=state2coordinate(current_state,N);
        mazex(a,b) = 0.5; 
        imagesc(mazex);
        drawnow;
        mazex(a,b) = maze(a,b); %Baslayan yorum buraya kadar surmelidir.
       
        if current_state == goal_state, break; end
        
        [val,index] = max( q_matrix(current_state,:) );
        [xx,yy] = find(q_matrix(current_state,:) == val);
        if size(yy,2) > 1            
            index = 1+round(rand*(size(yy,2)-1));
            chosen_action = yy(1,index);
        else
            chosen_action = index;
        end
        next_state = current_state + action_choices(chosen_action);    
        [a,b]=state2coordinate(next_state,N);
        if maze(a,b) == 0
            reward = -10;
        elseif next_state==goal_state;
            reward=20;
        else
           reward = -1;
        end
        
        q_matrix(current_state, chosen_action) = q_matrix(current_state, chosen_action)+ learning_rate * (reward + gamma * max(q_matrix(next_state,:))-q_matrix(current_state, chosen_action));
      
        if maze(a,b)==1
            current_state = next_state ;
        end
        instance(j)= current_state;
        j=j+1;
        trace_index(i) = current_state;
        i = i + 1;
        trace_index2(k) = current_state;
        [x(k),y(k)]=state2coordinate(current_state,N);
        k = k + 1;
    end
    if episode<iteration
        position1 = find(instance == 1);
        back_instance = fliplr(instance(position1(end)+1:end-1));
        for t = back_instance
            trace_index2(k)=t;
            [x(k),y(k)]=state2coordinate(t,N);           
            mazex(x(k),y(k)) = 0.5; 
            imagesc(mazex);
            drawnow; %Simulasyon istenmiyorsa burasi yoruma alinmalidir.
            mazex(x(k),y(k)) = maze(x(k),y(k));
            k=k+1;
        end
    end
end
%Son bulunan yol cizdirilir, koordinatlari kaydedilir.
x_shortest=[];
y_shortest=[];
n=1;
for m = instance
    [a,b]=state2coordinate(m,N);
    mazex(a,b) = 0.5;
    x_shortest(n)=a;
    y_shortest(n)=b;
    n=n+1;
end
imagesc(mazex);
%maze
if toc<=time_limit
    q_matrix
end