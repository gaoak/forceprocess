%%
% clear;
clc;
close all;
setPlotParameters;
filename = {'coarse/wing.dat', 'fine/wing.dat', 'coarse/tip.dat', 'fine/tip.dat',...
    'MeanForce/Re10k_K2_Ap5_2D.dat', 'MeanForce/Re10k_K2_Ap5_3DH1D_coarse.dat', 'MeanForce/Re10k_K2_Ap5_3DH1D.dat',...
    'MeanForce/Re10k_K1_Ap5_3DH1D.dat', 'MeanForce/Re10k_K3_Ap5_3DH1D.dat'};
nskip = 5;
nvars = 10;
for ii=1:1:length(filename)
    file{ii} = loadequispacedtimeseries(filename{ii}, nskip, nvars);
end
for ii=1:1:2
    for nn=2:1:nvars
        file{ii}.data(:,nn) = file{ii}.data(:,nn) + file{ii+2}.data(:,nn);
    end
end
%%
Tref = pi/2;
Fref = 0.5 * 5;
figure
plot(file{1}.data(:,1)/Tref, file{1}.data(:,4)/Fref, 'r--')
hold on
plot(file{2}.data(:,1)/Tref, file{2}.data(:,4)/Fref, 'k-')
xlabel('t/T','FontName','Times New Roman', 'FontAngle', 'normal')
ylabel('C_D', 'FontName', 'Times New Roman', 'FontAngle', 'italic')
axis([0 4 -2 2])
text(3.5, 1.5,' a ','FontName','Times New Roman', 'FontSize', 20, 'FontAngle', 'italic')
text(3.48, 1.5,'(  )','FontName','Times New Roman', 'FontSize', 20, 'FontAngle', 'normal')
saveas(gcf, 'validationCD.png')
figure
plot(file{1}.data(:,1)/Tref, file{1}.data(:,7)/Fref, 'r--')
hold on
plot(file{2}.data(:,1)/Tref, file{2}.data(:,7)/Fref, 'k-')
xlabel('t/T','FontName','Times New Roman', 'FontAngle', 'normal')
ylabel('C_L', 'FontName', 'Times New Roman', 'FontAngle', 'italic')
axis([0 4 -9 9])
yticks([-9:3:9])
text(3.5, 6.75,' b ','FontName','Times New Roman', 'FontSize', 20, 'FontAngle', 'italic')
text(3.48, 6.75,'(  )','FontName','Times New Roman', 'FontSize', 20, 'FontAngle', 'normal')
saveas(gcf, 'validationCL.png')
%% compare CL
close all;
clear meanv;
k=[2., 2., 2., 2., 2., 2., 2., 1., 3.];
Fref = [0.5*5, 0.5*5, 0.5*5, 0.5*5, 0.5, 0.5, 0.5, 0.5, 0.5];
for ii=1:1:length(filename)
    period = pi/k(ii);
    Stime = 0.5*period;
    for var=1:1:7
        [tmpmean, tmpstdmean, tmpmaxv, tmpminv, tmpstd, is, ie] =period_mean(Stime, period, file{ii}, var, 1);
        meanv(ii, var) = tmpmean / Fref(ii);
        errorv(ii, var) = 3*tmpstdmean / Fref(ii);
        stdv(ii, var) = tmpstd / Fref(ii);
        maxvalue(ii, var) = tmpmaxv / Fref(ii);
        minvalue(ii, var) = tmpminv / Fref(ii);
    end
end