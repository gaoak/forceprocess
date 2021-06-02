%%
clear;
%%
clc;
close all;
setPlotParameters;
filename = {...
'Re10k_k1_Ap5_wing.dat', 'Re10k_k1_Ap5_tip.dat',...
'Re10k_k2_Ap5_wing.dat', 'Re10k_k2_Ap5_tip.dat',...
'Re10k_k3_Ap5_wing.dat', 'Re10k_k3_Ap5_tip.dat',...
'Re10k_k1_Ap1_wing.dat', 'Re10k_k1_Ap1_tip.dat',...
'Re10k_k2_Ap1_wing.dat', 'Re10k_k2_Ap1_tip.dat',...
'Re10k_k3_Ap1_wing.dat', 'Re10k_k3_Ap1_tip.dat',...
'Re10k_K1_Ap5_3DH1D.dat', 'Re10k_K2_Ap5_3DH1D.dat', 'Re10k_K3_Ap5_3DH1D.dat',...
'Re10k_K1_Ap1_3DH1D.dat', 'Re10k_K2_Ap1_3DH1D.dat', 'Re10k_K3_Ap1_3DH1D.dat'};
D2K1A1 = 16;
D2K2A1 = 17;
D2K3A1 = 18;
D2K1A5 = 13;
D2K2A5 = 14;
D2K3A5 = 15;

D3K1A5 = 1;
D3K2A5 = 3;
D3K3A5 = 5;
D3K1A1 = 7;
D3K2A1 = 9;
D3K3A1 = 11;

nskip = 5;
nvars = 7;
for ii=1:1:length(filename)
    file{ii} = loadequispacedtimeseries(filename{ii}, nskip, nvars);
    ii
end
%%
for ii=1:1:6
    for nn=2:1:nvars
        file{ii*2-1}.data(:,nn) = file{ii*2-1}.data(:,nn) + file{ii*2}.data(:,nn);
    end
end
%% compare CL
close all;
k=[1., 1., 2., 2., 3., 3.,  ...
   1., 1., 2., 2., 3., 3., ...
    1., 2., 3., 1., 2., 3.];
Fref = [0.5*5, 0.5*5, 0.5*5,  0.5*5, 0.5*5, 0.5*5, ...
        0.5*5, 0.5*5, 0.5*5,  0.5*5, 0.5*5, 0.5*5, ...
    0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
for ii=1:1:length(filename)
    period = pi/k(ii);
    Stime = 0;
    for var=1:1:7
        [tmpmean, tmpstdmean, tmpmaxv, tmpminv, tmpstd, is, ie] =period_mean(Stime, period, file{ii}, var, 1);
        meanv(ii, var) = tmpmean / Fref(ii);
        errov(ii, var) = 3*tmpstdmean / Fref(ii);
        stdv(ii, var) = tmpstd / Fref(ii);
        maxvalue(ii, var) = tmpmaxv / Fref(ii);
        minvalue(ii, var) = tmpminv / Fref(ii);
    end
end
%% plot data
% k 3DA1 2DA1 3DA5 2DA5 error3DA1 error2DA1 error3DA5 error2DA5
%CD
dummy = 99;
dumme = 0;
var = 4;
CD=[1 meanv(D3K1A1,var) meanv(D2K1A1,var) meanv(D3K1A5,var) meanv(D2K1A5,var)  ...
      errov(D3K1A1,var) errov(D2K1A1,var) errov(D3K1A5,var) errov(D2K1A5,var);
    2 meanv(D3K2A1,var) meanv(D2K2A1,var) meanv(D3K2A5,var) meanv(D2K2A5,var)  ...
      errov(D3K2A1,var) errov(D2K2A1,var) errov(D3K2A5,var) errov(D2K2A5,var);
    3 meanv(D3K3A1,var) meanv(D2K3A1,var) meanv(D3K3A5,var) meanv(D2K3A5,var)  ...
      errov(D3K3A1,var) errov(D2K3A1,var) errov(D3K3A5,var) errov(D2K3A5,var)]
var = 7;
CL=[1 meanv(D3K1A1,var) meanv(D2K1A1,var) meanv(D3K1A5,var) meanv(D2K1A5,var)  ...
      errov(D3K1A1,var) errov(D2K1A1,var) errov(D3K1A5,var) errov(D2K1A5,var);
    2 meanv(D3K2A1,var) meanv(D2K2A1,var) meanv(D3K2A5,var) meanv(D2K2A5,var)  ...
      errov(D3K2A1,var) errov(D2K2A1,var) errov(D3K2A5,var) errov(D2K2A5,var);
    3 meanv(D3K3A1,var) meanv(D2K3A1,var) meanv(D3K3A5,var) meanv(D2K3A5,var)  ...
      errov(D3K3A1,var) errov(D2K3A1,var) errov(D3K3A5,var) errov(D2K3A5,var)]