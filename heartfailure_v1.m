data = readmatrix("heart_failure_clinical_records_dataset.csv");

for i = 1:length(data)
    if data(i,3) > 999
        data(i,:) = [];
    end
    
    data(i,7) = round(data(i,7));
    
    if data(i,8) > 5
    data(i,:) = [];
    end
end