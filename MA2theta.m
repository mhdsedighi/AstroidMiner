function [theta]=MA2theta(MA,e)

%%% https://en.wikipedia.org/wiki/Mean_anomaly

theta=MA+(2*e-0.25*e^3)*sin(MA)+...
    1.25*e^2*sin(2*MA)+...
    (13/12)*e^3*sin(3*MA);



end