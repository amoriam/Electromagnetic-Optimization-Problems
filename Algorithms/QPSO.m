function y=QPSO(MaxIter,SwarmSize,ParticleSize,ParticleScope,ObjectiveFunction)
%%
%clear
%clc
%下面定义算法变量
%QPSO.QPSO.SwarmSize     ---> 种群的规模，即搜索空间中的粒子总数(N)
%QPSO.QPSO.ParticleSize  ---> 粒子的维度，即相互独立的优化变量总数(M)
%QPSO.QPSO.ParticleScope ---> 粒子定义域，即每个独立变化变量的定义域(Mx2阶矩阵)
%QPSO.QPSO.MaxIter       ---> 最大迭代次数
%%
QPSO.MaxIter=MaxIter;%1500;
QPSO.SwarmSize=SwarmSize;%20;
QPSO.ParticleSize=ParticleSize;%20;
QPSO.ParticleScope=ParticleScope;%repmat([-100 100],QPSO.ParticleSize,1)';
%QPSO.ParticleScope=[-3 3;-1 2;-5 5]';
%%
SizeOfPS=size(QPSO.ParticleScope);
if SizeOfPS(2)~=QPSO.ParticleSize||SizeOfPS(1)~=2
    error('Check your input of QPSO.ParticleScope.');
end
%%
QPSO.Current.Loc=zeros(QPSO.SwarmSize,QPSO.ParticleSize);
QPSO.Current.Value=zeros(QPSO.SwarmSize,1);
QPSO.Pbest.Loc=zeros(QPSO.SwarmSize,QPSO.ParticleSize);
QPSO.Pbest.Value=zeros(QPSO.SwarmSize,1);
QPSO.Gbest.Loc=zeros(1,QPSO.ParticleSize);
QPSO.Gbest.Value=zeros(1,1);
QPSO.mbest.Loc=zeros(1,QPSO.ParticleSize);
QPSO.mbest.Value=zeros(1,1);
QPSO.Fi=zeros(1,QPSO.ParticleSize);
QPSO.U=zeros(1,QPSO.ParticleSize);
QPSO.Beta=zeros(1,1);
QPSO.result.Loc=zeros(QPSO.MaxIter,QPSO.ParticleSize);
QPSO.result.Value=zeros(QPSO.MaxIter,1);

%%
QPSO.ObjectiveFunction=ObjectiveFunction;
% definition of objective function
% mySphere ---> sphere function,,,[(0,0,...,0) >> 0]
% myRosenbrock ---> Rosenbrock function,,,[(1,1,...,1) >> 0]
% myRastrigin ---> Rastrigin function,,,[(0,0,...,0) >> 0]
% myGriewank ---> Griewank function,,,[(0,0,...,0) >> 0]
% myAckley ---> Ackley function,,,[(0,0,...,0) >> 0]
% myShaffer ---> Shaffer's f6 function,,,[(0,0) >> -1],仅适用于2维
% mySchwefel226 ---> Schwefel 2.26 function,,,[(420.9687,420.9687,...,420.9687) >> -418.9829n]

%%
%
%初始化
%
for i=1:QPSO.SwarmSize
    for j=1:QPSO.ParticleSize
        %全空间初始化
        QPSO.Current.Loc(i,j)=QPSO.ParticleScope(1,j)+( QPSO.ParticleScope(2,j) - QPSO.ParticleScope(1,j) ) * rand();
        %QPSO.Current.Loc(i,j)=15+( 30 - 15 ) * rand();
    end
    QPSO.Current.Value(i,:)=QPSO.ObjectiveFunction(QPSO.Current.Loc(i,:));
end
QPSO.Pbest=QPSO.Current;
tt=find(QPSO.Pbest.Value==min(QPSO.Pbest.Value));
indexOfG=min(tt);
QPSO.Gbest.Loc=QPSO.Pbest.Loc(indexOfG,:);
QPSO.Gbest.Value=QPSO.Pbest.Value(indexOfG,:);

%%
for t=1:QPSO.MaxIter
    %%
    QPSO.Beta=0.5+(1-0.5)*(QPSO.MaxIter-t)/QPSO.MaxIter;
    %QPSO.Beta=1/0.96;
    
    %%
    for i=1:QPSO.ParticleSize
        QPSO.mbest.Loc(1,i)=sum(QPSO.Pbest.Loc(:,i))/QPSO.SwarmSize;
    end
    QPSO.mbest.Value(1,1)=QPSO.ObjectiveFunction(QPSO.mbest.Loc(1,:));
    
    
    
    %%
    for i=1:QPSO.SwarmSize
        QPSO.U=rand(1,QPSO.ParticleSize);
        QPSO.Fi=rand(1,QPSO.ParticleSize);
             
        PP=QPSO.Fi.*QPSO.Pbest.Loc(i,:)+(1-QPSO.Fi).*QPSO.Gbest.Loc(1,:);
        BB=QPSO.Beta*(QPSO.mbest.Loc(1,:)-QPSO.Current.Loc(i,:));
        %BB=QPSO.Beta*(QPSO.Pbest.Loc(i,:)-QPSO.Current.Loc(i,:));
        VV=log(QPSO.U);
        YY=PP+((-1).^ceil(0.5+rand(1,QPSO.ParticleSize))).*BB.*VV;
        QPSO.Current.Loc(i,:)=YY;
        %%
        %截断方法，使得QPSO.Current.Loc不越界
        for j=1:QPSO.ParticleSize
            if QPSO.Current.Loc(i,j)> QPSO.ParticleScope(2,j)
                QPSO.Current.Loc(i,j)=QPSO.ParticleScope(2,j);
            end
            if QPSO.Current.Loc(i,j)< QPSO.ParticleScope(1,j)
                QPSO.Current.Loc(i,j)=QPSO.ParticleScope(1,j);
           end
        end
        %%
        QPSO.Current.Value(i,1)=QPSO.ObjectiveFunction(QPSO.Current.Loc(i,:));
        if QPSO.Current.Value(i,1)<QPSO.Pbest.Value(i,1)
            QPSO.Pbest.Loc(i,:)=QPSO.Current.Loc(i,:);
            QPSO.Pbest.Value(i,1)=QPSO.Current.Value(i,1);
        end
        if QPSO.Pbest.Value(i,1)<QPSO.Gbest.Value(1,1)
            QPSO.Gbest.Loc(1,:)=QPSO.Pbest.Loc(i,:);
            QPSO.Gbest.Value(1,1)=QPSO.Pbest.Value(i,1);
        end             
    end
     QPSO(t,:)=QPSO.Gbest.Loc;
     save('QPSO','QPSO');
    %%
    %记录第i次迭代的全局最优解
    %QPSO.Gbest.Value
    %QPSO.result.Loc(t,:)=QPSO.Gbest.Loc(1,:);
    %QPSO.result.Value(t,1)=QPSO.Gbest.Value(1,1);
    %disp(sprintf('第%d次迭代完成',t));
end
%y=[QPSO.Gbest.Loc QPSO.Gbest.Value];
y=QPSO.Gbest.Value;