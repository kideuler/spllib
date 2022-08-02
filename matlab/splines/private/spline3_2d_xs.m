function spline = spline3_2d_xs(spline, xs, corners)

nv = int32(size(xs,1));
if isempty(corners)
    corners = false(nv,1);
end
flat = false(nv,1);
for ii = 1:nv
    flat(ii) = corners(ii) + flat(ii);
    flat(mod(ii-2,nv)+1) = corners(ii) + flat(mod(ii-2,nv)+1);
end
spline.nnodes = nv;
spline.coords = resize_numdata(spline.coords, nv);
spline.xweights = resize_numdata2(spline.xweights, spline.degree+1);
spline.yweights = resize_numdata2(spline.yweights, spline.degree+1);
spline.xweights = resize_numdata(spline.xweights, nv);
spline.yweights = resize_numdata(spline.yweights, nv);

A = eye(nv,nv);
bx = zeros(nv,1);
by = zeros(nv,1);

% matrix and rhs vector assembly
ii = int32(1);
while ii <= nv
    spline.coords(ii,:) = xs(ii,:);
    if flat(ii)
        bx(ii) = (xs(mod(ii,nv)+1,1) - xs(ii,1));
        by(ii) = (xs(mod(ii,nv)+1,2) - xs(ii,2));
        jj = mod(ii,nv)+1;
        if ~flat(jj)
            A(jj,jj) = 2;
            A(jj,ii) = 1;
            bx(jj) = 2*(xs(jj,1) - xs(ii,1));
            by(jj) = 2*(xs(jj,2) - xs(ii,2));
            ii = ii+1;
        end
    else
        A(ii,ii) = 4;
        A(ii,mod(ii-2,nv)+1) = 1;
        A(ii,mod(ii,nv)+1) = 1;
        bx(ii) = 3*(xs(mod(ii,nv)+1,1) - xs(mod(ii-2,nv)+1,1));
        by(ii) = 3*(xs(mod(ii,nv)+1,2) - xs(mod(ii-2,nv)+1,2));
    end
    ii=ii+1;
end

% apply corners like dirichlet boundaey conditions

%A = sparse(A);
Dx = A\bx;
Dy = A\by;
for ii = 1:nv
    if flat(ii)
        spline.xweights(ii,1) = xs(ii,1);
        spline.yweights(ii,1) = xs(ii,2);
        spline.xweights(ii,2) = Dx(ii);
        spline.yweights(ii,2) = Dy(ii);
        spline.xweights(ii,3) = 0;
        spline.yweights(ii,3) = 0;
        spline.xweights(ii,4) = 0;
        spline.yweights(ii,4) = 0;
    else
        spline.xweights(ii,1) = xs(ii,1);
        spline.yweights(ii,1) = xs(ii,2);
        spline.xweights(ii,2) = Dx(ii);
        spline.yweights(ii,2) = Dy(ii);
        spline.xweights(ii,3) = 3*(xs(mod(ii,nv)+1,1)-xs(ii,1)) - 2*Dx(ii) - Dx(mod(ii,nv)+1);
        spline.yweights(ii,3) = 3*(xs(mod(ii,nv)+1,2)-xs(ii,2)) - 2*Dy(ii) - Dy(mod(ii,nv)+1);
        spline.xweights(ii,4) = 2*(xs(ii,1)-xs(mod(ii,nv)+1,1)) + Dx(ii) + Dx(mod(ii,nv)+1);
        spline.yweights(ii,4) = 2*(xs(ii,2)-xs(mod(ii,nv)+1,2)) + Dy(ii) + Dy(mod(ii,nv)+1);
    end
end

end