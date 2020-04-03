function [y] = judge(dE, t)
% define a judge function to set a probability to accept a solution
% dE is the difference between new and old objective funtion values
% t is the currrent temperature
% return the probability y
 if (dE < 0)
     y = 1;
 else
     p = exp(-(dE / t)); % 
     if (p > rand)
         y = 1;
     else
         y = 0;
     end
 end
end