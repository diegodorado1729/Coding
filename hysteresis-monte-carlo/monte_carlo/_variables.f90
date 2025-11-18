Module varia

Integer(4),  parameter         :: Lx        =  29          ! debe ser impar 
Integer(4),  parameter         :: Ly        =  30          ! debe ser par 
Integer(4),  parameter         :: Lz        =  30          ! debe ser par 
Integer(4),  parameter         :: N         =  2*Lx*Ly*Lz  !
Logical,     parameter         :: loop      =  .false.     ! tipo curva. .true. lazo de histéresis: .false. curva enfriamiento 
Logical,     parameter         :: HT        =  .false.     ! tipo de lazo. .true. lazo de histéresis con campo enfriamiento. .false. lazo con curva inicial sin campo termalizacion igual a 0. 
Logical,     parameter         :: fc        =  .true.     ! tipo curva. .true. field cooling: .false. zero field cooling 

Integer(4),  parameter         :: t_mic     =  100          ! intervalo que se deja para promediar
Integer(4),  parameter         :: tmax      =  10000        ! tiempo por punto
Integer(4),  parameter         :: Nsamp     =  1           ! Numero de lazos de histeresis orientación aleatoria 


Real,        parameter         :: frac      =  1.00        ! concentracion de espines (1-frac es la conc de vacancias)      

Real,        parameter         :: x2        =  frac        ! x2= frac homogéneo (min) y x2 = 1 heterogéneo máximo (máx)            
Real,        parameter         :: x1        =  2*frac-x2   ! x1 = 2frac-1 hetero (min) y x1 = frac homo (máx)            

Real,        parameter         :: JJ        =  1           ! positivo antiferromagnetico:
Real,        parameter         :: J11       = -1.0*JJ      ! eff: J11=j11*g1^2          ! ferro
Real,        parameter         :: J22       = -0.25*JJ     ! eff: J22=j22*g2^2          ! ferro
Real,        parameter         :: J12       =  0.8*JJ      ! eff: J12=j12*g1*g2         ! antiferro    
Real,        parameter         :: Da        =  0*JJ        ! anisotropia
Real,        parameter         :: g12       =  0.955       ! g1/g2 cociente entre razones giromagneticas       


Real,        parameter         :: Hmax      =  0.002*JJ     ! campo maximo aplicado en el lazo
Real,        parameter         :: Tempmax   =  6*JJ        !
Real,        parameter         :: Tempmin   =  0.05*JJ     !0.01
Integer(4),  parameter         :: Nptos     =  100         ! Número de temperaturas (debe ser menor que 2*Nloop)  
!Real,        parameter         :: acep_rate =  0.46        !
Logical,     parameter         :: opt1      =  .false.     !tipo de actualizacion lazo de histéresis: .false. cono; .true. random


CHARACTER(len=15)              :: ID
CHARACTER(len=39)              :: archivo0, archivofe, archivocr, archivo1, archivo2
CHARACTER(len=39)              :: archivo3, fenergia, fsuscep, fbinder, fmag, spins_cr3, spins_fe, spins_cr4

Real,        parameter         :: pi        =  3.14159265358979323846264338328
Real,        parameter         :: dospi     =  2.*pi

Logical                                        :: opt                     ! variable lógica para establecer el tipo de actualización
Integer,     dimension(0:Lx+1)                 :: nnx                     ! Vector condiciones periodicas 
Integer,     dimension(0:Ly+1)                 :: nny                     ! Vector condiciones periodicas 
Integer,     dimension(0:Lz+1)                 :: nnz                     ! Vector condiciones periodicas 
real,        dimension(Lx,Ly,Lz)               :: sa, sb                  ! Variables de spin de las subredes
integer,     dimension(Lx,Ly,Lz)               :: oa, ob                  ! Ocupación de las subredes 
!real,        dimension(4)                      :: sva=(/-1.5,-0.5,0.5,1.5 /)
!real,        dimension(5)                      :: sva=(/-2,-1,0,1,2 /)
!real,        dimension(6)                      :: svb=(/-2.5, -1.5, -0.5, 0.5, 1.5, 2.5 /)
real,        dimension(3)                      :: sva=(/-1,0,1/)
real,        dimension(3)                      :: svb=(/-1,0,1/)
Real                                           :: rr                        ! cono de actualización
Real                                           :: Temp, H, Hx, Hy, Hz, ener ! Temperatura y campo aplicado en el loop
Integer                                        :: cont1,cont2               ! contadores aceptación

end module
!======================================================
