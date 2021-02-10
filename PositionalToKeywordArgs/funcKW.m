function [ output ] = funcKW( inputVector, varargin )
%FUNCKW Summary of this function goes here
%   Detailed explanation goes here

    % Create an InputParser object
    p = inputParser;
    
    % Specify possible inputs
    defaultEstimate = 'mean'; % Default input to prefer
    validEstimates = {'mean', 'median'}; % Possible choices for input
    checkEstimates = @(x) any(validatestring(x, validEstimates)); % Anonymous function to check/validate inputs from list of possible choices
    
    % Add inputs to the InputParser
    addRequired(p, 'inputvector', @isnumeric); % This input is required and can't not be provided
    
    % Add keyword argument to the InputParser
    addParameter(p, 'estimate', defaultEstimate, checkEstimates); % This input may or may not be provided since there exists a default choice
    
    % Throw a fit if the inputs do not match the provided parsing scheme
    p.KeepUnmatched = false;
    
    % Parse the inputs based on the specified scheme in the InputParser object
    parse(p, inputVector, varargin{:});
    
    % Do what the function is supposed to do
    functionToExec = str2func(p.Results.estimate); % Convert the input string to a function
    output = functionToExec(inputVector); % Execute the function and return output

end

