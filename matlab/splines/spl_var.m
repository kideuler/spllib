function xs = spl_var(spline, param)

if int32(size(param,2)) == 1
    xs = spl_var_2d(spline, param);
else
    assert(int32(size(param,2)) == 2);
    xs = spl_var_3d(spline, param);
end
end