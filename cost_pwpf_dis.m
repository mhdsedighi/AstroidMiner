function cost = cost_pwpf_dis(inputArg)



Tm_d=inputArg(1);
Km_d=inputArg(2);
h=inputArg(3);
u_off=inputArg(4);
Thrust_digital=inputArg(5);

u_on=h+u_off;


assignin('base','Tm_d',Tm_d);
assignin('base','Km_d',Km_d);
assignin('base','u_off',u_off);
assignin('base','u_on',u_on);
assignin('base','Thrust_digital',Thrust_digital);

% simout=sim('pwpf');

% % https://nl.mathworks.com/matlabcentral/answers/114527-limit-computation-time-of-a-simulink-simulation
% % https://stackoverflow.com/questions/35446636/access-to-cpu-time-during-simulink

model='pwpf_dis';
timeout=4;

set_param(model,'SimulationCommand','start')
tic;
while(true)
    if not(strcmpi(get_param(model,'SimulationStatus'),'running'))
        %         disp('simulation exited')
        
        out1=evalin('base','out');
        cost=out1.err.Data;
        break;
    end
    if toc>=timeout
        %         disp('timout reached')
        set_param(model,'SimulationCommand','stop')
        cost=7777777;
        break;
    end
    pause(0.1);
end



end

