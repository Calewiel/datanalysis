data = readmatrix("heart_failure_clinical_records_dataset.csv");

data(:,7) = round(data(:,7));

indices = find(data(:,3) > 999);
data(indices, :) = [];

indices = find(data(:,8) > 5);
data(indices,:) = [];


%creating a scatter plot between age and platlets count. We can see from
%the data that people between 45-73(approx) have the highest platlet count.
%But we can also see from the graph that most of the people have platlet
%count between 1 to 3.5(approx).
scatter(data(:,1), data(:,7));




cor_matrix = [data(:,13) data(:,3) data(:,9)];

indices = find(cor_matrix(:,1)==0);

cor_matrix(indices,:) = [];
    
