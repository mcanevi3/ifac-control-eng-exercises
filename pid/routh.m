function conds = routh(coef)
% ROUTH   Compute symbolic Routh-Hurwitz stability conditions
%
%   conds = routh(coef)
%
%   coef : symbolic or numeric vector [a_n ... a_0]
%   conds: vector of symbolic inequalities for Hurwitz stability
%
%   Example:
%       syms a4 a3 a2 a1 a0
%       coef = [a4 a3 a2 a1 a0];
%       conds = routh(coef)

    % Ensure symbolic
    coef = sym(coef);

    n = length(coef);
    s = sym('s');

    % Normalize so leading coefficient = 1
    coef = coef / coef(1);
    n = length(coef);

    % Build Routh array
    m = ceil(n/2);
    R = sym(zeros(n, m));

    % Fill first two rows
    R(1, :) = coef(1:2:end);
    R(2, 1:length(coef(2:2:end))) = coef(2:2:end);

    % Fill remaining rows
    for i = 3:n
        for j = 1:m-1
            % Routh formula
            R(i,j) = simplify( (R(i-1,1)*R(i-2,j+1) - R(i-2,1)*R(i-1,j+1)) / R(i-1,1) );
        end
    end

    % Extract first column (conditions for positivity)
    first_col = simplify(R(:,1));

    % Define symbolic conditions
    conds = sym.empty(0,1);
    for i = 1:length(first_col)
        conds(i,1) = first_col(i); % > 0;
    end

    if false
        % Display results (optional)
        disp('Routh array:');
        disp(vpa(R));
        disp('Stability conditions (first-column > 0):');
        disp(conds);
    end
end
