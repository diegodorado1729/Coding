include 'variables.f90'
include "omp_random_module.f90"

Program Ising_exagonal 
Use varia
Use randomize

Implicit none

Integer                        :: i,j,k,t,ll,ll1,ll2,ll3,q
Integer                        :: num_obs, unidad, c1, c2, cc
Real                           :: R, tmp1, tmp2, tmp3
Real                           :: s_m1, s_m2 , rc1, rc2, ener_s
Real                           :: m1, m2

Real, DIMENSION(Nptos)         :: ss_m1, ss_m2, temp_a, ener_ss
Real, DIMENSION(Lz)            :: Js 

character (Len=30)             :: file_name = "spin_conf", str0, str1, str2, str3

Integer(4)                     :: idum 
Integer                        :: mmm
integer,     dimension(8)      :: values     

Integer                        :: count

! Semillas para generador de numeros aleatorios paralelizado para OMP
Do i =0,11
call date_and_time(VALUES=values)
idum = (values(8)+100)*(values(7)+10)*32168 + i*1000
mmm = mzranset(i,521288629,362436069,16163801,idum)
End do

! Extensión nombres archivos de salida
count = command_argument_count()
if(count==0) then
  write(*,*)"error falta argumento"
  stop
endif

do i = 1, count
   call get_command_argument(i,str0)
end do

write(str1,'(I2.2)') Lx
write(str3,'(I3.3)') int(1000*Hmax)

ID="Lx"//trim(str1)//"hp"//trim(str3)//"f"//trim(str0)
ID=trim(ID)

archivo0   = "Setting"//ID//".dat"                ! datos de configuracion
fmag       = "magnetizacion"//ID//".dat"          ! Magnetizacion

!fenergia   = "energia"//ID//".dat"               ! Términos de energía
!fsuscep    = "susceptibilidad"//ID//".dat"       ! Susceptibilidad
!fbinder    = "binder"//ID//".dat"                ! Cumulante de Binder

call save_conf


! Vectores para implementar las condiciones de contorno peridicas.
nnx(0)=Lx
Do i=1,Lx
    nnx(i)=i
Enddo
nnx(Lx+1)=1

nny(0)=Ly
Do i=1,Ly
    nny(i)=i
Enddo
nny(Ly+1)=1

nnz(0)=Lz
Do i=1,Lz
    nnz(i)=i
Enddo
nnz(Lz+1)=1

! Inicializacion interacciones

Do i=1,Lz
    if(mod(i,2) .eq. 0) then
      Js(i) = J22 
    else
      Js(i) = J11 
    end if
Enddo


! Selecciona el tipo de actualización del espín
opt=.true. 


! Lazo para promediar distintas realizaciones: promedio térmico
DO ll3=1,Nsamp !&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 
 if(fc) then
   Temp=Tempmax
 else
   Temp=Tempmin
 endif 

 ! Definimos la configuración inicial aleatoria de los espines en las dos subredes
 Do i=1,Lx
  Do j=1,Ly
   Do k=1,Lz
    sa(i,j,k) = sva(int(3*random(0)+1))   ! espines 1 Ehrenfest   
    sb(i,j,k) = svb(int(3*random(0)+1))   ! espines 1 
   Enddo
  Enddo
 Enddo

 ! Definimos la configuración inicial ordenada los espines en las dos subredes
 Do i=1,Lx
  Do j=1,Ly
   Do k=1,Lz
      if(mod(k,2).eq.0) then  ! suma diferenciada en cada layer 
        sa(i,j,k) =  1      
        sb(i,j,k) =  1   
      else 
        sa(i,j,k) = -1      
        sb(i,j,k) = -1   
      end if
   Enddo
  Enddo
 Enddo

 ! Definimos la configuración ocupación de los espines en las dos subredes
 oa=0
 ob=0
 cc=0
 Do i=1,Lx
  Do j=1,Ly
   Do k=1,Lz

    if(mod(k,2).eq.0) then  ! suma diferenciada en cada layer 
      if(random(0).le.x2) oa(i,j,k) = 1  
      if(random(0).le.x2) ob(i,j,k) = 1  
    else 
      if(random(0).le.x1) oa(i,j,k) = 1  
      if(random(0).le.x1) ob(i,j,k) = 1  
    end if
    !cc=cc+oa(i,j,k)+ob(i,j,k)
    !write(*,*) cc,float(cc)/N
   Enddo
  Enddo
 Enddo

 ! Incializamos a cero los espines que no estan ocupados 
 Do i=1,Lx
  Do j=1,Ly
   Do k=1,Lz
    sa(i,j,k) = sa(i,j,k)*oa(i,j,k)    
    sb(i,j,k) = sb(i,j,k)*ob(i,j,k) 
   Enddo
  Enddo
 Enddo

 ! Calculamos la concentracion de los espines en las layers pares y en las impares
 c1=0
 c2=0
 Do i=1,Lx
  Do j=1,Ly
   Do k=1,Lz
    if(mod(k,2).eq.0) then  ! suma diferenciada en cada layer 
     c2=c2+oa(i,j,k)+ob(i,j,k)
     !write(*,*) c2,2.*float(c2)/N    
    else
     c1=c1+oa(i,j,k)+ob(i,j,k) 
     !write(*,*) c1,2.*float(c1)/N     
    endif
   Enddo
  Enddo
 Enddo
 rc1=2.*float(c1)/float(N)
 rc2=2.*float(c2)/float(N)
 write(*,*)'test: frac=',frac,'x1=',rc1,'x2=',rc2


 ! Si loop=.true. realiza un lazo de histeresis sino una curva de enfriamiento
 if(loop) then

  Temp = Tempmin 

  ! elegimos el campo de termalización:
  if(HT) then
    H=Hmax ! Field cooling 
  else 
    H=0    ! Zero Field cooling 
  end if

  !Termalización templado previo
  Do t=1,10000
     call update
  EndDo

 end if

 ! Lazo para adquirir la  magnetización en función del campo 

 ss_m1 = 0
 ss_m2 = 0
 ener_ss = 0

 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 Do ll1=1,Nptos

  if(loop) then
   if(HT) then
    if(Hmax - 2*ll1*Hmax/Nptos .ge. 0) then
      H = H - 4*Hmax/Nptos
    else
      H = H + 4*Hmax/Nptos
    endif
   else
    if(Nptos/5 .ge. ll1) then
      H = H + 5*Hmax/Nptos
    elseif( (ll1 .ge. Nptos/5).and.(3*Nptos/5.ge.ll1)) then
      H = H - 5*Hmax/Nptos
    else
      H = H + 5*Hmax/Nptos
    endif
   endif
  else
   H=Hmax 
   if(fc) then
     Temp=Temp - (Tempmax-Tempmin)/Nptos
   else
     Temp=Temp + (Tempmax-Tempmin)/Nptos
   endif
  end if

  ! Termalización previa
  Do t=1,tmax
    call update
  EndDo
   
  ! Adquisición de los datos
  s_m1 = 0     
  s_m2 = 0 
  ener_s =0
  Do t=1,tmax
    call update

    if (mod(t,t_mic).eq.0) then
      m1  = 0.
      m2  = 0.
      Do i=1,Lx      
        Do j=1,Ly
          Do k=1,Lz
            if(mod(k,2).eq.0) then  ! suma diferenciada en cada layer 
              m2 = m2 + sb(i,j,k)*ob(i,j,k) + sa(i,j,k)*oa(i,j,k) 
            else
              m1 = m1 + sa(i,j,k)*oa(i,j,k) + sb(i,j,k)*ob(i,j,k)
            end if
          Enddo
        Enddo
      Enddo

      call energia
 
      ener_s=ener_s + ener
      s_m1 = s_m1 + 2*m1/N
      s_m2 = s_m2 + 2*m2/N
   

    endif
  Enddo

  if(loop) then  
    temp_a(ll1) = H        ! campo 
  else
    temp_a(ll1) = temp     ! temperatura 
  endif

  ss_m1(ll1)  = ss_m1(ll1) + (s_m1*t_mic/(float(tmax))) 
  ss_m2(ll1)  = ss_m2(ll1) + (s_m2*t_mic/(float(tmax)))  
  ener_ss(ll1)  = ener_ss(ll1) + (ener_s*t_mic/(float(tmax)))  

 enddo  
 !write(*,*)rr,rr/0.01  ! imprime radio del cono 


 ! Archivos salida de datos
 open (UNIT=20,FILE=fmag)       ! "magnetizacion"//ID//".dat"   mx, my, mz, m vs temperatura
 !write(20,*)"# campo", nx, ny, nz

 Do i=1,Nptos
   write(20,'(6f13.8,2x)')temp_a(i), g12*ss_m1(i)/rc1/ll3, ss_m2(i)/rc2/ll3,  0.5*(g12*ss_m1(i) + ss_m2(i))/ll3, ener_ss(i)/ll3    !!!!ver cambios
  !write(20,'(5f13.8,2x)')temp_a(i), 0.9*ss_m1(i)/ll3, ss_m2(i)/ll3,  (0.9*ss_m1(i) + ss_m2(i))/ll3
 Enddo

 close(20)


ENDDO !&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


Stop

Contains

include 'update_ising_openmp.f90'
include 'energia.f90'


Subroutine save_conf   ! Guarda la configuración del sistema

open (UNIT=13,FILE=archivo0)   ! "HeadID"//ID//".dat" datos de configuracion
!===== Contenido del archivo encabezado =====================
    write(13,*) '# Lx= ',        Lx
    write(13,*) '# Ly= ',        Ly
    write(13,*) '# Lz= ',        Lz
    write(13,*) '# N/2= ',       Lx*Ly*Lz
    write(13,*) '# J11=',        J11
    write(13,*) '# J22=',        J22
    write(13,*) '# J12=',        J12
    write(13,*) '# Da =',        Da
    write(13,*) '# g12 =',       g12 
    write(13,*) '# Hmax=',       Hmax
    write(13,*) '# MCS/pto=',    tmax
    write(13,*) '# t_mic=',      t_mic
    write(13,*) '# Nsamp=',      Nsamp 
    write(13,*) '# T_min=',      tempmin
    write(13,*) '# frac=',       frac
    write(13,*) '# x1=',         x1 
    write(13,*) '# x2=',         x2 
!=============================================================
close(13)

End Subroutine save_conf 




end Program Ising_exagonal 
