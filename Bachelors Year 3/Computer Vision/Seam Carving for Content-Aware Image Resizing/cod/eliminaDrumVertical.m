function img1 = eliminaDrumVertical(img,drum)
%elimina drumul vertical din imagine
%input: img - imaginea initiala
%       drum - drumul vertical
%output img1 - imaginea initiala din care s-a eliminat drumul vertical
img1 = zeros(size(img,1),size(img,2)-1,size(img,3),'uint8');

for i=1:size(img1,1)
        coloana = drum(i,2);
        %copiem partea din stanga
        img1(i,1:coloana-1,:) = img(i,1:coloana-1,:);
        %copiem partea din dreapta
        img1(i,coloana:end,:) = img(i,coloana+1:end,:);
end

end