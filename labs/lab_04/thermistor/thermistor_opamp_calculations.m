syms rt rf ri r1 r2 vdc rd;
Vout = @(rt) (r2/(r1+r2)) * (1+rf/ri)*vdc - rf/ri * (rd/(rt+rd));

diff_rf = diff(Vout, rf);
diff_ri = diff(Vout, ri);
diff_r1 = diff(Vout, r1);
diff_r2 = diff(Vout, r2);
diff_vdc = diff(Vout, vdc);
diff_rd = diff(Vout, rd);
diff_rt = diff(Vout, rt);

rf = 6.8 * 1e3;
ri = 2.2 * 1e3;
r1 = 15 * 1e3;
r2 = 5 * 1e3;
vdc = 5;
rd = 27 * 1e3;
rt = [56.3 168.3] * 1e3;

diff_rf = subs(diff_rf);
diff_ri = subs(diff_ri);
diff_r1 = subs(diff_r1);
diff_r2 = subs(diff_r2);
diff_vdc = subs(diff_vdc);
diff_rd = subs(diff_rd);
diff_rt = subs(diff_rt);

drf = 0.05 * rf;
dri = 0.05 * ri;
dr1 = 0.05 * r1;
dr2 = 0.05 * r2;
dvdc = 0;
drd = 0.05 * rd;
drt = 0.01 * rt;

uncertainty = sqrt((diff_rf.*drf).^2 + (diff_ri.*dri).^2 + (diff_r1.*dr1).^2 + (diff_r2.*dr2).^2 + (diff_vdc.*dvdc).^2 + (diff_rd.*drd).^2 + (diff_rt.*drt).^2);
uncertainty = double(uncertainty)
