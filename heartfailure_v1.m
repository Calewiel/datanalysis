%In this project we have data for heart failure patients. some of them died
%and the others did not. we are presented with different types of data for
%the said patients e.g. if they had diabetes or not, how old they were, if
%they had high blood pressure or not etc. 

%Our group will be first cleaning the data to remove the invalid or
%illogical values. If we find a value in any row invalid we are going to
%remove the entire row since that data and any respective data can not be
%used in our analysis.

%importing the excel data file into matlab. the reason why we used
%readtable and not readmatrix is because we wanted the column headers and
%wanted to be able to reference a column with the data name.

data = readtable("heart_failure_clinical_records_dataset.csv");

%rounding the age and platelets columns to int values.

data.age = round(data.age);
data.platelets = round(data.platelets);

%here we are cleaning the serum column data by finding any value which is
%greater than 5 since it looks invalid and then we are removing the whole
%row which had that invalid value.
indices = find(data.serum_creatinine > 5);
data(indices,:) = [];

%here we are cleaning the creatinine column data by finding any value which 
%is greater than 999 since it looks invalid and then we are removing the 
%whole row which had that invalid value.
indices = find(data.creatinine_phosphokinase > 999);
data(indices, :) = [];


% MINI ANALYSIS
%creating a scatter plot between age and platlets count. We can see from
%the data that people between 45-73(approx) have the highest platlet count.
%But we can also see from the graph that most of the people have platlet
%count between 1 to 3.5(approx).
scatter(data.age, data.platelets);
%_______________________________________________________%


%we are creating a variable called "cor_matrix" which we will use now and
%also later in the project to store filtered data so that we can compare
%and analyse the filtered data properly. Now we are creating a matrix with
%"death event, age and smoking"
cor_matrix = [data.DEATH_EVENT data.age data.smoking];

%we are finding all the people who are not dead and removing all the data
%from the matrix for the alive people.
indices = find(cor_matrix(:,1)==0);
cor_matrix(indices,:) = [];

%removing the column which shows the binary value for people being dead. We
%dont need this column anymore. 
cor_matrix(:,1) = [];

%scatter plot between age and smoking. 
scatter(cor_matrix(:,1),cor_matrix(:,2))
xlabel("Age");
ylabel("Smoking(0 = No, 1 = Yes)");


%creating a boxchart between age and smoking
boxchart(cor_matrix(:,2),cor_matrix(:,1))
xlabel("Smoking(0 = No, 1 = Yes)");
ylabel("Age");


% ANALYSIS %

%We did not find any direct relation between age, smoking and the people
%who died. This data is for people who are dead and the data shows that
%people who smoked almost lived as long as the people who did not and
%suffered heart failure.
%_______________________________________________________%

%Now we are creating a matrix with "death event, age and smoking"
cor_matrix = [data.DEATH_EVENT data.age data.smoking];

%we are finding all the people who are dead and removing all the data
%from the matrix for the dead people.
indices = find(cor_matrix(:,1)==1);
cor_matrix(indices,:) = [];

%removing the column which shows the binary value for people being not 
% dead. We dont need this column anymore. 
cor_matrix(:,1) = [];


%scatter plot between age and smoking. 
scatter(cor_matrix(:,1),cor_matrix(:,2))
xlabel("Age");
ylabel("Smoking(0 = No, 1 = Yes)");


%creating a boxchart between age and smoking
boxchart(cor_matrix(:,2),cor_matrix(:,1))
xlabel("Smoking(0 = No, 1 = Yes)");
ylabel("Age");

% ANALYSIS %

%We used the same table elements but this time we compared
%smoking to age for the people who are alive. This data shows us that
%people who did not smoke got to live a bit more than the people who smoked
%and suffered heart failure. The age group for the data remains somewhat
%consistent in both instances. 
%_______________________________________________________%

%creating a matrix with smoking and platelet count
cor_matrix = [data.platelets data.smoking];

%box charting the data.
boxchart(cor_matrix(:,2),cor_matrix(:,1))
xlabel("Smoking(0 = No, 1 = Yes)");
ylabel("Platelet Count")

% ANALYSIS % 
% We found interesting results when we compared platelets and smoking.
% Most of the people who did not smoke had platelet count between 200k to
% 300k but there were a lot of outliers on the high end and low end. But we
% did not see any outliers on the low end and very few on the high end for
% the people who smoked. This shows that smoking effects your creatinine
% levels and prevents them from increasing and decreasing significantly. 
%_______________________________________________________%


%creating a matrix with age and diabetes
cor_matrix = [data.age data.diabetes];

%box charting the data.
boxchart(cor_matrix(:,2),cor_matrix(:,1))
xlabel("Diabetes (0 = No, 1 = Yes");
ylabel("Age")

% ANALYSIS %
%This comparison shows that people who dont have diabetes have a higher age
%range than the ones who do. This could be because diabetes causes other
%health problems is also a factor in heart failure. There are a few
%outliers in people who smoked which were lucky enough to make it long age.
%_______________________________________________________%


%we are creating a box chart here between age and creatinine. We check the
%min and max values of age so that we can categorize the bins accordingly.
%we give labels to the x axis bins and catergorize the bins in 5. 

min(data.age);
max(data.age);
binEdges = 40:15:100;
bins = {'40s','50s','60s','70s','80s+'};
groupAge = discretize(data.age,5,"categorical",bins);
boxchart(groupAge,data.creatinine_phosphokinase)

% ANALYSIS %

%We are unable to make any concrete relation or analysis between age and
%creatinine as creatinine levels seem consistent in all groups. The only
%thing that stands out is people between the age of 60 and 80 seem to have
%lower creatinine levels than the others. 
%_______________________________________________________%

%here we are going to compare age and ejection fraction. We use the same
%method as before.
binEdges = 40:15:100;
bins = {'40s','50s','60s','70s','80s+'};
groupAge = discretize(data.age,5,"categorical",bins);
boxchart(groupAge,data.ejection_fraction)

% ANALYSIS % 

%This data is actually more non consistent than before which gives us an
%idea of comparison. The ejection fraction is increasing as the age
%increases. We can also see that people between the age of 60 and 70 seem
%to have the highest fluctuation in their ejection fraction than the other
%age groups. 
%_______________________________________________________%
