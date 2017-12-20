function [ACC] = MyCost(X,train,train_labels)
index=find(X~=0);
DT=train(index,:);
Train_labels=train_labels(index);
tree=ClassificationTree.fit(DT,Train_labels);
label_tree=predict(tree,train);
ACC=(sum(label_tree==train_labels))./length(label_tree);
end