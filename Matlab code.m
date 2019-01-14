close all;
clear all;

Rc=[0.0745 0.9906 0.1149;0.5866 0.0496 -0.8083;-0.8064 0.1276 -0.5774];
Tc=[-199.2636;-74.3240;898.6327];
P1=[0 180 360 360 360 180 0 0 180;0 0 0 180 360 360 360 180 180;0 0 0 0 0 0 0 0 0];
P2=[0 180 360 360 360 180 0 0 180;0 0 0 180 360 360 360 180 180;-100 -100 -100 -100 -100 -100 -100 -100 -100];
[M,N]=size(P1);
fc=[656.14703 659.31497]; 
cc=[305.83202;252.79393];
kc=[-0.26470 0.20436 -0.00143 0.00014 0];

for i=1:N
%%% Puntos con Z=0 %%%%
Cord_C1=(Rc*P1(:,i))+Tc;
Cord_C1=Cord_C1./Cord_C1(3,1);
Cord_B1(:,i)=([Cord_C1(1,1)*fc(1); Cord_C1(2,1)*fc(2)])+cc;
%%%% Con distorsión radial %%%%
R2_1=((Cord_C1(1,1))^2)+((Cord_C1(2,1))^2);
Const_Kc1=1+(kc(1)*R2_1)+(kc(2)*(R2_1)^2);
Cord_D1=Const_Kc1*[Cord_C1(1,1); Cord_C1(2,1)];
Cord_B1_DR(:,i)=[fc(1)*Cord_D1(1,1);fc(2)*Cord_D1(2,1)]+cc;
%%%% Puntos con Z=-100%%%
Cord_C2=(Rc*P2(:,i))+Tc;
Cord_C2=Cord_C2./Cord_C2(3,1);
Cord_B2(:,i)=([Cord_C2(1,1)*fc(1); Cord_C2(2,1)*fc(2)])+cc;
%%%% Con distorsión radial %%%%
R2_2=((Cord_C2(1,1))^2)+((Cord_C2(2,1))^2);
Const_Kc2=1+(kc(1)*R2_2)+(kc(2)*(R2_2)^2);
Cord_D2=Const_Kc2*[Cord_C2(1,1); Cord_C2(2,1)];
Cord_B2_DR(:,i)=[fc(1)*Cord_D2(1,1);fc(2)*Cord_D2(2,1)]+cc;
end

figure
subplot(2,1,1);plot(Cord_B1(1,:),Cord_B1(2,:),'+');title('Puntos sin distorsión con Zw=0');
subplot(2,1,2);plot(Cord_B2(1,:),Cord_B2(2,:),'+');title('Puntos sin distorsión con Zw=-100');

figure
subplot(2,1,1);plot(Cord_B1_DR(1,:),Cord_B1_DR(2,:),'+');title('Puntos con distorsión con Zw=0');
subplot(2,1,2);plot(Cord_B2_DR(1,:),Cord_B2_DR(2,:),'+');title('Puntos con distorsión con Zw=-100');

figure
subplot(2,1,1);plot(Cord_B1(1,:),Cord_B1(2,:),'+');title('Superpuestas con Z=0');
hold on;
plot(Cord_B1_DR(1,:),Cord_B1_DR(2,:),'r+');
subplot(2,1,2);plot(Cord_B2(1,:),Cord_B2(2,:),'+');title('Superpuestas con Z=-100');
hold on;
plot(Cord_B2_DR(1,:),Cord_B2_DR(2,:),'r+');