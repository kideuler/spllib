function spline = SplObject(ndims)

if nargin == 0
    spline = struct( ...
        'nnodes', int32(0), ...
        'degree', int32(0), ...
        'coords', coder.typeof(0, [inf, 3], [1 1]), ...
        'xweights', coder.typeof(0, [inf, inf]), ...
        'yweigths', coder.typeof(0, [inf, inf]), ...
        'zweights', coder.typeof(0, [inf, inf]));
else
    coder.inline('always');
    assert(ndims == 2 || ndims == 3, 'Dimensions must be 2 or 3');
    spline.coords = m2cNullcopy(zeros(m2cZero, m2cIgnoreRange(ndims)));
    spline.degree = int32(0);
    spline.nnodes = int32(0);
    spline.xweights = coder.nullcopy(zeros(m2cZero, m2cZero));
    spline.yweights = coder.nullcopy(zeros(m2cZero, m2cZero));
    spline.zweights = coder.nullcopy(zeros(m2cZero, m2cZero));
    coder.cstructname(spline, 'SplObject');
    coder.varsize('spline.coords', [inf, 3], [1 1]);
    coder.varsize( 'spline.xweights', 'spline.yweights', 'spline.zweights', [inf inf], [1 1]);
end
end