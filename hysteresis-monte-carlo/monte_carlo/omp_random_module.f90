Module randomize

IMPLICIT none 

Contains

function mzran(npar)                     !
integer npar                             !!
integer mzran,mzranset, is,js,ks,ns      !
integer, dimension(0:11) :: auxmzran
integer, dimension(0:11), save :: i = 521288629, j = 362436069, k = 16163801, n = 1131199299                             !

auxmzran(npar) = i(npar)-k(npar)                     !
if(auxmzran(npar).lt.0) auxmzran(npar) = auxmzran(npar) + 2147483579
i(npar) = j(npar)
j(npar) = k(npar)
k(npar) = auxmzran(npar)
n(npar) = 69069*n(npar) + 1013904243
auxmzran(npar) = auxmzran(npar) + n(npar)
mzran = auxmzran(npar) 
return
entry mzranset(npar,is,js,ks,ns)
i(npar) = 1+iabs(is)
j(npar) = 1+iabs(js)
k(npar) = 1+iabs(ks)
n(npar) = ns
mzranset = n(npar)
return
end function mzran

function random(npar)
integer npar
real random
random = .5+.2328306E-9*mzran(npar)
return
end function random

end module randomize
