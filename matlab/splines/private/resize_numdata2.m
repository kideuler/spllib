function data = resize_numdata2(data, n)
% resize numeric 2D data arrays, where the first dimension is specified in
% data already

coder.inline('always');

m = cast(size(data, 2), 'like', n);
if m == 0
    data = m2cNullcopy(zeros(size(data, 1), m2cIgnoreRange(n), 'like', data));
    return;
end

if n ~= m
    buf_ = m2cNullcopy(zeros(size(data, 1), m2cIgnoreRange(n), 'like', data));
    nn = min(n, m);
    for i = 1:nn
        for j = 1:int32(size(data, 1))
            buf_(j, i) = data(j, i);
        end
    end
    data = buf_;
end

end