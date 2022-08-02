function spl_graph2d(spline)
figure;
hold on
scatter(spline.coords(:,1), spline.coords(:,2), 'b','filled');

t = linspace(0,1,10000)';
xs = zeros(length(t),2);
for ii = 1:length(t)
    xs(ii,:) = spl_var(spline,t(ii));
end

plot(xs(:,1),xs(:,2));
end