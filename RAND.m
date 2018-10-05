function [row,col]=RAND(matrix,msg_len,key)
%matrix为载体矩阵，msg_len为嵌入信息的长度，key为密钥
[m,n]=size(matrix); %读取矩阵大小

%计算间隔的位数
x1=floor(m*n/msg_len)+1; %floor向下舍入到下一个整数
x2=x1-2;

%生成随机序列
rand('seed',key);
a=rand(1,msg_len); %生成一串长度为msg_len-1的随机数
row=zeros([1 msg_len]); %初始化
col=zeros([1 msg_len]);
r=1;
c=1;
row(1,1)=r;
col(1,1)=c;
for i=2:msg_len
    if a(i)>=0.5
        c=c+x1;
    else
        c=c+x2;
    end
    if c>n
        r=r+1;
        if r>m
            error('载体太小！');
        end
        c=mod(c,n);
        if c==0;
            c=1;
        end
    end
    row(1,i)=r;
    col(1,i)=c;
end

        
