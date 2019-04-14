ds = datastore('house_prices_data_training_data (1).csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
data = read(ds);
x = data{:,4:21};
%x = featureNormalize(x);

mumu = mean(x);
stdstd = std(x);
for i=1:18
cdf(i) = normcdf(x(10,i),mumu(i),stdstd(i))
end
cdf = prod(cdf)
if ((cdf>0.999) || (cdf <0.001))
 status = 'anomly'
end