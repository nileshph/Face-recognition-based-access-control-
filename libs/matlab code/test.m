function [outputArg1] = test(inputArg1)
%#function ClassificationTree % declares which "predict" function to use
%TEST Summary of this function goes here
%   Detailed explanation goes here;
load('/Users/nilesh/workspace/face-detection/myClassifier.mat')
testSet = imageSet('/Users/nilesh/workspace/face-detection/faces');
figureNum = 1;
for  i= 1: testSet.Count
    queryImage = read(testSet,i);
    resizedqimage= imresize(queryImage,[150 150]);
    queryFeatures = extractHOGFeatures(rgb2gray(resizedqimage));
    personLabel = predict(faceClassifier,queryFeatures);
    %%disp(personLabel);
    %%booleanIndex = strcmp(personLabel, personIndex);
    %%integerIndex = find(booleanIndex);
    %%subplot(5,2,figureNum);imshow(queryImage);title('Query Face');
    %%subplot(5,2,figureNum+1);imshow(read(faceGallery(integerIndex),1));title('Matched Class');
    figureNum = figureNum+2;
    
end

outputArg1 = personLabel;

end

