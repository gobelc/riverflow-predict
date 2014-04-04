function s = parameterfun(x,delta,y,r,n,m)

a=zeros(1,n);
b=zeros(1,m);

for j=1:n
    a(j)=x(1,j);
end

for l=1:m;
    b(l)=x(2,l);
end

gamma=x(3,1);


for t=(delta+n+m):length(y)
    s(t) = y(t)+a*y(t-n:t-1)-b*y(t-m-delta+1:t-delta).^(gamma)*r(t-delta);
end