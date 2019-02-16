ds=datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',17999); 
T=read(ds);  
size(T);
m=round(length(T{:,1})*0.6,0);
U=T{1:m,4:21};
Alpha=.01;
data60per=T{m+1:14399,4:21};
data60per=[ones(3600,1) data60per];
flag=0;
 
X1=[ones(m,1) cos(U.^2)];
DiffInError1= LinearRegressionAfterLab(X1,T,m,Alpha,data60per,flag);
 
X2=[ones(m,1) sin(U.^3)];
DiffInError2=LinearRegressionAfterLab(X2,T,m,Alpha,data60per,flag);
  
X3=[ones(m,1)  exp(U).^-U];
DiffInError3=LinearRegressionAfterLab(X3,T,m,Alpha,data60per,flag);
   
X4=[ones(m,1) U.^6];
DiffInError4=LinearRegressionAfterLab(X4,T,m,Alpha,data60per,flag);
 
Diff=[DiffInError1,DiffInError2,DiffInError3,DiffInError4]
Min=min(Diff)
if Min==DiffInError1;
    theBesthyp=X1;
end
if Min==DiffInError2;
    theBesthyp=X2;
end
if Min==DiffInError3;
    theBesthyp=X3;
end
if Min==DiffInError4;
    theBesthyp=X4;
end

c1=T{14400:17999,4:21};
c1=[ones(3600,1)  c1];
 
n2=length(c1(1,:));

for w2=2:n2;
    if max(abs(c1(:,w2)))~=0
    c1(:,w2)=(c1(:,w2)-mean((c1(:,w2))))./std(c1(:,w2));
    end
 end

flag=flag+1;
FinalResult=LinearRegressionAfterLab(theBesthyp,T,m,Alpha,data60per,c1,flag)
 
 
 