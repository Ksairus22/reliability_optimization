function K_m = getCoefResistor_kM(power)
if power<=0.5
K_m = 0.7;
elseif pwoer>0.5
K_m = 1.5;
else
K_m = 4.5;
end
end