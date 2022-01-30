close all




figure
hold on
plot(out.analog_sig.Time,squeeze(out.analog_sig.Data))
plot(out.digital_sig.Time,out.digital_sig.Data)
xlabel('time (seconds)')
ylabel('Thrust (N)')

legend('hypothetical continious thrust','actual thrust')


