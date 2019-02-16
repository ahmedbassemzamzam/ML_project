function [E2 , Efinal] = LinearRegressionAfterLab( X , T , m , Alpha ,b1,flag,c1)

n=length(X(1,:));
for w=2:n;
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end

n1=length(b1(1,:));
for w1=2:n1;
    if max(abs(b1(:,w1)))~=0
    b1(:,w1)=(b1(:,w1)-mean((b1(:,w1))))./std(b1(:,w1));
    end
end

Y=T{1:m,3}/mean(T{1:m,3});
z= T{m+1:14399,3}/mean(T{m+1:14399,3});
z1=T{14400:17999,3}/mean(T{14400:17999,3});
m1 = length(b1);
Theta=zeros(n,1);
k=1;

E(k)=(1/(2*m))*sum((X*Theta-Y).^2);

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1;
E(k)=(1/(2*m))*sum((X*Theta-Y).^2);
if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <0.0000001;
    R=0;
end
end


E1 = (1/(2*m1))*sum((b1*Theta-z).^2);

E2 = E1-E(end);

if(flag==1)
Efinal = (1/(2*m1))*sum((c1*Theta-z1).^2);

end

figure 
plot(1:k,E,'-r')
xlabel('Number of Iteratons')
ylabel('Error')

end

