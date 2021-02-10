function [ output ] = funcPos( inputVector, varargin )
%FUNCPOS Compute either the mean or the median of an input numeric vector
%   Demo for parsing inputs to function provided as positional arguments
    
    % Create an InputParser object
    p = inputParser;
    
    % Specify possible inputs
    defaultEstimate = 'mean'; % Default input to prefer
    validEstimates = {'mean', 'median'}; % Possible choices for input
    checkEstimates = @(x) any(validatestring(x, validEstimates)); % Anonymous function to check/validate inputs from list of possible choices
    
    % Add inputs to the InputParser
    addRequired(p, 'inputvector', @isnumeric); % This input is required and can't not be provided
    addOptional(p, 'estimate', defaultEstimate, checkEstimates); % This input may or may not be provided since there exists a default choice
    
    % Throw a fit if the inputs do not match the provided parsing scheme
    p.KeepUnmatched = false;
    
    % Parse the inputs based on the specified scheme in the InputParser object
    parse(p, inputVector, varargin{:});
    
    % Do what the function is supposed to do
    functionToExec = str2func(p.Results.estimate); % Convert the input string to a function
    output = functionToExec(inputVector); % Execute the function and return output

end

