clear all;
close all;
clc;

%% Read Mathworks Face Gallery
faceGallery = imageSet('FaceDatabase3', 'recursive');
galleryNames = {faceGallery.Description};
%%displayFaceGallery(faceGallery,galleryNames);

%% Create HoG training features from face gallery
trainingFeatures = zeros(5,10404);
featureCount = 1;

for i=1:size(faceGallery,2)
    for j = 1:faceGallery(i).Count
        sizeNormalizedImage = imresize((read(faceGallery(i),j)),[150 150]);
        xx=extractHOGFeatures(sizeNormalizedImage);
        trainingFeatures(featureCount,:) = extractHOGFeatures(sizeNormalizedImage);
        trainingLabel{featureCount} = faceGallery(i).Description;    
        featureCount = featureCount + 1;
    end
    personIndex{i} = faceGallery(i).Description;
end

%% Create Classifier 
faceClassifier = fitcecoc(trainingFeatures,trainingLabel);
save('/Users/nilesh/workspace/face-detection/myClassifier.mat','faceClassifier')
disp('model created')
%% Read test data
testSet = imageSet('/Users/nilesh/workspace/face-detection/');
figure;
figureNum = 1;
for  i= 1: testSet.Count
    queryImage = read(testSet,i);
    resizedqimage= imresize(queryImage,[150 150]);
    queryFeatures = extractHOGFeatures(rgb2gray(resizedqimage));
    personLabel = predict(faceClassifier,queryFeatures);
    disp(personLabel);
    booleanIndex = strcmp(personLabel, personIndex);
    integerIndex = find(booleanIndex);
    subplot(5,2,figureNum);imshow(queryImage);title('Query Face');
    subplot(5,2,figureNum+1);imshow(read(faceGallery(integerIndex),1));title('Matched Class');
    figureNum = figureNum+2;
    
end