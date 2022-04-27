for name in *_rms_out_CA.xvg
do
	base=${name%_CA.xvg}
	basenn=${name%_run_rms_out_CA.xvg}
	basennn=${basenn:0 }
	basennnn=${basennn//_/\\_}
	echo $basennnn
gnuplot  -c  "rmsd.p"   $name  $base'_lig.xvg'   $base'.png'  $basennnn


done

for name in *_hbond.xvg 
do
        base=${name%.xvg}
        basenn=${name%_run_hbond.xvg}
        basennn=${basenn:0 }
	basennnn=${basennn//_/\\_}
gnuplot  -c  "hbond.p"   $name   $base'.png'  $basennnn


done



