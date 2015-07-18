function fname = report_read(fname,flag,s)

if flag ==1
    chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/any_matrix/';
    fname=sprintf('%sreport.txt',chemin);
    fid=fopen(fname,'a+');
    fclose(fid);
elseif flag == 2
    fid=fopen(fname,'a');

fprintf(fid,'%s \t Im %d \t proj=%d \t sz=%d \n',s.type,s.img_index,s.proj,s.img_sz);
fprintf(fid,'abs=%g \t rel=%g \n\n',s.abs,s.rel);    

    fclose(fid);
end