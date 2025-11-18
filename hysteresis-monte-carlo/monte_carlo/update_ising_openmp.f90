Subroutine update()

Use varia
Use randomize

Integer        :: ix, iy, iz, id0=1, d, i
Real           :: E1,E2, Delta_E, san, sbn, g

    
!!!! realizamos un paso de Monte Carlo actualizando todos los espines de la red.

Do i=1, Lx*Ly*Lz

ix = int(Lx*random(id0)+1)
iy = int(Ly*random(id0)+1)
iz = int(Lz*random(id0)+1)

if(oa(ix,iy,iz)==0) goto 10


d= (-1)**iy

!!!!! Variación de la energía

!!!!! primeros vecinos red A: interactuan las dos subredes 

san = sva(int(3*random(id0)+1))  ! sorteamos el nuevo valor para el espin A (S_A = 2)
!san = sva(int(4*random(id0)+1))  ! sorteamos el nuevo valor para el espin A

if(mod(iz,2).eq.0) then
  g=1. 
else
  g= g12  !0.9
end if

E1 = Js(iz)*(san - sa(ix,iy,iz))*( sb(nnx(ix),nny(iy+1),nnz(iz)) + sb(nnx(ix),nny(iy),nnz(iz)) + sb(nnx(ix + d),nny(iy),iz)) 
E1 = E1 - H*g*(san-sa(ix,iy,iz)) - Da*(san**2 - sa(ix,iy,iz)**2) 

!!!! Interacciones entre capas de la red A

E2 = J12*(san - sa(ix,iy,iz))*( sa(nnx(ix), nny(iy), nnz(iz+1)) + sa(nnx(ix), nny(iy), nnz(iz-1))) 


!Algoritmo de Metrópolis

    Delta_E  = E1 + E2 

    If (Delta_E.lt.0) then
        sa(ix,iy,iz) = san
       cont1 = cont1+1
    else
       If (random(id0).lt.exp(-Delta_E/Temp)) then
        sa(ix,iy,iz) = san
       cont2 = cont2+1
       Endif
    Endif


10 continue


ix = int(Lx*random(id0)+1)
iy = int(Ly*random(id0)+1)
iz = int(Lz*random(id0)+1)

if(ob(ix,iy,iz)==0) cycle 

d= (-1)**(iy+1)

!!!!! Variación de la energía
!!!!! primeros vecinos red B: interactuan las dos subredes 

sbn = svb(int(3*random(id0)+1))  ! sorteamos el nuevo valor para el espin B 

if(mod(iz,2).eq.0) then
  g=1. 
else
  g=g12  !0.9
end if

E1 = Js(iz)*(sbn - sb(ix,iy,iz))*( sa(nnx(ix), nny(iy-1), iz) + sa(nnx(ix), nny(iy),iz) + sa(nnx(ix+d), nny(iy), iz)) 
E1 = E1 - H*g*(sbn-sb(ix,iy,iz))

!!!! Interacciones entre capas de la red B 

E2 = J12*(sbn - sb(ix,iy,iz))*( sb(nnx(ix), nny(iy), nnz(iz+1)) + sb(nnx(ix), nny(iy), nnz(iz-1))) 


!Algoritmo de Metrópolis

    Delta_E  = E1 + E2 

    If (Delta_E.lt.0) then
        sb(ix,iy,iz) = sbn
       cont1 = cont1 + 1
    else
       If (random(id0).lt.exp(-Delta_E/Temp)) then
        sb(ix,iy,iz) = sbn
        cont2 = cont2 + 1
       Endif
    Endif

  End do

return

end subroutine update
