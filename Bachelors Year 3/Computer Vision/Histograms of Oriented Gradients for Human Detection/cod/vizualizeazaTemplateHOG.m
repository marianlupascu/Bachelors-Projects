function vizualizeazaTemplateHOG(parametri)

numarCeluleHOG = sqrt(length(parametri.w) / parametri.dimensiuneDescriptorCelula);
imhog = vl_hog('render', single(reshape(parametri.w, [numarCeluleHOG numarCeluleHOG parametri.dimensiuneDescriptorCelula])), 'verbose') ;
figure(2); imagesc(imhog) ; colormap gray; set(2, 'Color', [.988, .988, .988])
pause(2)
hog_template_image = frame2im(getframe(2));
mkdir([parametri.numeDirectorSalveazaFisiere  'vizualizari']);
imwrite(hog_template_image, [parametri.numeDirectorSalveazaFisiere  'vizualizari/templateHOG.png'])
pause(1);
%close all;