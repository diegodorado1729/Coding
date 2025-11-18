#!/bin/bash 
#
# -- Set openmp as Parallel environment
#$ -pe smp 1 
#
#
#---------------------------------------------------------------
#  Set desired CPU time  (-l h_cpu=hh:mm:ss ) 
#
##$ -l h_rt=0:50:0
#
##$ -l arch=lx26-amd64
#
#---------------------------------------------------------------
#  Set desired output file (for this script and your running job) 
#$ -o sdbd.log
#
#----------------------------------------------------------------
##$ -ckpt blcr
#$  -cwd 
#
#$ -M billoni@famaf.unc.edu.ar -m ea
tmpdir=${SGE_CKPT_DIR}/ckpt.${JOB_ID} 
currcpr=`cat ${tmpdir}/currcpr` 
ckptfile=${tmpdir}/context_${JOB_ID}.$currcpr 
#
#
#----------------------------------------------------------------
#
if [ "$RESTARTED" == "2" ]; then 
    echo "Restarting from $ckptfile" >> restart.log
#    ulimit -s 10240 >> restart.log
#    ulimit -a >> restart.log 
    /usr/bin/cr_restart $ckptfile 
    if [ $? != 0 ]; then
      if [ $? == 255 ]; then
	echo "Restarting Job ${JOB_ID} failed (pid used?)"  >> restart.log 
	echo "chkpt file saved as:         "  >> restart.log 
	echo `pwd`/context_${JOB_ID}.$currcpr >> restart.log 
	cp $ckptfile ./
	echo " "                             >> restart.log 
	echo "you can try a later restart modifying" >> restart.log
	echo "accordingly the submission script." >> restart.log 
      fi
    fi
else 
#---------------------------------------------------------------
#   put here your executable (after ther cr_run command)
#
#
#    ulimit -s unlimited
#      /usr/bin/cr_restart   /home/ckpt/ckpt.476749/context_476749.2
export OMP_NUM_THREADS=$NSLOTS
       ./SID02 100lp
#
#----------------------------------------------------------------
#
fi

