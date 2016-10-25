function [E] = ABAM_2_Layers()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     ABAM Training (2-Layers)
% 
% INPUTS:
%    W     -- Weight that connects the 2 layers
%    ox    -- Input vector
%    thr1  -- Threshold for input neurons.
%    thr2  -- Threshold for output neurons.
%    mode  -- Set the mode to 'Bipolar' for bipolar vectors, otherwise
%             you have binary mode.
%
% OUTPUTS:
%    ax - Input layer activation after convergence
%    ay - Output layer activation after convergence 
%    E  -  Energy for each iteartion (-ax*W*ay')
%    The output file is result.txt and it contins all the outputs.  
%
% NOTE: You can modify the threshold values to suit your purpose.
%       The vectors are binary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 



%% Define the Neural Network
% Number of neurons for each layer
I  = 5 ; 
K = 5;

% Initialize the weights randomly
% Set the range for thr weight
e  = 2;

% Random selestcion of W
W = unifrnd(-e, e, I,K);

% Set threshold values
thr1  = 0;
thr2  = 0;

% Set the mode to ('Bipolar' or 'Binary'). Default mode is binary.
mode = 'Bipolar';
%%

%% Initialize the input vector randomly.  
ox = unifrnd(-3,3,I,1);

E = [];
count = 1;

if (strcmp(mode,'Bipolar'))
    ax = (2*(ox >= thr1))-1;
    
    while(count < 100)
        
        %--FORWARD PASS
        oy = W'*ax;
        ay = (2*(oy >= thr2))-1;
        
        %--BACKWARD PASS
        ox = W*ay;
        ax = (2*(ox >= thr1))-1;
        
        %--UPDATE WEIGHT
        delW = zeros(size(W));
        for i = 1:1:size(W,1)
            for j = 1:1:size(W,2)
               delW(i,j) = 0.1*(ax(i) + ay(j)); 
            end
        end
        
        W = W + delW;
        
        % Compute the Energy
        E(count) = - ax'*W*ay ;
         
        % Test for Convergence and quit if true
        if (count > 2 && (E(count) -E(count -1) == 0))
            break;
        else
            count = count + 1;
        end
    end
else
    ax = (ox >= thr1);
    while( count < 100)
        
        %---FORWARD PASS
        oy = W'*ax;
        ay = (oy >= thr2);
        
        %---BACKWARD PASS
        ox = W*ay;
        ax = (ox >= thr1);
        
        %---UPDATE WEIGHT
        delW = zeros(size(W));
        for i = 1:1:size(W,1)
            for j = 1:1:size(W,2)
               delW(i,j) = 0.1*(ax(i) + ay(j)); 
            end
        end
        
        W = W + delW;
        % Compute the Energy
        E(count) = - ax'*W*ay ;
        
        % Test for Convergence and quit if true
        if (count > 2 && (E(count) -E(count -1) == 0))
            break;
        else
            count = count + 1;
        end
    end
end



%% Save the output to result.txt
%
fileID = fopen('result.txt','w');
fprintf(fileID,'%6s %12s\n','ITERATION','ENERGY(E)');
for i = 1:1:numel(E)
    fprintf(fileID,'%6.0f %12.3f\n', i ,E(i)); 
end
fprintf(fileID, '\n Input activation after convergence is:\n');
fprintf(fileID,'%4.0f', ax);
fprintf(fileID, '\n \n Output activation after convergence is:\n');
fprintf(fileID,'%4.0f', ay);
fprintf(fileID, '\n \n Weight W is:\n');
dlmwrite('result.txt',W, '-append','precision','%8.3f');
%type('myFile.txt');
type('result.txt');
fclose(fileID);

% Plot the output
figure(1);
plot(E,'k-x');
title('ENERGY PLOT');
xlabel('Iterations');
ylabel('Energy');

%}
end