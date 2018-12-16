%load('random_k_mat_square1.mat')
load('hetero_8000_k_mat.mat')
load('hetero_8000.mat')
colormap_result = load('output_colormap.txt');
%%
test_8000_hetero_k = hetero_8000_k_mat(:,897:1024)';
test_8000_hetero = all(:,897:1024)';
[ttest_8000_hetero_k, tindex] = sortrows(test_8000_hetero_k,1);
ttest_8000_hetero = test_8000_hetero(tindex,:);
ccolormap_result = colormap_result(tindex,:);
%%
for i = 1:128
fig = figure(1);
subplot(1,4,1)
hetero_k = reshape(ttest_8000_hetero_k(i,:),50,50);
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
hetero_sat = reshape(ttest_8000_hetero(i,:),50,50);
imagesc(hetero_sat)
title('$$Pix2pix colormap$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colorbar
%caxis([0 1])
colormap jet
xlim([0,50])
ylim([0,50])
%%
subplot(1,4,3)
test_output = reshape(ccolormap_result(i,:),50,50);
test_output = test_output./255;
imagesc(test_output')
title('$$ground truth$$','Interpreter','Latex')
axis equal
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
colormap jet
colorbar
%caxis([0 1])
xlim([0,50])
ylim([0,50])

% %%
s = num2str(i);
s = strcat(s,'.png');
saveas(fig,s)

error = hetero_sat - test_output;
RMS(gindex) = sum(sum((error.^2))) ./2500;
end
sum(RMS)/128