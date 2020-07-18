function [rawDeviance] = retrieveDeviance(data, trial, b, t)
% deviance was calculated as absolute deviance in the task script. Here, I
% retrieve the raw deviance (ranging -180:180)

%%%finds radius of circle based on x and y coordinates,as every response
%provides a different radius. Then we can find the tau angle of the
%response. Initially tau is provided with the xx' but we need the angle
%with yy', so it is converted. If they pressed on the fixation cross
%no angle is created.
if data(t,b).respCoord(1)==centerX && data(t,b).respCoord(2)==centerY || isnan(data(t,b).respCoord(1)) && isnan(data(t,b).respCoord(2))
    rawDeviance = NaN;   
else
    %% Estimating response deviance from correct color angle(tau from theta).
    %positive value: response is more clockwise than probe
    %negative value: response is more anticlockwise than probe

    rawDeviance=data(t,b).tau - data(t,b).thetaCorrect;
    
    if abs(rawDeviance)>180
       if rawDeviance==abs(rawDeviance)
           rawDeviance=rawDeviance-360;
       else 
           rawDeviance=rawDeviance+360;
       end 
    end

end



end