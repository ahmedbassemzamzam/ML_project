ds = datastore('heart_DD.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',250);
T = read(ds);
size(T);
 Alpha=.1;
 m=length(T{:,1});
 U=T{:,1:13};

 X=[ones(m,1) U U.^2 U.^3 exp(-U) sin(U)];

n=length(X(1,:));
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end

Y=T{:,14};
Theta=zeros(n,1);
size(X)
size(Theta)
  
k=1;
 
h_theta = sigmoid(X*Theta);
E(k)=(1/(m))*sum(-Y.*log((h_theta))-(1-Y).*log(1-h_theta));

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(h_theta-Y);
h_theta = sigmoid(X*Theta);
k=k+1;
E(k)=(1/(m))*sum(-Y.*log((h_theta))-(1-Y).*log(1-h_theta));


if E(k-1)-E(k)<0
    break
end

q=(E(k-1)-E(k))./E(k-1)
if q <.000001;
    R=0;
end
end
FError=E(end)
plot(E)
