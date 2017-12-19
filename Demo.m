%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This code summarizes the experiments of the paper "Camera-Trap Images
%Segmentation using Multi-Layer Robust Principal Component Analysis". The
%Visual Computer, 2017.
%
%Authors: Jhony Heriberto Giraldo Zuluaga, Augusto Salazar, Alexander
%Gomez, Angélica Diaz Pulido.
%Universidad de Antioquia, Medellín, Colombia.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
currentFolder = pwd;
cd('lrslibrary/');
run('lrs_setup.m');
cd(currentFolder);
%%
clear all;
beta = [0:0.05:1];
%groundPath = '/pathTo/GroundTruthForShare/Ground/'; %Path to Ground path
groundPath = '/home/jhony/Von Humboltd/Segmentation/GroundTruth/Ground/'; %Path to Ground path
listGround = dir(groundPath);
methods = {'EALM','IALM','APG_PARTIAL','APG',...
    'LSADM','NSA1','NSA2'};                         %PCP algorithms
for(h=1:size(beta,2))
    for(i=1:size(methods,2))
        methodPath = ['Beta' num2str(beta(h)) '-LBP-Gray-' methods{1,i} '/'];
        mkdir(methodPath);
        for(j=1:size(listGround,1)-2)
            colorPath = [groundPath listGround(j+2).name '/'];
            listColor = dir(colorPath);
            automaticColorPath = [methodPath listGround(j+2).name '/'];
            mkdir(automaticColorPath);
            M = [];
            imageName = [];
            OriginalImage = {};
            for(k=1:size(listColor,1)-2)
                imageName = listColor(k+2).name;
                imageName = imageName(1:end-4);
                imageNames(k,:) = imageName;
                imagePath = [colorPath listColor(k+2).name];
                image = imread(imagePath);
                image = image(1:2348,:,:);
                image = imresize(image,0.1);
                if(size(image,3) == 3)
                    image = rgb2gray(image);
                end
                OriginalImage{k,1} = image;
                colorOrInfrared = listGround(j+2).name;
                colorOrInfrared = colorOrInfrared(1:3);
                if(strcmp(colorOrInfrared,'Inf'))
                    image = imgaussfilt(image); %Gaussian filter
                end
                nFiltSize = 8;
                nFiltRadius = 1;
                filtR = generateRadialFilterLBP(nFiltSize, nFiltRadius);
                effLBP = efficientLBP(image);   %LBP descriptor
                if(strcmp(colorOrInfrared,'Col'))
                    image = histeq(image);  %Histogram equalization
                end
                resultImg = beta(h)*effLBP + (1-beta(h))*image; %Linear combination
                [vidHeight vidWidth z] = size(image);
                M(:,k) = reshape(resultImg,[],1);
            end
            M = im2double(M);
            out = run_algorithm('RPCA', methods{1,i}, M, []);   %Run PCP algorithm
            segmentedImages = out.O;
            for(l=1:size(segmentedImages,2))
                segmentedImage = reshape(segmentedImages(:,l),vidHeight,vidWidth);
                groundImg = OriginalImage{l,1};
                %%
                %Postprocessing
                imgMedian = medfilt2(segmentedImage, [3 3]);    %Median filter
                se = strel('disk',3);   %Morphological structuring element
                afterOpening = imopen(imgMedian,se);    %Morphological oppening
                bw = activecontour(groundImg,afterOpening,200,'edge','contractionBias',-0.3);   %Active contours
                bw = imclose(bw,se);    %Morphological clossing
                bw = imopen(bw,se);     %Morphological openning
                imwrite(bw,[automaticColorPath imageNames(l,:) '.bmp']);    %Saving the segmented image
            end
        end
    end
end