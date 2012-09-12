% Given a set of parameters, a function to call on that set of parameters,
% and a target margin, find the minimizing first parameter of the function
% using fmincon iteratively...
function xjt = grid_search(aij, li, Ai, st, T, f, margin)
    
    % Function that, given a function on the parameters, reduces it to 
    % a function of just one column of xjt.  Used for fmincon magic
    function reduced_f = reduce_function(aij, li, Ai, st, f, xjt, t)
        function result = inner_f(single_col)
            xjt(1:end, t) = single_col;
            result = f(xjt, aij, li, Ai, st);
        end
        
        reduced_f = @inner_f;
    end
    
    J = size(aij, 2);
    
    % Initialize xjt
    xjt = ones(J, T);
    xjt = xjt * (1 / J);
    
    % Iterate until break condition at bottom
    while true
        old_result = f(xjt, aij, li, Ai, st);
        for t = 1:T
            % Optimize column t of xjt, all other things constant
            reduced_f = reduce_function(aij, li, Ai, st, T, f, xjt, t);

            % Add up to 1 constraint
            Aeq = ones(J);
            beq = ones(J, 1)

            % Lower, upper bound on vector
            lb = zeros(J ,1);
            ub = ones(J, 1);

            xjt = fmincon(reduced_f, xjt(1:end,t), 0, 0, Aeq, beq, lb, ub);
        end
        new_result = f(xjt, aij, li, Ai, st);
        
        % Break out if the difference due to this iteration is less than
        % the margin
        delta = old_result - new_result;
        if (delta < margin)
            break;
        end
    end

end

