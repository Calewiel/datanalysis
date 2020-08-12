% In this project we have data for heart failure patients. some of them died
% and the others did not. we are presented with different types of data for
% the said patients e.g. if they had diabetes or not, how old they were, if
% they had high blood pressure or not etc. 

% Our group will be first cleaning the data to remove the invalid or
% illogical values. If we find a value in any row invalid we are going to
% remove the entire row since that data and any respective data can not be
% used in our analysis. What we are trying to figure out is what factors
% contributed to the death event. E.g. if smoking was a factor in people who
% died etc. 

% importing the excel data file into matlab. the reason why we used
% readtable and not readmatrix is because we wanted the column headers and
% wanted to be able to reference a column with the data name.

data = readtable("heart_failure_clinical_records_dataset.csv");

% rounding the age and platelets columns to int values.

data.age = round(data.age);
data.platelets = round(data.platelets);

% here we are cleaning the serum column data by finding any value which is
% greater than 5 since it looks invalid and then we are removing the whole
% row which had that invalid value. We checked on Google and it states that
% if serum_creatinine is above 5 it is super abnormal. 
indices = find(data.serum_creatinine > 5);
data(indices,:) = [];

% here we are cleaning the creatinine column data by finding any value which 
% is greater than 999 since it looks invalid and then we are removing the 
% whole row which had that invalid value. We checked on Google and it says
% if creatinine_phosphokinase if over 1000 it is super abnormal. 
indices = find(data.creatinine_phosphokinase > 999);
data(indices, :) = [];


% MINI ANALYSIS
% creating a scatter plot between age and platlets count. We can see from
% the data that most of the people have platlet count between 1 to 3.5(approx).

subplot(1,2,1)
scatter(data.age(data.DEATH_EVENT == 1), data.platelets(data.DEATH_EVENT == 1));

subplot(1,2,2)
scatter(data.age(data.DEATH_EVENT == 0), data.platelets(data.DEATH_EVENT == 0));
%_______________________________________________________%


% we are creating a variable called "cor_matrix" which we will use now and
% also later in the project to store filtered data so that we can compare
% and analyse the filtered data properly. Now we are creating a matrix with
% "death event, age and smoking"
cor_matrix = [data.DEATH_EVENT data.age data.smoking];

% we are finding all the people who are not dead and removing all the data
% from the matrix for the alive people.
indices = find(cor_matrix(:,1)==0);
cor_matrix(indices,:) = [];

% removing the column which shows the binary value for people being dead. We
% dont need this column anymore.
cor_matrix(:,1) = [];


diedSmoking = sum(cor_matrix(:,2)==1);
diedNotSmoking = sum(cor_matrix(:,2)==0);

cor_matrix = [data.DEATH_EVENT data.age data.smoking];

% we are finding all the people who are not dead and removing all the data
% from the matrix for the alive people.
indices = find(cor_matrix(:,1)==1);
cor_matrix(indices,:) = [];
cor_matrix(:,1) = [];

notDeadSmoking = sum(cor_matrix(:,2)==1);
notDeadNotSmoking = sum(cor_matrix(:,2)==0);


% ANALYSIS %

% We did not find any direct relation between age, smoking and the people
% who died. As you can see from our calculations we compared the number of
% people who died and did not die while smoking and who did not die while
% smoking and not smoking. Our results show that the people's dead in this 
% dataset do not have a direct relation with smoking. People who actually
% died and did not smoke are higher in number than people who did smoke. So
% according to this set, the myth/fact that smoking causes death is not
% true.
%_______________________________________________________%


% checking the total number of people that died and didn't have have
% anaemia vs those that did vs number of people currently living with
% anaemia
deadAnaemia = sum(data.anaemia == 1 & data.DEATH_EVENT == 1);
DeadNotAnaemia = sum(data.anaemia == 0 & data.DEATH_EVENT == 1);
livingAnaemia = sum(data.anaemia == 1 & data.DEATH_EVENT == 0);
livingNotAnaemia = sum(data.anaemia == 0 & data.DEATH_EVENT == 0);
p = pie([deadAnaemia DeadNotAnaemia livingAnaemia livingNotAnaemia])
ptext = findobj(p, 'Type','text');
percentValue = get(ptext, 'String');
labels = {'people that died anaemic: ','people that died not anaemic: ','anaemic living people: ', 'living people without anaemia: '};
percentValue = percentValue.';
combined = strcat(labels, percentValue);
ptext(1).String = combined(1);
ptext(2).String = combined(2);
ptext(3).String = combined(3);
ptext(4).String = combined(4);

% ANALYSIS %
% deadAnaemia = 46
% DeadNotAnaemia = 50
% livingAnaemia = 83
% from this, we can see that, from the data in this dataset, anaemia is 
% not a factor that contributes to death event because out of the people
% that died, a lower amount of them had anaemia and there are more living
% anaemic people than there are dead.

platNotDead = mean(data.platelets(data.DEATH_EVENT == 0));
platDead = mean(data.platelets(data.DEATH_EVENT == 1));


% ANALYSIS % 
% We compared the platelet count for the people who died and who didn't but
% did not find any significant difference in the values. From this we can
% conclude that the platelet count does not have any impact on people who 
% suffered the death event.
%_______________________________________________________%

cor_matrix = [data.DEATH_EVENT data.diabetes];
notDeadHadDiab = sum(cor_matrix(:,1)==0 & cor_matrix(:,2)==1);
notDeadNoDiab = sum(cor_matrix(:,1)==0 & cor_matrix(:,2)==0);

deadHadDiab = sum(cor_matrix(:,1)==1 & cor_matrix(:,2)==1);
deadNoDiab =sum(cor_matrix(:,1)==1 & cor_matrix(:,2)==0);


% ANALYSIS %
% We find from the data that is no direct relation between having diabetes
% and death because the people who had diabetes and died is almost the same
% as people who died and did not have diabetes. Our conclusion is that in
% the event of a heart failure both people with and without diabetes have
% the same probabibility to die. 
%_______________________________________________________%


% we are creating a box chart here between age and creatinine. We check the
% min and max values of age so that we can categorize the bins accordingly.
% we give labels to the x axis bins and catergorize the bins in 5. 
subplot(1,2,1)
min(data.age);
max(data.age);
binEdges = 40:15:100;
bins = {'40s','50s','60s','70s','80s+'};
groupAge = discretize(data.age(data.DEATH_EVENT == 0),5,"categorical",bins);
boxchart(groupAge,data.creatinine_phosphokinase(data.DEATH_EVENT == 0))
% running this for the second plot that relates to 
subplot(1,2,2)
min(data.age(data.DEATH_EVENT == 1));
max(data.age(data.DEATH_EVENT == 1));
binEdges = 40:15:100;
bins = {'40s','50s','60s','70s','80s+'};
groupAge = discretize(data.age(data.DEATH_EVENT == 1),5,"categorical",bins);
boxchart(groupAge,data.creatinine_phosphokinase(data.DEATH_EVENT == 1))
% ANALYSIS %

% We were trying to figure out what relation is between age and creatinine
% levels and how it would effect the death event but we were unable to find
% any substatial change in data within different age groups. Creatinine
% levels seems to be consistent throughout hence proving that creatinine
% levels dont increase or decrease with age even within the people that
% died
%_______________________________________________________%

% here we are going to compare age and ejection fraction. We use the same
% method as before.

subplot(1,2,1)
min(data.age);
max(data.age);
binEdges = 40:15:100;
bins = {'40s','50s','60s','70s','80s+'};
groupAge = discretize(data.age(data.DEATH_EVENT == 0),5,"categorical",bins);
boxchart(groupAge,data.ejection_fraction(data.DEATH_EVENT == 0))
% running this for the second plot 
subplot(1,2,2)
min(data.age(data.DEATH_EVENT == 1));
max(data.age(data.DEATH_EVENT == 1));
binEdges = 40:15:100;
bins = {'40s','50s','60s','70s','80s+'};
groupAge = discretize(data.age(data.DEATH_EVENT == 1),5,"categorical",bins);
boxchart(groupAge,data.ejection_fraction(data.DEATH_EVENT == 1))

% ANALYSIS % 

% We tried to analyze a relation between age and ejection fraction but we
% were again unable to find any relation. The data seems mostly consistent.
%_______________________________________________________%

% this fetches all the averages for the different non-binary factors that
% are within the dataset and then we analyze the data of the people that died 
% by comparing their total averages to those ofliving people and total average to see 
% which factors are predominantly above average which will indicate a correlation with death  

totalAverages = [mean(data.age) mean(data.creatinine_phosphokinase) mean(data.ejection_fraction) mean(data.platelets) mean(data.serum_creatinine) mean(data.serum_sodium)];
averagesOfDead = [mean(data.age(data.DEATH_EVENT > 0)) mean(data.creatinine_phosphokinase(data.DEATH_EVENT > 0)) mean(data.ejection_fraction(data.DEATH_EVENT > 0)) mean(data.platelets(data.DEATH_EVENT > 0)) mean(data.serum_creatinine(data.DEATH_EVENT > 0)) mean(data.serum_sodium(data.DEATH_EVENT > 0))];
averagesOfLiving = [mean(data.age(data.DEATH_EVENT == 0)) mean(data.creatinine_phosphokinase(data.DEATH_EVENT == 0)) mean(data.ejection_fraction(data.DEATH_EVENT == 0)) mean(data.platelets(data.DEATH_EVENT == 0)) mean(data.serum_creatinine(data.DEATH_EVENT == 0)) mean(data.serum_sodium(data.DEATH_EVENT == 0))];

plotMat = [totalAverages; averagesOfDead; averagesOfLiving];


% ANALYSIS %
% We just compared the averages of the original data set for the non binary
% values with the average of dead and living respectively. We can see that
% average of the living is actually much lower than the others and their
% average of the creatinine levels is also lower than the others. We also
% noticed that the average age of the dead is higher than that of the
% living. The one main significant difference is in serum creatinine(SC). The
% people who died seem to have a 50% higher SC than the one who are living.
% This shows us that high SC is likely a direct factor for causing a death
% event if heart failure happens. 

%_______________________________________________________%


% average age for men who died, smoked, had diabetes and high blood pressure
% here, we are considering the sex column has the value of 1 for males
males = mean(data.age(data.sex == 1 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 1));
% average age for women who died, smoked, had diabetes and high blood pressure
% here, we are considering the sex column has the value of 1 for males
females = mean(data.age(data.sex == 0 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 1));

% ANALYSIS % 
% males = 68
% females = 50
% this shows that the average of the dead men who smoked, had diabetes and
% high blood pressure is higher than that of women. This data proves that
% men with the above mentioned conditions live longer than women with the
% same conditions. 
%_______________________________________________________%


% same as above but for people who didn't die.
notDeadMales = mean(data.age(data.sex == 1 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 0));
notDeadFemales = mean(data.age(data.sex == 0 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 0));

% ANALYSIS %
% notDeadMales = 68
% notDeadFemales = 0
% this data shows that women who smoked, had diabetes and high blood
% pressure all died in the event of a heart failure where as 68 men survived
% who had the same conditions. 
%_______________________________________________________%


% total count for the people that fall into the categories that we have
% selected above 
countMales = sum(data.sex == 1 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 1);
countFemales =  sum(data.sex == 0 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 1);
countNotDeadMales = sum(data.sex == 1 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 0);
countNotDeadFemales = sum(data.sex == 0 & data.smoking == 1 & data.diabetes == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 0);

% ANALYSIS %
% countMales = 4
% countFemales = 1
% countNotDeadMales = 6
% countNotDeadFemales = 0

% we calculated the number of males and females who died and had all the
% binary health conditions in the data set. More males died than females.
% But also more males survived than females in this data set. Through this
% we can conclude that the number of males is higher in this data set than
% women, also that women have a higher mortality rate than men with the
% above mentioned health conditions. Due to the fact that the total number
% of men in this dataset dwarfs the total number of women, it would skew
% the analysis of the dataset for specific factors affecting the different 
% genders.
%_______________________________________________________%


% pie chart for descriptive analysis for the males who died, smoked, had
% diabetes and high blood pressure in relation to the total number of dead
% males

allDeadMales = sum(data.sex == 1 & data.DEATH_EVENT == 1);
pieValues = [sum(data.sex == 1 & data.smoking == 1 & data.DEATH_EVENT == 1) sum(data.sex == 1 & data.diabetes == 1 & data.DEATH_EVENT == 1)  sum(data.sex == 1 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 1)];
labels = {'males that died and smoked','males that died and had diabetes','males that died and had high blood pressure'};
pie(pieValues,labels)

% pie chart for descriptive analysis for the females who died, smoked, had
% diabetes and high blood pressure in relation to the total number of dead
% females 

allDeadFemales = sum(data.sex == 0 & data.DEATH_EVENT == 1);
pieValues = [sum(data.sex == 0 & data.smoking == 1 & data.DEATH_EVENT == 1)  sum(data.sex == 0 & data.diabetes == 1 & data.DEATH_EVENT == 1)  sum(data.sex == 0 & data.high_blood_pressure == 1 & data.DEATH_EVENT == 1)];
labels = {'Females that died and smoked','Females that died and had diabetes','Females that died and had high blood pressure'};
pie(pieValues, labels);

 

% CONCLUSIVE ANALYSIS
% In attempting to answer our main question "what factors contribute to
% death in the event of heart failure" within this dataset,
% 
% -1st: we first tried to find correlation between smoking and death in which we discovered that
% people who died and did not smoke are higher in number than people who
% died and smoked.
% 
% -2nd: we tried to find whether the amount of platelets in people
% who had heart failure correlates with the event of death. We found out
% that the platelet count did not have any effect on death. 
% 
% -3rd: we worked on diabetes by comparing the number of people who
% died with the number of living in relation to whether or not they had diabetes. We
% discovered that the people who have heart failure have the same
% probability of dying regardless of whether or not they have diabetes.
%
% -4th: we compared the creatinine and ejection fraction levels to age in
% order to figure out if there is any direct relation between age,
% creatinine and ejection fraction levels for dead and living people. As
% you can see from the charts people who died seemed to have lower
% creatinine levels than those of alive people. People who are alive also
% had more outliers on the top end as compared to dead people. We can
% easily conclude from this that if someone has high creatinine levels they
% are more likely to survive the heart failure. As for the ejection
% fraction, the results are flipped. The dead hadejection fraction levels 
% with more fluctuation. The highs and lows of dead people are more towards
% the higher and lower end of the graphs. We can conclude that having a
% stable ejection fraction will help survive the heart failure.
%
% -5th: We just compared the averages of the original data set for the non binary
% values with the average of dead and living respectively. We can see that
% average of the living is actually much lower than the others and their
% average of the creatinine levels is also lower than the others. We also
% noticed that the average age of the dead is higher than that of the
% living. The one main significant difference is in serum creatinine(SC). The
% people who died seem to have a 50% higher SC than the one who are living.
% This shows us that high SC is likely a direct factor for causing a death
% event if heart failure happens.
