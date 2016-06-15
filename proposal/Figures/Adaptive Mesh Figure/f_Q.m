% function to create quadric from the normal
%
function Q = f_Q(n,w)

n = n / norm(n);

d = n(:)'*w(:);

nt = [n(:); -d];

Q = nt*nt';