%load('random_k_mat_square1.mat')
load('hetero_8000_k_mat.mat')
load('hetero_8000.mat')
a = load('input_512_unet256.txt');
b = load('output_512_unet256.txt');
%%
[aa,aindex] = sortrows(a,1);
bb = b(aindex,:);
test_8000_hetero_k = hetero_8000_k_mat(:,897:1024)';
test_8000_hetero = all(:,897:1024)';
[ttest_8000_hetero_k, tindex] = sortrows(test_8000_hetero_k,1);
ttest_8000_hetero = test_8000_hetero(tindex,:);
%%
for gindex = 1:128
pindex = gindex;
%A = reshape(hetero_8000_k_mat(:,tseed),50,50);
%B = reshape(all(:,seed),50,50)';
hetero_k = reshape(ttest_8000_hetero_k(gindex,:),50,50);
hetero_sat = reshape(ttest_8000_hetero(gindex,:),50,50);

fig = figure(1);
subplot(1,4,1)
imagesc(hetero_k)
title('$$ground truth k$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colorbar
colormap jet
%caxis([0 2000])
xlim([0,50])
ylim([0,50])
%%
subplot(1,4,2)
%imagesc(B)
input_k = reshape(aa(pindex,:),50,50);
imagesc(input_k)
title('$$pix2pix k$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colorbar
%caxis([0 1])
colormap jet
xlim([0,50])
ylim([0,50])
%%
%vseed = tseed-1;
subplot(1,4,3)
%VAE_result = reshape(VAE(vseed,:),50,50)./255;
imagesc(hetero_sat)
title('$$ground truth$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colormap jet
colorbar
%caxis([0 1])
xlim([0,50])
ylim([0,50])

%%
pix_sat = reshape(bb(pindex,:),50,50);
subplot(1,4,4)
imagesc(pix_sat)
%imagesc(test)
title('$$pix2pix$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colormap jet
colorbar
%caxis([0 1])
xlim([0,50])
ylim([0,50])

error = hetero_sat - pix_sat;
RMS(gindex) = sum(sum((error.^2))) ./2500;
s = num2str(pindex);
s = strcat(s,'.png');
saveas(fig,s)
end
sum(RMS)/128