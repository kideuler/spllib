function spline = spl_init(spline, xs_or_mesh, corners, degree)
%spl_init - Initialize/reinitialize an spl object for a set of points or
%mesh
%
%   spl = spl_init(spline, xs_or_mesh)
%   spl = spl_init(spline, xs_or_mesh, corners)
%   spl = spl_init(spline, xs_or_mesh, corners, degree)
%
% PARAMETERS
% ----------
%   spline:        An SplObject instance.
%   xs_or_mesh:    A set of coordinates or an instance of SfeMesh.
%   corners:       Bitmask of size nv x 1 which corresponds to which nodes
%                  have discontinuities in the first derivative. Allows for
%                  the spline to represent corners. (default false).
%   degree:        Degree of the spline (default 3).
%
% RETURNS
% --------
%   spline:        Updated SplObject instance.

%codegen

if isstruct(xs_or_mesh)

end
if nargin < 4 || isempty(degree)
    degree = int32(3);
end


% temporary assertions
assert(degree == 3)
assert(~isstruct(xs_or_mesh));
assert(size(spline.coords,2) == 2);

spline.degree = degree;

if  ~isstruct(xs_or_mesh)
    if degree == 3
        spline = spline3_2d_xs(spline, xs_or_mesh, corners);
    end
end

end