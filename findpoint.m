function [ output ] = findpoint( table,pressure,temp )
%FindPoint Looking through the tables and interpolating
%   Detailed explanation goes here

%Number of pages in array
n = size(table,3);

%Number of rows on each page
rowno = size(table,1);

for i=1:n
    %Going through the pages of the array to find the nearest pressure less
    % than the input pressure
    
    if pressure <= table(1,1,i) 
        %Going through rows to check for the nearest pressure greater than
        %the input pressure
        
         for j =1:rowno   
            if temp <= table(j,2,i-1)
                
                %Saving the properties for the rows above and below the
                %input temperature
                
                output(1,:) = table(j-1,:,i-1);
                output(2,:) = table(j,:,i-1);
                
                %Using break command to exit the foor loop after getting
                %the desired output
                
                break
            end
         end
      
         %Repeating for the next pressure table to get the other two 
         %temperature and the corresponding properties 
         
        for j =1:rowno   
            if temp <= table(j,2,i)
                output(3,:) = table(j-1,:,i);
                output(4,:) = table(j,:,i);
                return
            end
        end
         
       
    end
                
end

