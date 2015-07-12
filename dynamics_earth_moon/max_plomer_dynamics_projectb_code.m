clear all;
%clf;
testx1=0;testx2=0;testx3=0;
t0=0; th0 = 0;

%x0 = 5; y0 = 0; z0=0;
%vx0 = 0; vy0 =1.; vz0 = 0.;

x0 =  -356400e3 ; y0 = 0; z0=0;  %x0 is star 1
x0_moon = 356400e3 ; y0_moon = 0; z0_moon=0;  %moon is now star 2!!!!!!!!!!!!

vx0 = 0; vy0 = -80; vz0 = 0.;
vx0_moon = 0; vy0_moon = 0;%-.02*vy0; 
vz0_moon = 0.;


G=6.67300e-11; %m^3 kg^-1 s^-2

roe = 1e3;% kg/m^3
R = 5e5;

m=roe*(4/3)*pi*R^3;  
m_moon = roe*(4/3)*pi*(5*R)^3;

xs=x0;ys=y0;zs=z0;
scale1=200; scale2=2000;

%total_time = input('set the total time = ');
total_time = 10e7;
timestep = 1000;%unit: s
K = 100;
%timestep = input('set the timestep = ');
N = floor(total_time/timestep);
fprintf(1,'The number of frames should be less than %d\n',N);
%K = input ('set the number of frames = ');
if K > N
    fprintf(1,'The number of frames must be less than %d\n',N)
    return
end
time_frame=floor(N/K);

time = t0+timestep*[1:N];
r0 = [x0, y0, z0];
v0 = [vx0, vy0, vz0];

r0_moon = [x0_moon, y0_moon, z0_moon];
v0_moon = [vx0_moon, vy0_moon, vz0_moon];

velo = v0; r = r0; 
dist_sun2e = sqrt (r * r'); 
force1 = [0 0 0];%-G*m*M/dist_sun2e^3 * r0;
r_moon2e = r-r0_moon;
dist_moon2e = sqrt(r_moon2e * r_moon2e');
force2 = -G*m*m_moon/dist_moon2e^3 * r_moon2e;
accel = (force1+force2)/m;

velo_moon = v0_moon; r_moon = r0_moon;
dist_moon = sqrt (r_moon * r_moon'); 
force1 = [0 0 0];%-G*M*m_moon/dist_moon^3 * r0_moon;
r_e2moon = r0_moon-r;
dist_e2moon = sqrt(r_e2moon * r_e2moon');
force2 = -G*m*m_moon/dist_e2moon^3 * r_e2moon;
accel_moon = (force1+force2)/m_moon;
%plot3 (0, 0, 0); plot3 (10, 10, 10); hold on;
plot (0,0); plot (6,6); hold on;
for i=1:N
    t = i * timestep;
    dt = timestep;
    % Leapfrog algorithm
    velo = velo + 0.5 * dt * accel;
    velo_moon = velo_moon + 0.5 *dt*accel_moon;
    r = r + dt * velo;
    r_moon = r_moon + dt*velo_moon;
    dist_sun2e = sqrt (r * r');
    force1 = [0 0 0];%- G*M*m/dist_sun2e^3 * r;
    r_moon2e = r-r_moon; dist_moon2e = sqrt(r_moon2e * r_moon2e');
    force2 = -G*m*m_moon/dist_moon2e^3 * r_moon2e;
    accel = (force1+force2)/m;
    velo = velo + 0.5 * dt * accel;
    %%%%%%%%
    dist_moon = sqrt (r_moon * r_moon'); 
    force1 = [0 0 0];%-G*M*m_moon/dist_moon^3 * r_moon;
    r_e2moon = r_moon-r; dist_e2moon = sqrt(r_e2moon * r_e2moon');
    force2 = -G*m*m_moon/dist_e2moon^3 * r_e2moon;
    accel_moon = (force1+force2)/m_moon;
    %-----------------------------------------
    x=r(1); y=r(2); z=r(3);
    xx=r_moon(1); yy=r_moon(2);
    vx = velo(1); vy = velo(2); vz = velo(3);
    ax = accel(1); ay = accel(2); az = accel(3);
    if mod(i,time_frame)==0
        axis ('equal');
    %plot3(x,y,z,'ro','MarkerEdgeColor','r',...
    %            'MarkerFaceColor','g','LineWidth',2,'MarkerSize',5);
    
    plot(x,y,'ro','MarkerEdgeColor','r',...
                'MarkerFaceColor','g','LineWidth',2,'MarkerSize',5); 
    plot(xx,yy,'ro','MarkerEdgeColor','r',...
                'MarkerFaceColor','g','LineWidth',2,'MarkerSize',2); 
    
                
    hold on;
    %plot3([0 x],[0, y],[0,z]);
   % if xs~=x0 
      % plot3([xs,x],[ys,y],[zs,z],'k') 
   % end;
    
    vx=scale1*vx; vy=scale1*vy;vz=scale1*vz;
    ax=scale2*ax; ay=scale2*ay;az=scale2*az;
    %plot3([x,x+vx*dt],[y,y+vy*dt],[z,z+vz*dt],'b');
    %plot([x,x+vx*dt],[y,y+vy*dt],'b');
    %plot([xs,x],[ys,y],'k');
   % plot3([x,x+ax*dt],[y,y+ay*dt],[z,z+az*dt],'r');
    %plot([x,x+ax*dt],[y,y+ay*dt],'r');
    %hold on;
    
   %if (testx1~=1 & testx2~=1 & testx3~=1)
    %   axis([min_x1 max_x1 min_x2 max_x2 min_x3 max_x3]);
    %end
    
    grid on;
    xlabel('x');ylabel('y');
    zlabel('z');
    drawnow
    %pause(0.2)
    xs=x;ys=y;zs=z;
    end
end


