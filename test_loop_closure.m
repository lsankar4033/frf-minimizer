% Playing with some stuff
function [f1, f2, f3] = test_loop_closure()

    for i = 1:3
        f = @(x) x * i;
        
        if i == 1
            f1 = f;
        elseif i == 2
            f2 = f;
        else
            f3 = f;
        end 
    end
end