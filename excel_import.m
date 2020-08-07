
function [ multi_array ] = excel_import( excel_file, n )
%Takes the Excel file and creates a a multidimensional array
    %n is the max number of rows

%Listing the sheets in the Excel file
[type,sheetno] = xlsfinfo(excel_file);

%Finding the number of sheets in the file for indexing
k = length(sheetno);

%Loop to save each sheet as a new page in array
for i=1:k
    sheet = xlsread(excel_file,i);
    
    % Find the number of rows in the sheet
    nrow = size(sheet,1);
    
    %Padding the excel tables with rows of zeros to match the max number of
    %rows
    if nrow < n
        diff = n - nrow;
        zrow = zeros(diff,6);
        sheet = [sheet;zrow];
    end
    
    multi_array(:,:,i) = sheet;
    
end
end

