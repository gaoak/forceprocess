%%
% clear;
clc;
close all;
setPlotParameters;
filename = {'Re10k_k2_Ap5_wing.dat', 'Re10k_k2_Ap5_tip.dat',...
'Re10k_k2_Ap1_wing.dat', 'Re10k_k2_Ap1_tip.dat',...
'Re10k_k3_Ap1_wing.dat', 'Re10k_k3_Ap1_tip.dat',...
'Re10k_K1_Ap5_3DH1D.dat', 'Re10k_K2_Ap5_3DH1D.dat', 'Re10k_K3_Ap5_3DH1D.dat',...
'Re10k_k2_Ap1_3DH1D.dat', 'Re10k_k3_Ap1_3DH1D.dat'};

nskip = 5;
nvars = 7;
for ii=1:1:length(filename)
    file{ii} = loadequispacedtimeseries(filename{ii}, nskip, nvars);
end
%%
for ii=1:1:3
    for nn=2:1:nvars
        file{ii*2-1}.data(:,nn) = file{ii*2-1}.data(:,nn) + file{ii*2}.data(:,nn);
    end
end
%% compare CL
close all;
k=[2., 2.,   2., 2.,    3., 3.,...
    1., 2., 3., 2., 3.];
Fref = [0.5*5, 0.5*5,   0.5*5, 0.5*5, 0.5*5, 0.5*5, ...
    0.5, 0.5, 0.5, 0.5, 0.5];
for ii=1:1:length(filename)
    period = pi/k(ii);
    Stime = 0;
    for var=1:1:7
        [tmpmean, tmpstdmean, tmpmaxv, tmpminv, tmpstd, is, ie] =period_mean(Stime, period, file{ii}, var, 1);
        meanv(ii, var) = tmpmean / Fref(ii);
        errorv(ii, var) = 3*tmpstdmean / Fref(ii);
        stdv(ii, var) = tmpstd / Fref(ii);
        maxvalue(ii, var) = tmpmaxv / Fref(ii);
        minvalue(ii, var) = tmpminv / Fref(ii);
    end
end
%% plot data
% k 3DA1 2DA1 3DA5 2DA5
%CD
dummy = 99;
var = 4;
CD=[1 dummy        dummy         dummy        meanv(7,var);
 2 meanv(3,var) meanv(10,var) meanv(1,var) meanv(8,var);
 3 meanv(5,var) meanv(11,var) dummy        meanv(9,var)]
var = 7;
CL=[1 dummy        dummy         dummy        meanv(7,var);
 2 meanv(3,var) meanv(10,var) meanv(1,var) meanv(8,var);
 3 meanv(5,var) meanv(11,var) dummy        meanv(9,var)]