
if rank(ctrb(A,B)) == size(A,1)
    disp('System is Controllable')
else
    disp('System is not Controllable')
end

if rank(obsv(A,C)) == size(A,1)
    disp('System is Observable')
else
    disp('System is not Observable')
end
%% Yalmip
yalmip('clear')

% Parameters
n= 1;
Jr = sdpvar(1,1);
Jp = sdpvar(1,1);
Jh = sdpvar(1,1);
Jb = sdpvar(1,1);

krp = sdpvar(1,1);
kph = sdpvar(1,1); 
khb = sdpvar(1,1);
crp = sdpvar(1,1);
cph = sdpvar(1,1);

chb = sdpvar(1,1);
cb = 50;
cr = 425;


S3Num = chb*cph*krp;
S2Num = chb*kph*krp+cph*khb*krp;
S1Num = khb*kph*krp;
S0Num = 0;

S7Den = Jb*Jh*Jp*Jr*Jr;
S6Den = (Jb*Jh*Jp*cr + Jh*Jp*Jr*cb + Jb*Jp*Jr*chb + Jb*Jh*Jr*cph+ Jb*Jh*Jp*crp + Jb*Jh*Jr*crp + Jh*Jp*Jr*chb + Jb*Jp*Jr*cph)*Jr;
S5Den = (Jb*Jp*Jr*khb + Jb*Jh*Jr*kph + Jb*Jh*Jp*krp + Jb*Jh*Jr*krp + Jh*Jp*Jr*khb + Jb*Jp*Jr*kph + Jh*Jp*cb*cr + Jb*Jp*chb*cr + Jp*Jr*cb*chb + Jb*Jh*cph*cr+ Jh*Jr*cb*cph + Jh*Jp*cb*crp + Jb*Jr*chb*cph + Jb*Jp*chb*crp + Jb*Jh*cph*crp + Jb*Jh*cr*crp + Jh*Jr*cb*crp + Jb*Jr*chb*crp + Jh*Jp*chb*cr + Jh*Jr*chb*cph + Jh*Jp*chb*crp + Jb*Jp*cph*cr + Jp*Jr*cb*cph + Jh*Jr*chb*crp + Jb*Jp*cph*crp+ Jb*Jr*cph*crp + Jp*Jr*chb*cph)*Jr;
S4Den = (Jb*Jp*cr*khb+ Jp*Jr*cb*khb+ Jb*Jh*cr*kph+ Jh*Jr*cb*kph+ Jh*Jp*cb*krp+ Jb*Jr*chb*kph+ Jb*Jr*cph*khb+ Jb*Jp*chb*krp+ Jb*Jp*crp*khb+ Jb*Jh*cph*krp+ Jb*Jh*crp*kph+ Jb*Jh*cr*krp+ Jh*Jr*cb*krp+ Jb*Jr*chb*krp+ Jb*Jr*crp*khb+ Jh*Jp*cr*khb+ Jh*Jr*chb*kph+ Jh*Jr*cph*khb+ Jh*Jp*chb*krp+ Jh*Jp*crp*khb+ Jb*Jp*cr*kph+ Jp*Jr*cb*kph+ Jh*Jr*chb*krp+ Jh*Jr*crp*khb+ Jb*Jp*cph*krp+ Jb*Jp*crp*kph+ Jb*Jr*cph*krp+ Jb*Jr*crp*kph+ Jp*Jr*chb*kph+ Jp*Jr*cph*khb+ Jp*cb*chb*cr+ Jh*cb*cph*cr+ Jb*chb*cph*cr+ Jr*cb*chb*cph+ Jp*cb*chb*crp+ Jh*cb*cph*crp+ Jb*chb*cph*crp+ Jh*cb*cr*crp+ Jb*chb*cr*crp+ Jr*cb*chb*crp+ Jh*chb*cph*cr+ Jh*chb*cph*crp+ Jp*cb*cph*cr+ Jh*chb*cr*crp+ Jp*cb*cph*crp+ Jb*cph*cr*crp+ Jr*cb*cph*crp+ Jp*chb*cph*cr+ Jp*chb*cph*crp+ Jr*chb*cph*crp)*Jr;
S3Den = (Jb*Jr*khb*kph + Jb*Jp*khb*krp + Jb*Jh*kph*krp + Jb*Jr*khb*krp + Jh*Jr*khb*kph + Jh*Jp*khb*krp + Jh*Jr*khb*krp + Jb*Jp*kph*krp + Jb*Jr*kph*krp + Jp*Jr*khb*kph + Jp*cb*cr*khb + Jh*cb*cr*kph + Jb*chb*cr*kph + Jb*cph*cr*khb+ Jr*cb*chb*kph + Jr*cb*cph*khb + Jp*cb*chb*krp + Jp*cb*crp*khb + Jh*cb*cph*krp + Jh*cb*crp*kph + Jb*chb*cph*krp + Jb*chb*crp*kph + Jb*cph*crp*khb + Jh*cb*cr*krp + Jb*chb*cr*krp + Jb*cr*crp*khb + Jr*cb*chb*krp+ Jr*cb*crp*khb + Jh*chb*cr*kph + Jh*cph*cr*khb + Jh*chb*cph*krp + Jh*chb*crp*kph+ Jh*cph*crp*khb + Jp*cb*cr*kph + Jh*chb*cr*krp + Jh*cr*crp*khb + Jp*cb*cph*krp + Jp*cb*crp*kph + Jb*cph*cr*krp + Jb*cr*crp*kph + Jr*cb*cph*krp + Jr*cb*crp*kph + Jp*chb*cr*kph + Jp*cph*cr*khb + Jp*chb*cph*krp + Jp*chb*crp*kph + Jp*cph*crp*khb + Jr*chb*cph*krp + Jr*chb*crp*kph + Jr*cph*crp*khb+ cb*chb*cph*cr + cb*chb*cph*crp + cb*chb*cr*crp + cb*cph*cr*crp + chb*cph*cr*crp)*Jr;
S2Den = (Jb*cr*khb*kph + Jr*cb*khb*kph + Jp*cb*khb*krp+ Jh*cb*kph*krp + Jb*chb*kph*krp + Jb*cph*khb*krp+ Jb*crp*khb*kph + Jb*cr*khb*krp+ Jr*cb*khb*krp + Jh*cr*khb*kph + Jh*chb*kph*krp+ Jh*cph*khb*krp + Jh*crp*khb*kph + Jh*cr*khb*krp+ Jp*cb*kph*krp + Jb*cr*kph*krp+ Jr*cb*kph*krp + Jp*cr*khb*kph+ Jp*chb*kph*krp + Jp*cph*khb*krp + Jp*crp*khb*kph + Jr*chb*kph*krp + Jr*cph*khb*krp + Jr*crp*khb*kph+ cb*chb*cr*kph+ cb*cph*cr*khb+ cb*chb*cph*krp + cb*chb*crp*kph+ cb*cph*crp*khb + cb*chb*cr*krp+ cb*cr*crp*khb+ cb*cph*cr*krp + cb*cr*crp*kph + chb*cph*cr*krp + chb*cr*crp*kph+ cph*cr*crp*khb)*Jr;
S1Den = (Jb*khb*kph*krp + Jh*khb*kph*krp + Jp*khb*kph*krp + Jr*khb*kph*krp + cb*cr*khb*kph + cb*chb*kph*krp + cb*cph*khb*krp + cb*crp*khb*kph + cb*cr*khb*krp + cb*cr*kph*krp + chb*cr*kph*krp + cph*cr*khb*krp + cr*crp*khb*kph)*Jr;
S0Den = (cb*khb*kph*krp + cr*khb*kph*krp)*Jr;
% Constraints
constraints = [Jr>=100,Jp>=100,Jb>=100,krp>=50];

% Objective function
obj = (S2Num-p(1,11))^2 + (S1Num-p(1,10))^2 + (S0Num-p(1,9))^2 + (S7Den-p(1,8))^2 + (S6Den-p(1,7))^2 + (S5Den-p(1,6))^2 + (S4Den-p(1,5))^2 + (S3Den-p(1,4))^2 + (S2Den-p(1,3))^2 + (S1Den-p(1,2))^2 + (S0Den-p(1,1))^2;


%solve

sol = optimize(constraints,obj);

if sol.problem ==0

    Jr_value = value(Jr)
    Jp_value = value(Jp)
    Jh_value = value(Jh)
    Jb_value = value(Jb)

    krp_value = value(krp)
    kph_value = value(kph)
    khb_value = value(khb)
    crp_value = value(crp)
    cph_value = value(cph)
    chb_value = value(chb)


    objvalue = value(obj)
else 

    display('Niaz be talash bishtar')

end
%%

K = place(A, B, [-7 -6 -5 -3 -10 -11 -13]);

% Display the feedback gain
disp('Feedback gain K:');
disp(K);

% Closed-loop system
A_cl = A - B * K;
