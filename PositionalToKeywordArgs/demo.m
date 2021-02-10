%%%% Generate data for computing mean and median
x = [1:10, 100]; % mean should be 14.0909, median should be 6

%%%% Call signature for function with positional arguments

% Positional arguments are provided based on input order
% No arguments
out = funcPos(x); % By default -> mean

% Mean
out = funcPos(x, 'mean');

% Median
out = funcPos(x, 'median');

%%%% Call signature for function with keyword arguments

 % Need to provide identifier key with an associated value
 % eg: 'estimate', 'mean' or 'estimate', 'median'

% No arguments
out = funcKW(x); % By default -> mean

% Mean
out = funcKW(x, 'estimate', 'mean'); % Note the extra identifier key: 'estimate'

% Median
out = funcKW(x, 'estimate', 'median'); % Note the extra identifier key: 'estimate'
