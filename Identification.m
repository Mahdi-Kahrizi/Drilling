dd = diff(y(100,:));
derivative = [diff(y(100,:)),dd(1,end)]';
derivative2 = [diff(derivative'),derivative(end,end)]';
data = iddata(derivative,y(1,:)',dt);
% data = iddata(y(100,:)',y(1,:)',dt);
na = 8;
nb = 3;
nc = 0;
nd = 0;
nf = 0;
nk = 1;
nn = [na nb nc nd nf nk];
EstimatedParameters  = rpem(data,nn,'ff',0.99);

p = EstimatedParameters(end,:);


sys = idpoly([1 p(1:na)],... % A polynomial
    [zeros(1,nk) p(na+1:na+nb)],... % B polynomial
    [1 p(na+nb+1:na+nb+nc)],... % C polynomial
    [1 p(na+nb+nc+1:na+nb+nc+nd)]); % D polynomial
sys.Ts = 0.001;


compare(data,sys);

poless = roots(p(1,1:na))
dis_tf = tf(p(1,na+1:na+nb),p(1,1:na),0.001)
con_tf = d2c(dis_tf) 
numerator = cell2mat(con_tf.Numerator);
denominator = cell2mat(con_tf.Denominator);
 [A, B, C, D] = tf2ss(numerator, denominator);

 % for naa =2:20
 % 
 %     for nbb = 1:naa-1
 % 
 %    nn = [naa nbb nc nd nf nk];
 %    EstimatedParameters  = rpem(data,nn,'ff',0.99);
 % 
 %    p = EstimatedParameters(end,:);
 % 
 %    if sum(abs(roots(p(1,1:naa)))<1) == 0
 %        poless = roots(p(1,1:naa))
 %        break;
 %    end
 %     end
 % end
%%
