%load('random_k_mat_square1.mat')
load('hetero_8000_k_mat.mat')
load('hetero_8000.mat')
VAE = load('output_VAE.txt');
%%
test_8000_hetero_k = hetero_8000_k_mat(:,897:1024)';
test_8000_hetero = all(:,897:1024)';
[ttest_8000_hetero_k, tindex] = sortrows(test_8000_hetero_k,1);
ttest_8000_hetero = test_8000_hetero(tindex,:);
VVAE = VAE(tindex,:);
for gindex = 1:128
pindex = gindex;
%A = reshape(hetero_8000_k_mat(:,tseed),50,50);
%B = reshape(all(:,seed),50,50)';
hetero_k = reshape(test_8000_hetero_k(gindex,:),50,50);
hetero_sat = reshape(test_8000_hetero(gindex,:),50,50)';
VAE_result = reshape(VAE(gindex,:),50,50)./255;

fig = figure(1);
subplot(1,3,1)
imagesc(hetero_k)
title('$$x$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colorbar
colormap jet
%caxis([0 2000])
xlim([0,50])
ylim([0,50])
%%
subplot(1,3,2)
imagesc(hetero_sat')
title('$$y$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colorbar
%caxis([0 1])
colormap jet
xlim([0,50])
ylim([0,50])
%%
subplot(1,3,3)
imagesc(VAE_result)
title('$$VAE$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colormap jet
colorbar
%caxis([0 1])
xlim([0,50])
ylim([0,50])

%%
% pix_sat = reshape(bb(pindex,:),50,50);
% subplot(1,4,4)
% imagesc(VAE_result)
% %imagesc(test)
% title('$$VAE$$','Interpreter','Latex')
% axis equal
% set(gca,'YTickLabel',[]);
% set(gca,'XTickLabel',[]);
% colormap jet
% colorbar
% %caxis([0 1])
% xlim([0,50])
% ylim([0,50])

%error = hetero_sat - pix_sat;
%RMS(gindex) = sum(sum((error.^2))) ./2500;
s = num2str(pindex);
s = strcat(s,'.png');
saveas(fig,s)
end