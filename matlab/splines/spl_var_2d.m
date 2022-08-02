function xs = spl_var_2d(spline, t)
if t < 0
   t = 1-t; 
end
if t > 1
   t = mod(t,1); 
end
n = (ceil(double(spline.nnodes)*t));
if n == 0
    n = 1;
end
x_j = (t - (n-1)/double(spline.nnodes))*double(spline.nnodes);
vec_ = zeros(spline.degree+1,1);
for i = 1:(spline.degree+1)
   vec_(i) = x_j^(double(i)-1); 
end
xs = [spline.xweights(n,:)*vec_, spline.yweights(n,:)*vec_];
end