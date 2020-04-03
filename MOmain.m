clear,clc

% space of design variables
x_low = 0;
x_up = 9;

%draw the base plot
draw_base();

% define initial temperature, terminal temperature, cooling coefficients
temp_init = 1e3;
temp_term = 0;
alpha = 0.98;
% generating initial random point and calculate the function values
x_old = (x_up - x_low)*rand() + x_low;
x_new = x_old;

s_old = obj(x_old);
s_new = s_old;

% recording the temperature change
text_lt = text(0,0,'Initial');

% count
count = 0;
pic_num = 1;

% annealing process, while loop

while (temp_init > temp_term)
    % disturb
    delta = 3* (rand() - 0.5);
    x_new = x_old + delta;
    % if disturb less half searching space, this is a way to prevent new value
    % from being greater than searching space
    if (x_new < x_low || x_new > x_up)
        x_new = x_new - 2*delta;
    end
    s_new = obj(x_new);
    
    % get difference
    dE = s_old - s_new;
    
    % judge
    j = judge(dE, temp_init);
    if(j)
        s_old = s_new;
        x_old = x_new;
    end
    
    % if dE < 0, ruduce temperature
    if (dE < 0)
        delete(text_lt);
        hold on, scatter(x_old, s_old);
        hold on, text_lt = text(0.3, 21, ['temp: ', num2str(temp_init)]);
        pause(0.01);
        
        temp_init = temp_init * alpha;
    else
        count = count + 1;
    end
    %%%%%% draw gif anamation
    drawnow;
    F=getframe(gcf);
    I=frame2im(F);
    [I,map]=rgb2ind(I,256);
    if pic_num == 1
        imwrite(I,map,'test1.gif','gif', 'Loopcount',inf,'DelayTime',0.1);
    else
        imwrite(I,map,'test1.gif','gif','WriteMode','append','DelayTime',0.1);
    end
    pic_num = pic_num + 1;
    %%%%% end of gif anamation
    
    % if probability of accepting new solotion is too small, it takes long
    % time to find no optimal solution, then exit loop
    if (count > 1000)
        break;
    end
end

