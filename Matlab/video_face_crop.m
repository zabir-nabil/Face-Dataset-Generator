clc;
clear all;

% Read Video using VideoReader

videoframe = VideoReader('file_name.mp4');
FD = 1;

for idx = 1:FD:videoframe.numberofframes
    
    curframe = read(videoframe,idx);
    savedframe = curframe;
    % figure(1), imshow(curframe), title('Frames');
 
% Face detection using CascadeObjectDetector
 
    uid_prefix = num2str(idx);
    FD_obj = vision.CascadeObjectDetector; 
    BB = step(FD_obj, curframe);
    % figure(2), imshow(curframe), title('Detected Faces');

    for jdx = 1:size(BB,1)
        rectangle('Position',BB(jdx,:),'LineWidth',3,'LineStyle','-','EdgeColor','r');
    end
    
    if size(BB,1) > 0
        imwrite(savedframe, strcat('frames/', uid_prefix, 'frame.jpg'),'jpg');
    end

% crop faces 
   
    fdi_idx = 1;
    for kdx = 1:size(BB,1)
         Fimg = imcrop(curframe, BB(kdx,:));
         
         % figure(3), subplot(2,2,kdx); imshow(Fimg);
         
         fdi_idxs = num2str(fdi_idx);
         imwrite(Fimg, strcat('crops/',uid_prefix, 'crop', fdi_idxs, '.jpg'), 'jpg');
         fdi_idx = fdi_idx + 1;
    end
    
     
end
