function [yfit,IP,slope,varargout]=LogisticRegressionFunction(x,y,xxMin,xxMax)
    %Logistic regression of choices. We used the equation
    %f(x)/(1-f(x))=e^(beta0+beta1*x) to extract the Indifference Point(x),
    %while f(x)=0.5. We use xx instead of x in glmval so that we represent the
    %whole curve of all choices instead of only the easy choices viewed by each ppt. 

    xx = linspace(xxMin,xxMax); %range of x values = range of easy offers
    eqProb=0.5; % = indifference point
    betas = glmfit(x, y,'binomial','link','logit'); %regression coefficients for choice = 0 and choice = 1. Gives a negative and a positive coefficient, respectively. 
    yfit = glmval(betas, x, 'logit'); %regression line
    IP=(log(eqProb/(1-eqProb))-betas(1))/betas(2);
    slope = betas(2);

    switch nargout
        case 4
        varargout=(log(probability/(1-probability))-betas(1))/betas(2);
    end
end

