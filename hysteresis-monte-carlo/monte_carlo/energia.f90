Subroutine energia()

Use varia
Use randomize

Integer        :: ix, iy, iz, id0=1, d, i
Real           :: E1,E2, Delta_E, san, sbn, g

    
!!!! realizamos un paso de Monte Carlo actualizando todos los espines de la red.

ener=0.

Do ix=1, Lx
   Do iy=1, Ly
      Do iz=1, Lz

d= (-1)**iy

!!!!! Cálculo de la energía de una capa sin anisotropia

if(mod(iz,2).eq.0) then
  g=1. 
else
  g= g12  !0.9
end if

E1 = Js(iz)*sa(ix,iy,iz)*( sb(nnx(ix),nny(iy+1),nnz(iz)) + sb(nnx(ix),nny(iy),nnz(iz)) + sb(nnx(ix + d),nny(iy),iz)) 
E1 = E1 - H*g*sa(ix,iy,iz) 

!!!! Interacciones entre capas de la red A

E2 = J12*sa(ix,iy,iz)*(sa(nnx(ix), nny(iy), nnz(iz+1)) + sa(nnx(ix), nny(iy), nnz(iz-1))) 

ener= ener + E1 + E2


d= (-1)**(iy+1)

!!!!! calculo  de la energía de la otra capa sin anisotropia

if(mod(iz,2).eq.0) then
  g=1. 
else
  g=g12  !0.9
end if

E1 = Js(iz)*sb(ix,iy,iz)*( sa(nnx(ix), nny(iy-1), iz) + sa(nnx(ix), nny(iy),iz) + sa(nnx(ix+d), nny(iy), iz)) 
E1 = E1 - H*g*sb(ix,iy,iz) 

!!!! Interacciones entre capas de la red B 

E2 = J12*sb(ix,iy,iz)*(sb(nnx(ix), nny(iy), nnz(iz+1)) + sb(nnx(ix), nny(iy), nnz(iz-1))) 

ener= ener + E1 + E2

End do
  End do
     End do

ener= 0.5*ener/(2*Lx*Ly*Lz) 

return

end subroutine energia 
