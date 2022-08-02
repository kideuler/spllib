function test
n = 100;
syms t real
r = sin(5*t)/10 + 0.25;
F = [r*cos(t), r*sin(t)]+[0.5,0.5];
F = matlabFunction(F);
t = linspace(0,2*pi-(2*pi/n),n)';
ps = F(t);

spline = SplObject(int32(2));
corners = false(n,1);
%corners([10:10:50]) = true;
spline = spl_init(spline,ps,corners,int32(3));
spl_graph2d(spline)


end