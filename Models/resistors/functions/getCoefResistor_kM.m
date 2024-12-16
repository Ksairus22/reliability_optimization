function K_m = getCoefResistor_kM(power)
if power<=0.5
K_m = 0.7;
elseif (power>0.5) & (power<=2)
K_m = 1.5;
elseif power>2
K_m = 4.5;
else
K_m = inf;
end
end