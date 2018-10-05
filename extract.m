function extract_2(output,msg_len,file2,key)
P1=imread(output);
P2=P1(:,:,3);
[m,n]=size(P2);

q=1; %q作为信息嵌入位数计数器，将信息序列写回文本文件
[row,col]=RAND(P2,msg_len,key);  %调用随机间隔函数选取提取信息的像素点

%提取嵌在图片中的信息
for i=1:msg_len
    if bitand(P2(row(i),col(i)),1)==1
        result(q,1)=1;
    else
        result(q,1)=0;
    end
    if q==msg_len
        break;
    end
    q=q+1;
end
frr=fopen(file2,'w');
fwrite(frr,result,'ubit1');
fclose(frr);
          
            
