function msg_len=embed_2(input,file1,output,key)

P1=imread(input); %读取载体图像
P2=P1; 
P3=P2(:,:,3);
P4=P1;
P4(:,:,:)=255; 
[m,n]=size(P3);
message=fopen(file1,'r');  %读取文本文件
[msg,msg_len]=fread(message,'ubit1'); %将文本文件转换为二进制序列
if msg_len>m*n
    error('嵌入信息量过大');
end
[row,col]=RAND(P3,msg_len,key);  %调用随机间隔函数选取修改的像素点
q=1; %q作为信息嵌入位数计数器

%在图片中嵌入信息
for i=1:msg_len
    P3(row(i),col(i))=bitand(P3(row(i),col(i)),254); %将对应像素点的LSB置为0
    P3(row(i),col(i))=P3(row(i),col(i))+msg(q,1);
    P4(row(i),col(i),:)=0;
    if q==msg_len
        break;
    end
    q=q+1;
end

P2(:,:,3)=P3;
imwrite(P2,output);
figure;
subplot(1,2,1);imshow(P1);title('原图');
subplot(1,2,2);imshow(P2);title('隐藏信息的图像');
figure;imshow(uint8(P4));title('嵌入信息的位置');
