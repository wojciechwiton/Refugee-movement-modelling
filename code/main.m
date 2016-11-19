fileList = dir('../doc/data');
fileList = fileList(3:end);
fileListsize = size(fileList,1);

filePaths = strings(fileListsize,1);

for i=1:fileListsize
   filePaths(i) = fullfile(fileList(i).folder, fileList(i).name);
end

delimiter = ';';

fileID = fopen(filePaths(3));
% field = textscan(fileID, '%s', 8, 'Delimiter', delimiter);
% field = field{1,1};
field = textscan(fileID, '%s%s%s%s%s%s%s%s', 1, 'Delimiter', delimiter);
field = horzcat(field{:});
value = textscan(fileID, '%s%s%s%s%s%s%s%s', 'Delimiter', delimiter);
value = horzcat(value{:});

for i=2:8
    field(i) = strcat('year', field(i));
end

GDP = cell2struct(value, field, 2);