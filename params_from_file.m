% Get FRF parameters from given xls file
function [aij, li, Ai, st] = params_from_file(filename)
    file_data = importdata(filename);
    aij = file_data.data.aij;
    li = file_data.data.li;
    Ai = file_data.data.Ai;
    st = file_data.data.st; 
end