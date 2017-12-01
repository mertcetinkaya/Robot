function [ q_matrix ] = initialize_q_matrix( N, actions )
q_matrix = zeros(N*N, actions);
q_matrix(1:N, 1) = -inf;
q_matrix(N*(N-1)+1 : N*N, 4) = -inf;
q_matrix(1,3)=-inf;
for i = 1 : N
    q_matrix(i*N,2) = -inf;
    q_matrix(i*N + 1, 3) = -inf;
end
q_matrix = q_matrix( 1:N*N, :);
end

