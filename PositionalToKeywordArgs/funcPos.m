function [ output ] = funcPos( inputVector, varargin )
%FUNCPOS Compute either the mean or the median of an input numeric vector
%   Detailed explanation goes here
    
    p = inputParser;
    
    defaultEstimate = 'mean';
    validEstimates = {'mean', 'median'};
    checkEstimates = @(x) any(validatestring(x, validEstimates));
    
    addRequired(p, 'inputvector', @isnumeric);
    addOptional(p, 'estimate', defaultEstimate, checkEstimates);
    
    p.KeepUnmatched = false;
    
    parse(p, inputVector, varargin{:});
    
    functionToExec = str2func(p.Results.estimate);
    output = functionToExec(inputVector);

end
